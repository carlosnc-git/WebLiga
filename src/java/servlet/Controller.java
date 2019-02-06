/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import entities.Jornada;
import entities.Partido;
import entities.Porra;
import entities.Usuario;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import jpautil.JPAUtil;

/**
 *
 * @author pacopulido
 */
@WebServlet(name = "Controller", urlPatterns = {"/Controller"})
public class Controller extends HttpServlet {

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
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher;
        
        String op;
        String sql;
        Query query;
        List<Jornada> jornadas;
        List<Partido> partidos;
        Usuario usuario = null;
        EntityManager em = null;
        int idJornada = -1;
        
        em = (EntityManager) session.getAttribute("em");
        if (em == null) {

            em = JPAUtil.getEntityManagerFactory().createEntityManager();
            session.setAttribute("em", em);
        }

        op = request.getParameter("op");

        if (op.equals("inicio")) {
            sql = "SELECT p FROM Jornada p";
            query = em.createQuery(sql);
            jornadas = query.getResultList();
            session.setAttribute("listaJornadas", jornadas);
            session.setAttribute("idJornada", idJornada);
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
        } else if (op.equals("login")) {
            String dni = (String)request.getParameter("dni");
            String nombre = (String)request.getParameter("nombre");
            usuario = em.find(Usuario.class, dni);
            if (usuario == null){
                usuario = new Usuario(dni);
                usuario.setNombre(nombre);
                usuario.setPorraList(new ArrayList<>());
                em.persist(usuario);
            }
            session.setAttribute("usuario", usuario);
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);

        } else if (op.equals("logout")){
            usuario = null;
            session.setAttribute("usuario", usuario);
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
        } else if (op.equals("dameJornada")) {
            int id = Integer.parseInt(request.getParameter("jornadaSeleccionada"));
            if (id!=0){
                sql = "select p from Partido p where p.idjornada=(select j.idjornada from Jornada j where j.idjornada="+id+")";
                query = em.createQuery(sql);
                partidos = query.getResultList();
            } else {
                partidos=null;
            }
            session.setAttribute("jornadaSeleccionada", id);
            session.setAttribute("partidos",partidos);
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
        } else if (op.equals("nuevaApuesta")){
            
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
