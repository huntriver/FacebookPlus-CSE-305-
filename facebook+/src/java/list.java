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
public class list extends HttpServlet {

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

        //String uid = (String) request.getSession().getAttribute("userid");
        String[] ids = request.getParameterValues("id");
        String[] types = request.getParameterValues("type");
        String[] H_Rate = request.getParameterValues("H_Rate");
        
        // out.println(ids.length+" "+types.i)
        PrintWriter out = response.getWriter();
        
        try {

            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(dburl);

            for (int i = 0; i < ids.length; i++) {
                ps = conn.prepareStatement("UPDATE user SET type=? WHERE id=?");
                ps.setString(1, types[i]); //1 represents the first ?          
                ps.setString(2, ids[i]);
                //out.println(ids[i]+"   "+H_Rate[i]+ "<br>");
                
                
                
                ps.execute();
                
                if (types[i].equals("2")) {
                    
                    ps = conn.prepareStatement("SELECT * FROM employee WHERE Id=?");
                    ps.setString(1, ids[i]); 
                    ps.execute();
                    
                    ResultSet rs = ps.getResultSet();
                    
                    if (!rs.next()) {    
                        
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date now = new Date();
                        String date = sdf.format(now);
                        ps = conn.prepareStatement("INSERT into employee (Id,Start_Date,Hourly_Rate) values (?,?,?)");
                        ps.setString(1, ids[i]); //1 represents the first ?          
                        ps.setString(2, date);
                        ps.setString(3, H_Rate[i]);
                        ps.execute();
                    }
                    else{
                       
                        
                        ps = conn.prepareStatement("UPDATE employee SET Hourly_Rate=? WHERE Id=?");
                        ps.setString(1, H_Rate[i]);    
                        ps.setString(2, ids[i]);
                        ps.execute();
                        
                        
                    }
                }
                if (types[i].equals("3")) {
                    ps = conn.prepareStatement("SELECT * FROM employee WHERE Id=?");
                    ps.setString(1, ids[i]); 
                    ps.execute();
                    ResultSet rs = ps.getResultSet();
                    if (rs.next()) {    
                        ps = conn.prepareStatement("DELETE FROM employee where Id=?");
                        ps.setString(1, ids[i]);
                        ps.execute();
                    }                   
                }
                
            }
            ps.close();
            out.println("<script language='javascript'>alert('Success');self.location='user_list.jsp'</script>");
        } catch (Exception ex) {
            out.println("<script language='javascript'>alert('failed');self.location='user_list.jsp'</script>");
            out.println("failed " + ex.getMessage());
            ex.printStackTrace();

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
