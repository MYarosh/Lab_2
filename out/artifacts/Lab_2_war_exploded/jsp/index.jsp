<%@ page import="main.GraphInfo" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="main.History" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-2.2.0.min.js"></script>
    <title>Lab2</title>

</head>
<body id="body">
<script src="${pageContext.request.contextPath}/scripts/drawing.js"></script>
<script src="${pageContext.request.contextPath}/scripts/doAjax.js"></script>
<script src="${pageContext.request.contextPath}/scripts/bignumber.js"></script>
<table border="0" cellpadding="0" cellspacing="0"  width="100%">
    <tr>
        <th></th>
        <th colspan="2" class="container task">
            <p class="container task">Ярошевский М.С.</p>
            <p class="container task">P3214</p>
            <p class="container task">Вариант 215730</p>
        </th>
        <th></th>
    </tr>
    <tr>
        <th width="20%"></th>
        <th width="30%" class="container">Входные данные</th>
        <th width="30%" class="container">Заданная область</th>
        <th width="20%"></th>
    </tr>
    <tr>
        <td width="20%"></td>
        <td width="30%" class="container">
            <form id="form1" action=""  method="post"
            >


                X = <br>

                <input class="Xcheck" type="checkbox" id="-3" value="-3" onclick="change0()" autocomplete="off">-3<br>
                <input class="Xcheck" type="checkbox" id="-2" value="-2" onclick="change1()" autocomplete="off">-2<br>
                <input class="Xcheck" type="checkbox" id="-1" value="-1" onclick="change2()" autocomplete="off">-1<br>
                <input class="Xcheck" type="checkbox" id="0" value="0" onclick="change3()" autocomplete="off">0<br>
                <input class="Xcheck" type="checkbox" id="1" value="1" onclick="change4()" autocomplete="off">1<br>
                <input class="Xcheck" type="checkbox" id="2" value="2" onclick="change5()" autocomplete="off">2<br>
                <input class="Xcheck" type="checkbox" id="3" value="3" onclick="change6()" autocomplete="off">3<br>
                <input class="Xcheck" type="checkbox" id="4" value="4" onclick="change7()" autocomplete="off">4<br>
                <input class="Xcheck" type="checkbox" id="5" value="5" onclick="change8()" autocomplete="off">5<br>



                <label for="Y"> Y = </label>


                <input id="Y" type="text" name="Y" placeholder="(-3 .. 5)" onkeyup="checkY(event)" autocomplete="off">


                <input type="hidden" name="offset"><br>


                <label> R = </label>


                <input class="R-button" type="radio" id="b1" name="R" value="1">1<br>
                <input class="R-button" type="radio" id="b2" name="R" value="2">2<br>
                <input class="R-button" type="radio" id="b3" name="R" value="3">3<br>
                <input class="R-button" type="radio" id="b4" name="R" value="4">4<br>
                <input class="R-button" type="radio" id="b5" name="R" value="5">5<br>
                <input type="hidden" class="b" name="X" value="10">

                <button class="btn">Проверить</button>


            </form>

        <td class="container"><canvas id="cnv" width="300" height="300"></canvas></td>
        <td width="20%"></td>
    </tr>
    <tr>
        <td></td>
        <td colspan="2" class="container">
            <label hidden name="warning_x">Выберите один X</label>
            <label hidden name="warning_y_area">Число Y выходит за пределы</label>
            <label hidden name="warning_y_num">Введено не число в поле Y</label>
            <label hidden name="w">Возможны погрешности в поле Y</label>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>
        </td>
        <% History history = (History)request.getServletContext().getAttribute("history");
         if (history == null){
             history = new History();
         }%>
        <td colspan="2" class="container">
        </td>
        <td>
        </td>
    </tr>
    <tr>
        <td></td>

        <td class="container">

        </td>
        <td class="container">
            2019 год
        </td>
        <td></td>
    </tr>



</table>
<br class="main">
<% try {
    int r = (int) request.getServletContext().getAttribute("r");
}catch(Exception e){
    request.getServletContext().setAttribute("r",1);
}
    %>
<div id="rr" style="color: #111111"><%=request.getServletContext().getAttribute("r")%></div>
<br class="main">
<%

    if (history == null){
        history = new History();
    }
    //if (history.getList().size()>0){%>
<h1>История запросов</h1>
<button style="background: #111111;" type="button" onclick="clearHistory();" class="history-button">Очистить историю</button><br>
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
<script >

    let b = document.getElementsByClassName("btn")[0];
    b.addEventListener("click", check);



    let w_x = document.getElementsByName("warning_x");
    let w_y_num = document.getElementsByName("warning_y_num");
    let w_y_area = document.getElementsByName("warning_y_area");
    let yField = new BigNumber(document.forms["form1"]["Y"].value);
    let boxes = document.getElementsByName("R") ;
    let xChecked = false;
    let yChecked = false;
    let rChecked = false;
    let change = 10;
    let r = false;
    var R = 0;
    var X = -10;
    var Y = -10;
    let i = 25;
    let canvas = document.getElementsByTagName("canvas")[0];
    let ctx = canvas.getContext('2d');
    canvas.addEventListener("click", handleCanvasClick);
    drawPointsFromTable();

    for (let i of boxes) {
        i.addEventListener("change", rb);
    }
    document.forms["form1"]["offset"].value = new Date().getTimezoneOffset();
    console.log(document.forms["form1"]["offset"].value);
    var offset = Number(document.forms["form1"]["offset"].value);
    rr = document.getElementById("rr").innerText;
    var rField = Number(rr);
    console.log(rField);
    console.log("asd");


        canvas.getContext('2d').clearRect(0, 0, canvas.width, canvas.height);
        drawArea(Number(rr));
        drawAxis();
        drawPointsFromTable();



    function rad() {
        if (rField == 1){
            document.getElementById("b1").checked = true;
        }else if (rField == 2){
            document.getElementById("b2").checked = true;
        }else if (rField == 3){
            document.getElementById("b3").checked = true;
        }else if (rField == 4){
            document.getElementById("b4").checked = true;
        }else if (rField == 5){
            document.getElementById("b5").checked = true;
        }

    }




    function rb(event){
        radio();
        doAjax(X, Y, rField, false);
        console.log(rChecked);
        if(rChecked){
            canvas.getContext('2d').clearRect(0, 0, canvas.width, canvas.height);
            drawArea(Number(rField));
            drawAxis();
            drawPointsFromTable();
        }
        drawPointsFromTable();
    }

    function check(event) {
        radio(event);
        checkY(event);
        checkX(event);
        if (yChecked) {
            yField.value = Number(yField.value);
        }

    }

    function checkX(){
        if (Number(document.getElementsByClassName("b")[0].getAttribute("value")) === 10){
            xChecked = false;
        }else {
            xChecked = true;
        }
        blockButton();
    }

    function change0(){
        if (!(change === 10)) {
            document.getElementById(String(change)).checked = false;
        }
        change = Number(document.getElementsByClassName("Xcheck")[0].getAttribute("value"));
        document.getElementsByClassName("b")[0].setAttribute("value", change);
        X = change;
        xChecked = true;
        w_x.hidden = false;
        blockButton();
    }

    function change1(){
        if (!(change === 10)) {
            document.getElementById(String(change)).checked = false;
        }
        change = Number(document.getElementsByClassName("Xcheck")[1].getAttribute("value"));
        document.getElementsByClassName("b")[0].setAttribute("value", change);
        X = change;
        xChecked = true;
        w_x.hidden = false;
        blockButton();
    }

    function change2(){
        if (!(change === 10)) {
            document.getElementById(String(change)).checked = false;
        }
        change = Number(document.getElementsByClassName("Xcheck")[2].getAttribute("value"));
        document.getElementsByClassName("b")[0].setAttribute("value", change);
        X = change;
        xChecked = true;
        blockButton();
    }

    function change3(){
        if (!(change === 10)) {
            document.getElementById(String(change)).checked = false;
        }
        change = Number(document.getElementsByClassName("Xcheck")[3].getAttribute("value"));
        document.getElementsByClassName("b")[0].setAttribute("value", change);
        X = change;
        xChecked = true;
        w_x.hidden = false;
        blockButton();
    }

    function change4(){
        if (!(change === 10)) {
            document.getElementById(String(change)).checked = false;
        }
        change = Number(document.getElementsByClassName("Xcheck")[4].getAttribute("value"));
        document.getElementsByClassName("b")[0].setAttribute("value", change);
        X = change;
        xChecked = true;
        w_x.hidden = false;
        blockButton();
    }

    function change5(){
        if (!(change === 10)) {
            document.getElementById(String(change)).checked = false;
        }
        change = Number(document.getElementsByClassName("Xcheck")[5].getAttribute("value"));
        document.getElementsByClassName("b")[0].setAttribute("value", change);
        X = change;
        xChecked = true;
        w_x.hidden = false;
        blockButton();
    }

    function change6(){
        if (!(change === 10)) {
            document.getElementById(String(change)).checked = false;
        }
        change = Number(document.getElementsByClassName("Xcheck")[6].getAttribute("value"));
        document.getElementsByClassName("b")[0].setAttribute("value", change);
        X = change;
        xChecked = true;
        w_x.hidden = false;
        blockButton();
    }

    function change7(){
        if (!(change === 10)) {
            document.getElementById(String(change)).checked = false;
        }
        change = Number(document.getElementsByClassName("Xcheck")[7].getAttribute("value"));
        document.getElementsByClassName("b")[0].setAttribute("value", change);
        X = change;
        xChecked = true;
        w_x.hidden = false;
        blockButton();
    }

    function change8(){
        if (!(change === 10)) {
            document.getElementById(String(change)).checked = false;
        }
        change = Number(document.getElementsByClassName("Xcheck")[8].getAttribute("value"));
        document.getElementsByClassName("b")[0].setAttribute("value", change);
        X = change;
        xChecked = true;
        w_x.hidden = false;
        blockButton();
    }

    function radio(event) {
        for (let i of boxes) {
            if (i.checked){
                rChecked = true;
                rField = i.value;
            }
        }
        blockButton();

    }

    function checkY(event) {
        document.forms["form1"]["Y"].value = document.forms["form1"]["Y"].value.replace(",", ".");
        yField = new BigNumber(document.forms["form1"]["Y"].value);
        if (yField.length>10){
            document.getElementsByClassName("w")[0].hidden=false;
        }
        if (!isFinite(document.forms["form1"]["Y"].value) || !(/0*/).test(document.forms["form1"]["Y"].value) && yField === 0) {
            event.preventDefault();
            document.forms["form1"]["Y"].classList.add("warn-text");
            yChecked = false;
            w_y_num[0].hidden = false;
            w_y_area[0].hidden = true;
        } else if (yField< -3 || yField > 5) {
            event.preventDefault();
            document.forms["form1"]["Y"].classList.add("warn-text");
            yChecked = false;
            w_y_num[0].hidden = true;
            w_y_area[0].hidden = false;
        } else {
            document.forms["form1"]["Y"].classList.remove("warn-text");
            yChecked = true;
            w_y_num[0].hidden = true;
            w_y_area[0].hidden = true;
        }
        blockButton();
    }

    function blockButton() {
        if (!(xChecked && yChecked && rChecked)) {
            document.getElementsByClassName("btn")[0].setAttribute("disabled", "disable");
        } else {
            document.getElementsByClassName("btn")[0].removeAttribute("disabled");
        }
        drawAxis();
    }





    function clearHistory() {
        let req = new XMLHttpRequest();
        req.open("POST", document.documentURI, true);
        req.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.send("type=clear");
        console.log(req.getResponseHeader("type"));
        location.replace(document.documentURI);
    }

     function handleCanvasClick(event) {
         radio(event);
         if(rChecked){
             let obj = event.target;
             let x = Number(((event.pageX - window.pageXOffset - obj.getBoundingClientRect().x - obj.width/2)/i).toFixed(2));
             console.log(x);
             let y = Number((-(event.pageY - window.pageYOffset - obj.getBoundingClientRect().y - obj.height/2)/i).toFixed(2));
             console.log(y);
             if(x>=-5 && x<=5 && y>=-5 && y<=5){
                 doAjax(x,y,rField, true)
             }
         }
     }
     canvas.addEventListener("click", handleCanvasClick);

    function drawPointsFromTable() {
        let table = document.getElementById("result-table");
        if(document.getElementsByTagName("tbody")[1]){table = document.getElementsByTagName("tbody")[1]}
        if(table){
            console.log("erty");
            console.log(table.children[1]);
            for(let i=1; i<table.children.length; i++){
                let row = table.children[i];
                if(row.id!=="table-headers"&&Number(row.children[2].innerText)!=Number(rField)){
                    console.log(Number(row.children[2].innerText));
                    doAjax(row.children[0].innerText, row.children[1].innerText, rField, false)
                }
                else if(row.id!=="table-headers"){
                    console.log(Number(row.children[2].innerText));
                    doAjax(row.children[0].innerText, row.children[1].innerText, rField, false);
                    drawPoint(Number(row.children[0].innerText), Number(row.children[1].innerText), (row.children[3].innerText==="true" ? "lime":"red"));
                }
            }
        }
    };
</script>
</body>
</html>