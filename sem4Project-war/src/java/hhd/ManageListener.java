/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hhd;

import entities.Songs;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sessionbean.SongTrackingFacadeLocal;
import sessionbean.SongsFacadeLocal;

/**
 *
 * @author asus
 */
@WebServlet("/admin-listener")
public class ManageListener extends HttpServlet {

    @EJB
    private SongTrackingFacadeLocal songTrackingFacade;

    @EJB
    private SongsFacadeLocal songsFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String app = request.getContextPath(); // get real path
        String todo = request.getParameter("do");
        HttpSession session = request.getSession(true);
        if (todo.equals("view")) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            System.out.println(LocalDate.now().format(formatter));
            String today = LocalDate.now().format(formatter);
            request.setAttribute("list", songTrackingFacade.getTop50Songs(today, today));
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("admin/songs/listeners.jsp");
            requestDispatcher.forward(request, response);
        } else if (todo.equals("top")) {
            String fdate = request.getParameter("fdate");
            String tdate = request.getParameter("tdate");
            if (fdate != null && tdate != null) {
                response.setContentType("text/html;charset=UTF-8");
                try (PrintWriter out = response.getWriter()) {
                    for (Object[] song : songTrackingFacade.getTop50Songs(fdate, tdate)) {
                        Songs objSong = songsFacade.find(song[0]);
                        int listen = (int) song[1];
                        out.println("<tr>");
                        out.println("<td class='avatar'>");
                        out.println("<img src=\"" + app + "/storage/song/" + objSong.getThumbnail() + "\"/><br/>");
                        out.println("<span>" + objSong.getSongName() + "</span>");
                        out.println("</td>");
                        out.println("<td>" + objSong.getArtistID().getNickname() + "</td>");
                        out.println("<td>" + objSong.getTypeID().getTypeName() + "</td>");
                        out.println("<td>" + objSong.getLangID().getLangName() + "</td>");
                        out.println("<td>" + objSong.getRelease() + "</td>");
                        if (objSong.getTypeAlbum() == 0) {
                            out.println("<td>Single</td>");
                        } else {
                            out.println("<td>" + objSong.getAlbumID().getAlbumName() + "</td>");
                        }
                        out.println("<td>" + objSong.getPrice() + " $</td>");
                        out.println("<td>" + listen + "</td>");
                        out.println("</tr>");
                    }
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
