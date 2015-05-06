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
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author yishuo wang
 */
public class checkout extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        String uid = (String) request.getSession().getAttribute("userid");
        String aid = (String) request.getSession().getAttribute("baid");
        String num = (String) request.getSession().getAttribute("bnum");
        String acnum = request.getParameter("acnum");
      if (acnum==null){
            out.println("<script language=\"JavaScript\">alert(\"you must choose one account!\");self.location='checkout.jsp';</script>");
      }
      else
        try {

            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(dburl);
            ps = conn.prepareStatement("UPDATE advertisement set available_units=available_units-? WHERE Id=? ");
            ps.setString(1, num);
            ps.setString(2, aid);
            ps.execute();
            ps = conn.prepareStatement("INSERT INTO sale (advertisement,number_of_units,account,user,date) values(?,?,?,?,?)");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date now = new Date();
            String date = sdf.format(now);
            ps.setString(1, aid);
            ps.setString(2, num);
            ps.setString(3, acnum);
            ps.setString(4, uid);
            ps.setString(5, date);
            ps.execute();

            //   ps.execute();
            ps.close();
            conn.close();

            out.println("<script language=\"JavaScript\">alert(\"success!\");self.location='buy.jsp';</script>");

        } catch (Exception ex) {

            out.println("aafailed " + ex.getMessage());

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
