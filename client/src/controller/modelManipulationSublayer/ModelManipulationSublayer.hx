package controller.modelManipulationSublayer;
import controller.commandManager.AddComponentCommand;
import controller.commandManager.AddLinkCommand;
import controller.commandManager.AddToConnectionCommand;
import controller.commandManager.ClearSelectionCommand;
import controller.commandManager.CommandManager;
import controller.commandManager.DeleteSelectedComponentsAndLinksCommand;
import controller.commandManager.DisconnectComponentCommand;
import controller.commandManager.DisconnectLinkCommand;
import controller.commandManager.EditLinkCommand;
import controller.commandManager.MoveSelectionCommand;
import controller.commandManager.RemoveLinkCommand;
import controller.commandManager.RotateComponentCommand;
import controller.commandManager.ToggleSelectionCommand;
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

	/**
	 *  Mark the end of a group of changes that will be undone or redone together.
	 */
	public function checkPoint() { this.commandManager.checkPoint() ; }
	
	public function addComponent(circuitDiagram: CircuitDiagramI, component: Component) {
		var addComponentCommand = new AddComponentCommand(circuitDiagram, component);
		this.commandManager.executeCommand(addComponentCommand);
		this.normalise(circuitDiagram);
	}
	
	public function addLink(circuitDiagram: CircuitDiagramI, link: Link) {
		var addLinkCommand = new AddLinkCommand(circuitDiagram, link);
		this.commandManager.executeCommand(addLinkCommand);
	}
	
	public function editLink(circuitDiagram: CircuitDiagramI, linkEndpoint: Endpoint, x: Float, y: Float) {
		var editLinkCommand = new EditLinkCommand(circuitDiagram, linkEndpoint, new Coordinate(x, y));
		this.commandManager.executeCommand(editLinkCommand);
	}
	
	public function removeLink(link: Link, circuitDiagram: CircuitDiagramI) {
		var removeLinkCommand = new RemoveLinkCommand(circuitDiagram, link);
		this.commandManager.executeCommand(removeLinkCommand);
	}
	
	public function toggleSelection(activeTab: TabModel, clickedObjects: Array<CircuitElement>) {
		for (object in clickedObjects) {
			this.commandManager.executeCommand(new ToggleSelectionCommand(activeTab.getCircuitDiagram(), activeTab.getSelectionModel(), object));
		};
	}
	
	public function moveSelection(activeTab: TabModel, currentX: Float, currentY: Float, nextX: Float, nextY: Float) {
		var moveSelectionCommand = new MoveSelectionCommand(activeTab.getCircuitDiagram(), activeTab.getSelectionModel(), currentX, currentY, nextX, nextY);
		this.commandManager.executeCommand(moveSelectionCommand);
	}
	
	public function clearSelection(circuitDiagram: CircuitDiagramI, selectionModel: SelectionModel) {
		var clearSelectionCommand = new ClearSelectionCommand(circuitDiagram, selectionModel);
		this.commandManager.executeCommand(clearSelectionCommand);
	}
	
	public function addToConnection(circuitDiagram: CircuitDiagramI, connection: Connection, connectable: Connectable) {
		var addToConnectionCommand = new AddToConnectionCommand(circuitDiagram, connection, connectable);
		this.commandManager.executeCommand(addToConnectionCommand);
	}
	
	public function deleteSelection(circuitDiagram: CircuitDiagramI, selectionModel: SelectionModel) {
		if (!selectionModel.isClear()) {
			checkPoint();
			
			for (component in selectionModel.getComponentSet()) {
				var disconnectcomponentsCommand = new DisconnectComponentCommand(circuitDiagram, component);
				this.commandManager.executeCommand(disconnectcomponentsCommand);
			}
			
			for (link in selectionModel.getLinkSet()) {
				var disconnectLinkCommand = new DisconnectLinkCommand(circuitDiagram, link);
				this.commandManager.executeCommand(disconnectLinkCommand);
			}
			
			var deleteSelectionCommand = new DeleteSelectedComponentsAndLinksCommand(circuitDiagram, selectionModel);
			this.commandManager.executeCommand(deleteSelectionCommand);
			
			checkPoint();
		}
	}
	
	public function normalise(circuitDiagram: CircuitDiagramI) {
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
						this.addLink(circuitDiagram, link);
						this.addToConnection(circuitDiagram, connection, link.get_endpoint(0));
						this.addToConnection(circuitDiagram, otherConnection, link.get_endpoint(1));
					} else {
                        trace( "Merging them" ) ;
						if (connection.aPortIsConnected()) {
							// Swap them around so that we don't move
							// the port to anothe connection that might
							// be in a different location.
							var temp = connection ;
							connection = otherConnection ;
							otherConnection = temp ;
						}
                        
                        trace( "Merging from " + connection + " to " + otherConnection ) ;
                        var connectables = new Set<Connectable>() ;
                        for( item in connection.get_connectedElements() ) connectables.push(item) ;
						for (item in connectables ) {
                            trace( "Merging " + item ) ;
							this.addToConnection(circuitDiagram, otherConnection, item);
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
						this.addLink(circuitDiagram, link1);
						this.addToConnection(circuitDiagram, c0, link1.get_endpoint(0));
						this.addToConnection(circuitDiagram, connection, link1.get_endpoint(1));
                        var link2 = new Link(circuitDiagram, connection.get_xPosition(), connection.get_yPosition(),
                                                   c1.get_xPosition(), c1.get_yPosition());
						this.addLink(circuitDiagram, link2);
						this.addToConnection(circuitDiagram, connection, link2.get_endpoint(0));
						this.addToConnection(circuitDiagram, c1, link2.get_endpoint(1));
						removeLinks.push(link);
					}
				}
            }
            // Remove all links split by this connection.
            for (link in removeLinks) {
				this.removeLink(link, circuitDiagram);
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
			this.removeLink(link, circuitDiagram);
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
			this.removeLink(link, circuitDiagram);
        }
	}
	
	public function rotateSelectedComponent(activeTab: TabModel) {
		if (
			activeTab.getSelectionModel().getComponents().length > 0 &&
			activeTab.getSelectionModel().getEndpoint().length == 0 &&
			activeTab.getSelectionModel().getLinks().length == 0 &&
			activeTab.getSelectionModel().getPorts().length == 0
		) {
			checkPoint();
			for (component in activeTab.getSelectionModel().getComponentSet()) {
				this.commandManager.executeCommand(new RotateComponentCommand(activeTab.getCircuitDiagram(), component));
			}
		} else {
			trace("Can rotate only SELECTED components at a time");
		}
	}
}