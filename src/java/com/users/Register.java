
package com.users;

import com.model.dba.MyConnection;
import java.io.File;
import java.io.FileOutputStream;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author anujv
 */

@MultipartConfig
public class Register extends HttpServlet {

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
        try (PrintWriter out = response.getWriter())
        {
            /* TODO output your page here. You may use following sample code. */
            try{
                Thread.sleep(3000);
                Connection connection=MyConnection.getConnection();
                String name=request.getParameter("name");
                String email=request.getParameter("email");
                char[] password=request.getParameter("password").toCharArray();
                Part part=request.getPart("pic");
                String filename=part.getSubmittedFileName(); //we are going to save the filename only in database and the pic would be saved in filesystem
//                out.println(filename);
                
                PreparedStatement ps=connection.prepareStatement("INSERT INTO users(name,email,password,imageName) VALUES(?,?,?,?)");
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, String.valueOf(password));
                ps.setString(4, filename);
                ps.executeUpdate();
                
                //uploading or saving to filesystem
                InputStream inputStream=part.getInputStream();
                byte [] data=new byte[inputStream.available()];
                inputStream.read(data);
                
                String path=request.getRealPath("/"+"Images"+File.separator+filename);
//                out.println(path);
                FileOutputStream fileOutputStream=new FileOutputStream(path);
                fileOutputStream.write(data);
                fileOutputStream.close();
                
                
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet Register</title>");            
//            out.println("</head>");
//            out.println("<body>");
////            out.print("Name is "+ name);
////            out.print("Email is "+ email);
////            out.print("Password is "+ String.valueOf(password));
            out.println("done");
//            out.println("</body>");
//          
//            out.println("</html>");
                
            } catch (Exception e){
                e.printStackTrace();
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
