/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.spi.DirStateFactory.Result;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Leon
 */
@WebServlet(urlPatterns = {"/register"})

public class register extends HttpServlet {

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
        String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
        String driver = "com.mysql.jdbc.Driver";
        PreparedStatement ps = null;
        Connection conn = null;
        String username = request.getParameter("username");
        String pwd = request.getParameter("pwd");
        String pwd1 = request.getParameter("pwd1");
        PrintWriter out = response.getWriter();
        try {
            if (username.equals("") || pwd.equals("") || pwd1.equals("")) {
                throw new Exception();
            }
            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(dburl);

            if (!pwd.equals(pwd1)) {
                throw new Exception();
            }

            ps = conn.prepareStatement("SELECT * FROM user WHERE username=?");
            ps.setString(1, username); //1 represents the first ?
            ps.execute();
            ResultSet rs = ps.getResultSet();
            if (rs.next()) {    //if there is next to this cursor of the result, then it means that Username already exists
                throw new Exception();
            }
            ps = conn.prepareStatement("insert into person() values()");
            ps.execute();
            ps = conn.prepareStatement("SELECT MAX(id) FROM person;");
            ps.execute();

            rs = ps.getResultSet();

            rs.next();
            String id = rs.getString(1);

            ps = conn.prepareStatement("INSERT into user (username,pwd,Id) values (?,?,?)");
            ps.setString(1, username); //1 represents the first ?
            ps.setString(2, pwd);
            ps.setString(3, id);
            //   ps.setInt(3, 3);//1 manager   2= employee   3= regular customer
            ps.execute();

            ps.close();
            out.println("<script language=\"JavaScript\">alert(\"Success！\");self.location='index.html';</script>");
        } catch (Exception ex) {
            out.println("<script language=\"JavaScript\">alert(\"Failed！\");self.location='register.html';</script>");
            out.println("failed " + ex.getMessage());

        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException ex) {

                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {

                }
            }
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
