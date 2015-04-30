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
public class send_invitation extends HttpServlet {

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

        String iuname = request.getParameter("iuname");
        String uid = (String) request.getSession().getAttribute("userid");
        String cid = (String) request.getSession().getAttribute("cid");
        PrintWriter out = response.getWriter();

        if (uid == null || cid == null) {
            out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>");
        }

        if (iuname != null) {
            if (iuname.equals("")) {
                out.println("<script language=\"JavaScript\">alert(\"name must be not empty！\");self.location='index.html';</script>");

            } else {
                try {

                    Class.forName(driver).newInstance();
                    conn = DriverManager.getConnection(dburl);

                    ps = conn.prepareStatement("SELECT * FROM user WHERE username=?");
                    ps.setString(1, iuname); //1 represents the first 
                    ps.execute();
                    ResultSet rs = ps.getResultSet();

                    String iuid = null;
                    if (rs.next()) {
                        iuid = rs.getString("id");
                    } else {
                        out.println("<script language='javascript'>alert('No such a user');self.location='Manage_Circle.jsp'</script>");
                        return;
                    }

                    ps = conn.prepareStatement("SELECT * FROM addedto WHERE User_Id=? and Circle_Id=?");
                    ps.setString(1, iuid);
                    ps.setString(2, cid);
                    ps.execute();
                    rs = ps.getResultSet();

                    if (!rs.next()) {
                        ps = conn.prepareStatement("SELECT * FROM invitation WHERE user_id=? and circle_id=?");
                        ps.setString(1, iuid); //1 represents the first ?
                        ps.setString(2, cid);
                        ps.execute();
                        if (!ps.getResultSet().next()) {
                            ps = conn.prepareStatement("INSERT INTO invitation (user_id,circle_id) values (?,?)");
                            ps.setString(1, iuid); //1 represents the first ?
                            ps.setString(2, cid);
                            ps.execute();

                        }
                        out.println("<script language='javascript'>alert('Invitation has been sent');self.location='Manage_Circle.jsp'</script>");
                    } else {
                        out.println("<script language='javascript'>alert('The uses is already in the circle');self.location='Manage_Circle.jsp'</script>");
                    }
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
    }// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

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
