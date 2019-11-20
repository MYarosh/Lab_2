<%@ page import="main.GraphInfo" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="main.History" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-2.2.0.min.js"></script>
    <title>Lab2</title>

</head>
<body id="body">
<script src="${pageContext.request.contextPath}/scripts/drawing.js"></script>
<table border="0" cellpadding="0" cellspacing="0"  width="100%">
    <tr>
        <th></th>
        <th colspan="2" class="container task">
            <p class="container task">Ярошевский М.С.</p>
            <p class="container task">P3214</p>
            <p class="container task">Вариант 214024</p>
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
            <form id="form1" action="ControllerServlet.java"  method="post"
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

        <td class="container"><canvas id="cnv" width="300" height="300" style="background-color: white"></canvas></td>
        <td width="20%"></td>
    </tr>
    <tr>
        <td></td>
        <td colspan="2" class="container">
            <label hidden name="warning_x">Выберите один X</label>
            <label hidden name="warning_y_area">Число Y выходит за пределы</label>
            <label hidden name="warning_y_num">Введено не число в поле Y</label>
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
            <%if (history.getList().size()>0){%>
            <table id="result-table">
                <tr id="table-headers"><th>Координата X</th><th>Координата Y</th><th>Радиус</th><th>Попадание в область</th></tr>
                <%
                    List<GraphInfo> list = new ArrayList<GraphInfo>(history.getList());
                    Collections.reverse(list);
                    for (GraphInfo p : list){%>
                <tr><td><%=p.getX()%></td><td><%=p.getY()%></td><td><%=p.getR()%></td><td><%=p.isHit()%></td></tr>
                <%}%>
            </table>
            <%}%>
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
<script >

    let b = document.getElementsByClassName("btn")[0];
    b.addEventListener("click", check);



    let w_x = document.getElementsByName("warning_x");
    let w_y_num = document.getElementsByName("warning_y_num");
    let w_y_area = document.getElementsByName("warning_y_area");
    let yField = document.forms["form1"]["Y"];
    let boxes = document.getElementsByName("R") ;
    let xChecked = false;
    let yChecked = false;
    let rChecked = false;
    let change = 10;
    let r = false;
    var R = 0;
    var X = 0;
    var Y = 0;
    let i = 25;
    let canvas = document.getElementsByTagName("canvas")[0];
    let ctx = canvas.getContext('2d');
    canvas.addEventListener("click", handleCanvasClick);

    for (let i of boxes) {
        i.addEventListener("change", rb);
    }
    document.forms["form1"]["offset"].value = new Date().getTimezoneOffset();
    console.log(document.forms["form1"]["offset"].value);
    var offset = Number(document.forms["form1"]["offset"].value);
    var rField = 0;

    drawAxis();

    function rb(event){
        radio();
        if(rChecked){
            canvas.getContext('2d').clearRect(0, 0, canvas.width, canvas.height);
            drawArea(Number(rField.value));
            drawAxis();
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
                rField.value = i.value;
            }
        }
        if(rChecked){
            canvas.getContext('2d').clearRect(0, 0, canvas.width, canvas.height);
            drawArea(Number(rField.value));
            drawAxis();
        }
        drawPointsFromTable();
        blockButton();

    }

    function checkY(event) {
        yField.value = yField.value.replace(",", ".");
        if (!isFinite(Number(yField.value)) || !(/0*/).test(yField.value) && Number(yField.value) === 0) {
            event.preventDefault();
            yField.classList.add("warn-text");
            yChecked = false;
            w_y_num[0].hidden = false;
            w_y_area[0].hidden = true;
        } else if (Number(yField.value) < -3 || Number(yField.value) > 5) {
            event.preventDefault();
            yField.classList.add("warn-text");
            yChecked = false;
            w_y_num[0].hidden = true;
            w_y_area[0].hidden = false;
        } else {
            yField.classList.remove("warn-text");
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



     function doAjax(x, y, r, writable) {
        let req = new XMLHttpRequest();
        req.open("POST", document.documentURI, true);

        req.onload = () =>{
            console.log(req.responseText);
            changePage(JSON.parse(req.responseText), writable);
        }
        req.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.send(`X=${x}&Y=${y}&R=${r}&type=${writable ? "ajax" : "ajax-no-cache"}&offset=${offsetField.value}`)
    }
    function changePage(point, writable) {
        drawPoint(point.x, point.y, (point.isHit()===true ? "lime":"red"));
        if(writable) {
            if (!document.getElementById("result-table")) {
                let table = document.createElement("table");
                table.id = "result-table";
                let headers = document.createElement("tr");
                headers.id = "table-headers";
                headers.innerHTML = "<th>Координата X</th><th>Координата Y</th><th>Радиус</th><th>Попадание в область</th>";
                let header = document.createElement("h1");
                header.innerText = "История запросов";
                let button = document.createElement("div");
                button.innerHTML = "<button type=\"button\" onclick=\"clearHistory(); location.reload();\" class=\"history-button\">Очистить историю</button><br>";
                document.getElementsByClassName("main")[0].append(header);
                document.getElementsByClassName("main")[0].append(button);
                document.getElementsByClassName("main")[0].append(table);
                table.append(headers);

            }
            let row = document.createElement("tr");
            row.innerHTML = `<td>${point.getX()}</td><td>${point.getY()}</td><td>${point.getR()}</td><td>${point.isHit()}</td>`;
            document.getElementById("table-headers").after(row);
        }
    }
    function clearHistory() {
        let req = new XMLHttpRequest();
        req.open("POST", document.documentURI, true);
        req.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.send("type=clear");
    }

     function handleCanvasClick(event) {
         radio(event);
         if(rChecked){
             let obj = event.target;
             let x = Number(((event.pageX - window.pageXOffset - obj.getBoundingClientRect().x - obj.width/2)/i).toFixed(2));
             let y = Number((-(event.pageY - window.pageYOffset - obj.getBoundingClientRect().y - obj.height/2)/i).toFixed(2));
             if(x>=-5 && x<=5 && y>=-5 && y<=3){
                 doAjax(x,y,rField.value, true)
             }
         }
     }
     canvas.addEventListener("click", handleCanvasClick);
</script>
</body>
</html>