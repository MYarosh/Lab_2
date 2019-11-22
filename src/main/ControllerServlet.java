package main;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class ControllerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(req.getServletContext().getAttribute("history")==null){
            req.getServletContext().setAttribute("history", new History());
        }
        if (req.getParameter("type") != null && req.getParameter("type").equals("clear")) {
            req.getServletContext().setAttribute("history",null);
        }
        else if(req.getParameter("X")==null || req.getParameter("Y")==null){
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/jsp/index.jsp");
            requestDispatcher.forward(req, resp);
        }
        else{
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/checkArea");
            requestDispatcher.forward(req, resp);
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(req.getSession().getAttribute("history")==null){
            req.getSession().setAttribute("history", new History());
        }
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/jsp/index.jsp");
        requestDispatcher.forward(req, resp);
    }
}