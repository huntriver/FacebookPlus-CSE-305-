/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Leon
 */
public class show_message extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
<<<<<<< HEAD
            
            //getSession won't allow user to see the value appended at the URL
            //in order to show the page, need userId to show 
            //session is like a hashmap 
            //parameter is the value I passed in to get 
            //this session will stay the same no matter which page you're on within same login session
            //setting the values of this sesssion like a preservation jar
            //so the value passed in from current page by the user will be preserved across different pages within the same session
            //make sure the form action = name in .jsp matches the name of the java 
            //jsp will take the input from user through html
            //java servlet in here will do SQL handling
=======
            /* TODO output your page here. You may use following sample code. */
       
>>>>>>> b68c5e346333901e9dbd9d4a3b654f55207ce99a
            request.getSession().setAttribute("subject", request.getParameter("subject"));
            request.getSession().setAttribute("date", request.getParameter("date"));
            request.getSession().setAttribute("content", request.getParameter("content"));
            request.getSession().setAttribute("sender", request.getParameter("sender"));
            response.sendRedirect("showMessage.jsp");
            
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
