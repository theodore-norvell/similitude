package controller.modelManipulationSublayer;
import controller.commandManager.AddComponentCommand;
import controller.commandManager.AddLinkCommand;
import controller.commandManager.AddToConnectionCommand;
import controller.commandManager.AddToSelectionCommand;
import controller.commandManager.ClearSelectionCommand;
import controller.commandManager.CommandManager;
import controller.commandManager.EditLinkCommand;
import controller.commandManager.MoveSelectionCommand;
import controller.commandManager.RemoveLinkCommand;
import controller.commandManager.SwapConnectionsCommand;
import model.component.*;
import model.selectionModel.SelectionModel;
import model.tabModel.TabModel;
import type.Coordinate;
import type.Set;

/**
 * Holds the functions that manipulate the model, through the controller
 * Is a sub-layer and should be considered a child in the Controller
 * @author AdvaitTrivedi
 */
class ModelManipulationSublayer 
{
	var commandManager: CommandManager;

	public function new(commandManager: CommandManager) {
		this.commandManager = commandManager;
	}
	
	public function addComponent(circuitDiagram: CircuitDiagramI, component: Component, ?batch: Bool = false) {
		var addComponentCommand = new AddComponentCommand(circuitDiagram, component);
		this.commandManager.executeCommand(addComponentCommand, batch);
		this.normalise(circuitDiagram, true);
	}
	
	public function addLink(circuitDiagram: CircuitDiagramI, link: Link, ?batch: Bool = false) {
		var addLinkCommand = new AddLinkCommand(circuitDiagram, link);
		this.commandManager.executeCommand(addLinkCommand, batch);
	}
	
	public function editLink(circuitDiagram: CircuitDiagramI, linkEndpoint: Endpoint, x: Float, y: Float, ?batch: Bool = false) {
		var editLinkCommand = new EditLinkCommand(circuitDiagram, linkEndpoint, new Coordinate(x, y));
		this.commandManager.executeCommand(editLinkCommand, batch);
	}
	
	public function removeLink(link: Link, circuitDiagram: CircuitDiagramI, ?batch: Bool = false) {
		var removeLinkCommand = new RemoveLinkCommand(circuitDiagram, link);
		this.commandManager.executeCommand(removeLinkCommand, batch);
	}
	
	public function addToSelection(activeTab: TabModel, clickedObjects: Array<CircuitElement>, ?batch: Bool = false) {
		for (object in clickedObjects) {
			this.commandManager.executeCommand(new AddToSelectionCommand(activeTab.getCircuitDiagram(), activeTab.getSelectionModel(), object), batch);
		};
	}
	
	public function moveSelection(activeTab: TabModel, currentX: Float, currentY: Float, nextX: Float, nextY: Float, ?batch: Bool = false) {
		var moveSelectionCommand = new MoveSelectionCommand(activeTab.getCircuitDiagram(), activeTab.getSelectionModel(), currentX, currentY, nextX, nextY);
		this.commandManager.executeCommand(moveSelectionCommand, batch);
	}
	
	public function clearSelection(circuitDiagram: CircuitDiagramI, selectionModel: SelectionModel, ?batch: Bool = false) {
		var clearSelectionCommand = new ClearSelectionCommand(circuitDiagram, selectionModel);
		this.commandManager.executeCommand(clearSelectionCommand, batch);
	}
	
	public function addToConnection(circuitDiagram: CircuitDiagramI, connection: Connection, connectable: Connectable, ?batch: Bool = false) {
		var addToConnectionCommand = new AddToConnectionCommand(circuitDiagram, connection, connectable);
		this.commandManager.executeCommand(addToConnectionCommand, batch);
	}
	
	public function normalise(circuitDiagram: CircuitDiagramI, ?batch: Bool = false) {
		// For all pairs of connections {c0, c1} such that c0 != c1 and c0 is close to c1
		// if and both contain a port,
			// create a link to connect them
		// else one or both don't contain a port
			// if c0 contains a port, swap c0 and c1
			// move everything in c0 to c1
        trace( "Step 1" ) ;
        var connectionSet: Set<Connection> = circuitDiagram.getConnections() ;
		var alreadyProcessed = new Set<Connection>();
		for (connection in connectionSet.iterator()) {
            alreadyProcessed.push( connection ) ;
			for (otherConnection in connectionSet.iterator()) {
                if ( alreadyProcessed.has( otherConnection ) ) { continue ; }
                //trace( "Considering " + connection + " and " + otherConnection ) ;
                var connectionDistance = Link.pointsDistance(connection.get_xPosition(), connection.get_yPosition(), otherConnection.get_xPosition(), otherConnection.get_yPosition());
				if (connectionDistance <= 5) {
                    // The connections are close. Either we link them or we
                    // merge them.
                    trace( "Found close connections " + connection + " and " + otherConnection ) ;
					if (connection.aPortIsConnected() && otherConnection.aPortIsConnected()) {
                        trace( "Linking them" ) ;
                        // This might create a redundant link.  However redundant links are eliminated later
                        // in normalization. So, we won't worry.
                        var link = new Link(circuitDiagram, connection.get_xPosition(), connection.get_yPosition(),
                                                  otherConnection.get_xPosition(), otherConnection.get_yPosition()) ;
						this.addLink(circuitDiagram, link, batch);
						this.addToConnection(circuitDiagram, connection, link.get_endpoint(0), batch);
						this.addToConnection(circuitDiagram, otherConnection, link.get_endpoint(1), batch);
					} else {
                        trace( "Merging them" ) ;
						if (connection.aPortIsConnected()) {
							this.commandManager.executeCommand(new SwapConnectionsCommand(circuitDiagram, connection, otherConnection), batch);
						}
                        
                        trace( "Merging from " + connection + " to " + otherConnection ) ;
                        var connectables = new Set<Connectable>() ;
                        for( item in connection.get_connectedElements() ) connectables.push(item) ;
						for (item in connectables ) {
                            trace( "Merging " + item ) ;
							this.addToConnection(circuitDiagram, otherConnection, item, batch);
						}
                        trace( "Finished Merging from " + connection + " to " + otherConnection ) ;
					}
				}
			}
		}
		
		// For all connections c and for all links x not connected to c
		// 		If c is not close to either endpoint of x, but is close to x
        // 			Split x into two links each with an endpoint added to c
        trace( "Step 2" ) ;
        var connectionSet: Set<Connection> = circuitDiagram.getConnections() ;
		for (connection in connectionSet.iterator()) {
            //trace( "Considering connection " +connection ) ;
            var removeLinks = new Array<Link>();
            var linkArrayCopy = circuitDiagram.get_linkIterator() ;
			for (link in linkArrayCopy ) {
                //trace( "Considering link " +link ) ;
                var c0 = link.get_endpoint(0).getConnection() ;
                var c1 = link.get_endpoint(1).getConnection() ;
                if( c0 != connection
                &&  c1 != connection ) {
					if ( link.isOnLink( connection.location() ) != null ) {
                        trace( "Connection " +connection+ " will split link " +link ) ;
                        var link1 = new Link(circuitDiagram, c0.get_xPosition(), c0.get_yPosition(),
                                                   connection.get_xPosition(), connection.get_yPosition());
						this.addLink(circuitDiagram, link1, batch);
						this.addToConnection(circuitDiagram, c0, link1.get_endpoint(0), batch);
						this.addToConnection(circuitDiagram, connection, link1.get_endpoint(1), batch);
                        var link2 = new Link(circuitDiagram, connection.get_xPosition(), connection.get_yPosition(),
                                                   c1.get_xPosition(), c1.get_yPosition());
						this.addLink(circuitDiagram, link2, batch);
						this.addToConnection(circuitDiagram, connection, link2.get_endpoint(0), batch);
						this.addToConnection(circuitDiagram, c1, link2.get_endpoint(1), batch);
						removeLinks.push(link);
					}
				}
            }
            // Remove all links split by this connection.
            for (link in removeLinks) {
				this.removeLink(link, circuitDiagram, batch);
                //circuitDiagram.deleteLink(link);
            }
		}
		
		var markedLinks = new Set<Link>();
		
		// For all links x:
		//     If both endpoints are in the same connection:
		//         mark x for deletion
        trace( "Step 3" ) ;
		for (link in circuitDiagram.get_linkIterator()) {
			if (link.get_endpoint(0).getConnection() == link.get_endpoint(1).getConnection()) {
				markedLinks.push(link);
			}
		}
		
		// delete all marked links
		for (link in markedLinks) {
            trace( "Deleting link " +link ) ;
			this.removeLink(link, circuitDiagram, batch);
        }
		
		// For all remaining links x
		// 		If x is not marked for deletion
		// 			For all links y connected to x.endpoint(0) other than x
		// 				If the other end of y connects to x.endpoint(1)
		// 					Mark y for deletion
        trace( "Step 4" ) ;
		markedLinks = new Set<Link>();
		for (link in circuitDiagram.get_linkIterator()) {
            if( markedLinks.has( link ) ) continue ;
			for (otherLink in circuitDiagram.get_linkIterator()) {
				if (link == otherLink) continue ;
				
                if (link.get_endpoint(0).getConnection() == otherLink.get_endpoint(0).getConnection()
                 && link.get_endpoint(1).getConnection() == otherLink.get_endpoint(1).getConnection()) {
					markedLinks.push(otherLink);
				}
				
                if (link.get_endpoint(0).getConnection() == otherLink.get_endpoint(1).getConnection()
                 && link.get_endpoint(1).getConnection() == otherLink.get_endpoint(0).getConnection()) {
					markedLinks.push(otherLink);
				}
			}
		}
		
		// delete all marked links
		for (link in markedLinks) {
            trace( "Deleting link " +link ) ;
			this.removeLink(link, circuitDiagram, batch);
        }
	}
}