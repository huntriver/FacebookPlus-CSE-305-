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
public class createCircle extends HttpServlet {

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
        String cname = request.getParameter("cname");
        String ctype = request.getParameter("ctype");
        String ownerId= request.getParameter("ownerId");
        String userid = (String) request.getSession().getAttribute("userid");
        PrintWriter out = response.getWriter();
        
        if (userid == null) {
            out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>");
        } 
        if (cname != null && ctype != null) {
            if (cname.equals("") || ctype.equals("")) {
                out.println("<script language=\"JavaScript\">alert(\"name and type must be not empty！\");self.location='user_index.jsp';</script>");

            } else {
        try {
           
            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(dburl);

          

            ps = conn.prepareStatement("INSERT INTO circle (NAME,Owner,Type) values (?,?,?)");
            ps.setString(1, cname); //1 represents the first ?
            ps.setString(2, ownerId);
            ps.setString(3, ctype);
            ps.execute();
            

            
             ps = conn.prepareStatement("SELECT MAX(id) FROM circle;");
            ps.execute();

            ResultSet rs = ps.getResultSet();

            rs.next();
            String cid = rs.getString(1);
            
             ps = conn.prepareStatement("INSERT INTO addedto (User_Id,Circle_Id) values (?,?)");
            ps.setString(1, ownerId); //1 represents the first ?
            ps.setString(2, cid);
            ps.execute();
            
            
            ps = conn.prepareStatement("INSERT INTO owns (User_Id,Circle_Id) values (?,?)");
            ps.setString(1, ownerId); //1 represents the first ?
            ps.setString(2, cid);
            ps.execute();
            
            
            ps.close();
            out.println("<script language='javascript'>alert('Success');self.location='user_index.jsp';</script>");
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
