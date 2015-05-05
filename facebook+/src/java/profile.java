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
public class profile extends HttpServlet {

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
        String q=request.getParameter("q");
        String lname = request.getParameter("lname");
        String fname = request.getParameter("fname");
        String Address = request.getParameter("Address");
        String City = request.getParameter("City");
        String State = request.getParameter("State");
        String Zip = request.getParameter("Zip");
        String Tel = request.getParameter("Tel");
        String Email = request.getParameter("Email");
          String Sex= request.getParameter("Sex");
        String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
        String driver = "com.mysql.jdbc.Driver";
        PreparedStatement ps = null;
        Connection conn = null;

        String uid = (String) request.getSession().getAttribute("muid");
        PrintWriter out = response.getWriter();
        try {

            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(dburl);


            ps = conn.prepareStatement("UPDATE person SET Last_Name=? , First_Name=?,Address=?,City=?,State=?,Zip_Code=?,Telephone=?,Email_Address=?, SEX=? WHERE id=?");

            ps.setString(1, lname); //1 represents the first ?
            ps.setString(2, fname);
            ps.setString(3, Address); //1 represents the first ?
            ps.setString(4, City);
            ps.setString(5, State); //1 represents the first ?
            ps.setString(6, Zip);
            ps.setString(7, Tel); //1 represents the first ?
            ps.setString(8, Email);
            ps.setString(9, Sex);
            ps.setString(10, uid);

            ps.execute();

            ps.close();
            if (q.equals("1"))
             out.println("<script language='javascript'>alert('Success');self.location='normal_user_list.jsp'</script>");
            else
                out.println("<script language='javascript'>alert('Success');self.location='user_index.jsp'</script>");  
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
