<%@ page import="java.util.ArrayList" %>
<%@ page import="main.GraphInfo" %>
<%@ page import="main.History" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    History history =  ((History)request.getServletContext().getAttribute("history"));
    if (history == null){
        history = new History();
    }
%>
<tr>
    <td style="colour:beige">X</td> <td class="container">Y</td> <td  class="container">R</td> <td style="colour:beige">Result</td>
</tr>
<%
    ArrayList <GraphInfo> points = (ArrayList<GraphInfo>) history.getList();
    for (int i =0; i<points.size(); i++) {
%>
<tr>
    <td><%= points.get(i).getX()%></td>
    <td><%= points.get(i).getY()%></td>
    <td><%= points.get(i).getR()%></td>
    <td><%= points.get(i).isHit()%>></td>
</tr>
<%
    }
%>