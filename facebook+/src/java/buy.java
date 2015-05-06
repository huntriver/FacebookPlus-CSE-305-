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
 * @author yishuo wang
 */
public class buy extends HttpServlet {

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

        String num = request.getParameter("num");
        String aids = request.getParameter("aid");

        if (aids == null) {
            out.println("<script language=\"JavaScript\">alert(\"choose at least one item！\");self.location='buy.jsp';</script>");
        } else {
            try {

                if (num.equals("")) {
                    out.println("<script language=\"JavaScript\">alert(\"input a number!\");self.location='buy.jsp';</script>");

                } else if (!num.matches("[0-9]*")) {

                    out.println("<script language=\"JavaScript\">alert(\"Invalid input!\");self.location='buy.jsp';</script>");

                } else {
                    int x = Integer.valueOf(num);
                    Class.forName(driver).newInstance();
                    conn = DriverManager.getConnection(dburl);
                    ps = conn.prepareStatement("SELECT * FROM advertisement WHERE Id=? ");

                    ps.setString(1, aids);
                    ps.execute();
                    ResultSet rs = ps.getResultSet();
                    rs.next();
                    if (x <= 0) {
                        conn.close();
                        out.println("<script language=\"JavaScript\">alert(\"number must be positive!\");self.location='buy.jsp';</script>");

                    } else {
                        if (x > Integer.valueOf(rs.getString("available_units"))) {
                            conn.close();

                            out.println("<script language=\"JavaScript\">alert(\"number must not be greater than available units!\");self.location='buy.jsp';</script>");

                        } else {
         //         ps = conn.prepareStatement("UPDATE advertisement set available_units=available_units-? WHERE Id=? ");
                            //       ps.setString(1, num);
                            //      ps.setString(2, aids);

              //   ps.execute();
                            ps.close();
                            conn.close();
                            request.getSession().setAttribute("baid", aids);
                            request.getSession().setAttribute("bnum", num);
                            response.sendRedirect("checkout.jsp");
                        }
                    }
                }
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
