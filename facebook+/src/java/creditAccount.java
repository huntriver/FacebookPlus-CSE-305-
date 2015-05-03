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
 * @author 鑫河
 */
public class creditAccount extends HttpServlet {

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
        String Card_Num = request.getParameter("Card_Num");
        String Full_Name = request.getParameter("Full_Name");
       
        PrintWriter out = response.getWriter();
        try {
            if (Card_Num.equals("") || Full_Name.equals("") ) {
                throw new Exception();
            }
            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(dburl);
            
            if (!Card_Num.matches("[0-9]{16}")) {
                throw new Exception();
            }
            out.println(Card_Num+"   "+Card_Num.length()+"  "+Full_Name);
            ps = conn.prepareStatement("SELECT * FROM account WHERE Credit_Card_Number=?");
            ps.setString(1, Card_Num); //1 represents the first ?
            ps.execute();
            ResultSet rs = ps.getResultSet();
            if (rs.next()) {    //if there is next to this cursor of the result, then it means that Username already exists
                throw new Exception();
            }                     
            ps = conn.prepareStatement("INSERT into account (Credit_Card_Number,Account_Creation_Date) values (?,?)");
            ps.setString(1, Card_Num); //1 represents the first ?
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date now = new Date();
            String date = sdf.format(now);
            ps.setString(2, date);
            //   ps.setInt(3, 3);//1 manager   2= employee   3= regular customer
            ps.execute();

            ps.close();
            out.println("<script language=\"JavaScript\">alert(\"Success！\");self.location='account.jsp';</script>");
        } catch (Exception ex) {
            out.println("<script language=\"JavaScript\">alert(\"Failed！\");self.location='newAccount.jsp';</script>");
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
