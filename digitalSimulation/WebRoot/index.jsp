<%@ page language="java" import="java.util.*" pageEncoding="US-ASCII"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body onload='TestTheStage.init()'>
		<div>
			<button id="prezzoom:zoomInButton" type="button" accesskey="+">+</button>
			<button id="prezzoom:zoomOutButton" type="button" accesskey="-">-</button>
		</div>
		<table>
			<tr><td>
					<button id="prezzoom:counterClockwiseButton" type="button">
							ccw
					</button>
				</td>
				<td>
					<button id="prezzoom:goUpButton" type="button">
							^
					</button>
				</td>
				<td>
					<button id="prezzoom:clockwiseButton" type="button">
							cw
					</button>
				</td>
			</tr>
			<tr>
				<td><button id="prezzoom:goLeftButton" type="button">
						&lt;
					</button>
				</td>
				<td>
					<canvas id="prezzoom:canvas" width=500 height=400></canvas>
				</td>
				<td><button id="prezzoom:goRightButton" type="button">
						&gt;
					</button>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<button id="prezzoom:goDownButton" type="button">
								v
					</button>
				</td>
				<td></td>
			</tr>
		</table>

						
		<div id="haxe:trace"></div>
	</body>
</html>
