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
 * @author Leon
 */
public class create_ad extends HttpServlet {

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
<<<<<<< HEAD
        String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
        String driver = "com.mysql.jdbc.Driver";
        PreparedStatement ps = null;
        Connection conn = null;
        PrintWriter out = response.getWriter();

        String item_name = request.getParameter("item_name");
        String company = request.getParameter("company");
        String type = request.getParameter("type");
        String content = request.getParameter("content");
        String price = request.getParameter("price");
        String units = request.getParameter("units");

        String uid = (String) request.getSession().getAttribute("userid");

        if (uid == null) {
            out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>");
        }

        if (item_name != null && company != null && type != null && content != null && price != null && units != null) {
            try {

                if (item_name.equals("") || company.equals("") || type.equals("") || content.equals("") || price.equals("") || units.equals("")) {
                    throw new Exception();
                }
                Class.forName(driver).newInstance();
                conn = DriverManager.getConnection(dburl);

                if (!price.matches("[0-9]*") || !units.matches("[0-9]*")) {
                    throw new Exception();
                }

                ps = conn.prepareStatement("SELECT * FROM advertisement WHERE Item_Name=?");
                ps.setString(1, item_name); //1 represents the first ?
                ps.execute();
                ResultSet rs = ps.getResultSet();
                if (rs.next()) {    //if there is next to this cursor of the result, then it means that Username already exists
                    throw new Exception();
                }

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date now = new Date();
                String date = sdf.format(now);

                ps = conn.prepareStatement("INSERT into advertisement (Item_Name,Company,Type,Content,Unit_Price,Available_Units,Employee_ID,Date) values (?,?,?,?,?,?,?,?)");
                
                ps.setString(1, item_name); //1 represents the first ?           
                ps.setString(2, company);
                ps.setString(3, type); 
                ps.setString(4, content); 
                ps.setString(5, price);          
                ps.setString(6, units);
                ps.setString(7, uid);        
                ps.setString(8, date);    
                
                ps.execute();           
                ps.close();

                out.println("<script language=\"JavaScript\">alert(\"Success！\");self.location='advertisement.jsp';</script>");
            } catch (Exception ex) {
                out.println("<script language=\"JavaScript\">alert(\"Failed！\");self.location='advertisement.jsp';</script>");
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

=======
    String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
        String driver = "com.mysql.jdbc.Driver";
        PreparedStatement ps = null;
        Connection conn = null;
         PrintWriter out = response.getWriter();
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");
        String receiver =request.getParameter("receiver");

        request.getSession().setAttribute("m_subject", subject);
        request.getSession().setAttribute("m_content", content);
        request.getSession().setAttribute("m_receiver", receiver);
        
        String uid = (String) request.getSession().getAttribute("userid");
      
       
        if (uid == null ) {
            out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>");
        }

        if (subject != null && content != null && receiver!=null) {
            if (subject.equals("") || content.equals("") || receiver.equals("")) {
                out.println("<script language=\"JavaScript\">alert(\"subject and content and receiver must be not empty！\");self.location='newMessage.jsp';</script>");

            } else {
                try {

                    Class.forName(driver).newInstance();
                    conn = DriverManager.getConnection(dburl);

                    ps = conn.prepareStatement("SELECT * FROM user WHERE username=?");
                    ps.setString(1, receiver); //1 represents the first ?
                    ps.execute();
                    ResultSet rs=ps.getResultSet();
                    if (!rs.next())
                        out.println("<script language=\"JavaScript\">alert(\"No such a Receiver！\");self.location='newMessage.jsp';</script>");
                    String rid=rs.getString("id");
                    
                    ps = conn.prepareStatement("INSERT INTO message (subject,content,receiver,sender,date) values (?,?,?,?,?)");
                    ps.setString(1, subject);
                    ps.setString(2, content);
                    ps.setString(3, rid);
                    ps.setString(4,uid);
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    Date now = new Date();
                    String date = sdf.format(now);
                    ps.setString(5, date);
                  
                    ps.execute();

                    ps.close();
                    out.println("<script language='javascript'>alert('Success');self.location='message.jsp'</script>");
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
>>>>>>> 67fda1232983625fbbd30771e3f183127794b3c9
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
