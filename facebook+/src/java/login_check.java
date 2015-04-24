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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author 鑫河
 */
public class login_check extends HttpServlet {

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
        String username = request.getParameter("username");
        String pwd = request.getParameter("pwd");
        PrintWriter out = response.getWriter();
        if (username != null && pwd != null) {
            if (username.equals("") || pwd.equals("")) {
                out.println("<script language=\"JavaScript\">alert(\"username and password must be not empty！\");self.location='index.html';</script>");

            } else {
                 PreparedStatement ps=null;
            
                try{
            
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                ps= conn.prepareStatement("SELECT * FROM user");
                ps.execute();  //execute the query
                ResultSet rs = ps.getResultSet();
                boolean p = false;
                String id = null;
                while (rs.next()) {
                    if (rs.getString("username").equals(username)) {  //if what's at column username at database matches user's input
                        if (rs.getString("pwd").equals(pwd)) {
                            id = rs.getString("Id");
                            p = true;

                        } else {
                            break;
                        }
                    }
                }
                
                if (p) {
                     HttpSession session = request.getSession();
                  
                    
                    session.setAttribute("userid", id);

                    response.sendRedirect("user_index.jsp");

                } else {
                    out.println("<script language=\"JavaScript\">alert(\"username or password incorrect！\");self.location='index.html';</script>");
                }
            }
                catch(Exception e)
                        {}
                finally
                {
                     try {
                         ps.close();
                     } catch (SQLException ex) {
                         Logger.getLogger(login_check.class.getName()).log(Level.SEVERE, null, ex);
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
