/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Leon
 */
public class acceptapply extends HttpServlet {

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
        
            /* TODO output your page here. You may use following sample code. */
          String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
        String driver = "com.mysql.jdbc.Driver";
        PreparedStatement ps = null;
        Connection conn = null;
        String uid = request.getParameter("uid");
        String cid = request.getParameter("cid");
        PrintWriter out = response.getWriter();
        try {
           
            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(dburl);

       //      out.println(uid+" "+cid);

            ps = conn.prepareStatement("DELETE FROM application WHERE user_id=? and circle_id=?");
            ps.setString(1,uid); //1 represents the first ?
            ps.setString(2,cid);
            
            ps.execute();
            
             ps = conn.prepareStatement("INSERT INTO addedto(User_Id,Circle_Id) values (?,?)");
            ps.setString(1,uid); //1 represents the first ?
            ps.setString(2,cid);
            
            ps.execute();
            
            out.println("<script language='javascript'> alert('Success');self.location='Manage_Circle.jsp';</script>");
        } catch (Exception ex) {

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
