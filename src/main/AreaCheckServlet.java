package main;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import main.GraphInfo;
import main.History;

public class AreaCheckServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        History history = (History) req.getSession().getAttribute("history");
        double x;
        double y;
        double r;
        int offset;
        try {
            x = Double.parseDouble(req.getParameter("X"));
            y = Double.parseDouble(req.getParameter("Y"));
            r = Double.parseDouble(req.getParameter("R"));
            if (x > 5 || x < -5 || y < -5 || y > 3 || (r != 1 && r != 1.5 && r != 2 && r != 2.5 && r != 3)) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            resp.getWriter().println("<h1>Incorrect parameters</h1>");
            return;
        }
        try {
            offset = Integer.parseInt(req.getParameter("offset"));
        }
        catch (NumberFormatException e){
            offset = 0;
        }

        GraphInfo point = new GraphInfo(x, y, r);
        if (req.getParameter("type") != null && req.getParameter("type").equals("ajax")) {
            history.addPoint(point);
            resp.setContentType("text/json; charset=UTF-8");
            PrintWriter out = resp.getWriter();
            out.println("{\"x\": " + point.getX() + ", \"y\": " + point.getY() + ", \"r\": " + point.getR() + ", \"inArea\": \"" + point.isHit() + "\"}");
        }
        else if(req.getParameter("type") != null && req.getParameter("type").equals("ajax-no-cache")){
            resp.setContentType("text/json; charset=UTF-8");
            PrintWriter out = resp.getWriter();
            out.println("{\"x\": " + point.getX() + ", \"y\": " + point.getY() + ", \"r\": " + point.getR() + ", \"inArea\": \"" + point.isHit() + "\"}");
        }
        else {
            history.addPoint(point);
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter out = resp.getWriter();
            out.println("<html>\n" +
                    "<head>\n" +
                    "    <meta charset=\"UTF-8\">\n" +
                    "    <title>Lab 2</title>\n" +
                    "    <link rel=\"stylesheet\" href=\"" + req.getContextPath() + "/css/main.css\">\n" +
                    "</head>\n" +
                    "<body>\n" +
                    "<div class=\"container task\">\n" +
                    "        <span id=\"head-title\">\n" +
                    "            Лабораторная работа №2. Вариант 215730\n" +
                    "        </span>\n" +
                    "    <span id=\"head-author\" class=\"container task\">\n" +
                    "            Выполнил студент группы P3214 Ярошевский М.С.\n" +
                    "        </span>\n" +
                    "</div>\n" +
                    "<div class=\"conta`iner\">" +
                    "    <h1>Результат обработки запроса</h1>" +
                    "    <table id=\"result-table\">" +
                    "        <tr><th>Координата X</th><th>Координата Y</th><th>Радиус</th><th>Попадание в область</th></tr>" +
                    "        <tr><td>" + point.getX() + "</td><td>" + point.getY() + "</td><td>" + point.getR() + "</td><td>" + point.isHit() + "</td>" +
                    "    </table>" +
                    "<a href=\"" + req.getContextPath() + "\"><button class=\"submit-button\">Назад</button></a>" +
                    "</div></body></html>");
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.sendRedirect(this.getServletContext().getContextPath());
    }
}