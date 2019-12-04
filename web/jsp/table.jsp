<%@ page import="java.util.ArrayList" %>
<%@ page import="main.GraphInfo" %>
<%@ page import="main.History" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<br class="main">
<%History history = (History)request.getServletContext().getAttribute("history");

    if (history == null){
        history = new History();
    }
    //if (history.getList().size()>0){%>
<h1>История запросов</h1>
<button style="background: #111111;" type="button" onclick="clearHistory(); location.reload()" class="history-button">Очистить историю</button><br>
<table id="result-table" class="container">
    <tr id="table-headers"><th>Координата X</th><th>Координата Y</th><th>Радиус</th><th>Попадание в область</th></tr>
    <%
        List<GraphInfo> list = new ArrayList<GraphInfo>(history.getList());
        Collections.reverse(list);
        for (GraphInfo p : list){%>
    <tr><td><%=p.getX()%></td><td><%=p.getY()%></td><td><%=p.getR()%></td><td><%=p.isHit()%></td></tr>
    <%}%>
</table>
<%//}%>