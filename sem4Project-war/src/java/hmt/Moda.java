/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hmt;

import entities.Orders;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sessionbean.AccountsFacadeLocal;
import sessionbean.ArtistInSongFacadeLocal;
import sessionbean.ArtistsFacadeLocal;
import sessionbean.OrderDetailsFacadeLocal;
import sessionbean.OrdersFacadeLocal;
import sessionbean.SongsFacadeLocal;

/**
 *
 * @author asus
 */
@WebServlet("/Moda")
public class Moda extends HttpServlet {

    @EJB
    private OrderDetailsFacadeLocal orderDetailsFacade;

    @EJB
    private OrdersFacadeLocal ordersFacade;

    @EJB
    private AccountsFacadeLocal accountsFacade;

    @EJB
    private ArtistsFacadeLocal artistsFacade;

    @EJB
    private SongsFacadeLocal songsFacade;
    
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String typeModa = request.getParameter("moda");
        if (typeModa != null) {
            //moda OrderDetail
            if (typeModa.equals("orderDetail")) {
                //lay gia tri idOrder
                String idOrderDetail = request.getParameter("idOrderDetail");
                if (idOrderDetail != null) {
                    int idorderdetail = Integer.parseInt(idOrderDetail);
                    request.setAttribute("orderDetail", orderDetailsFacade.find(idorderdetail));
                    System.out.println(orderDetailsFacade.find(idorderdetail));
                    
                    // tra ve trang thai thanh toan  
                    
                    request.setAttribute("TransactionStatus", ordersFacade.getTransactionStatus(orderDetailsFacade.find(idorderdetail).getOrderID().getOrderID().toString()));
                    
                   request.setAttribute("Note", ordersFacade.getNote(orderDetailsFacade.find(idorderdetail).getOrderID().getOrderID().toString()));
                    //tra ve trang detail order moda
                    RequestDispatcher requestDispatcher = request.getRequestDispatcher("musics/manage/billorder/modaDetail.jsp");
                    requestDispatcher.forward(request, response);
                }
            }
            //cap nhat trang thay order 
            if (typeModa.equals("updateStatusOrder")) {

                String idOrder = request.getParameter("idOrder");
                String trangThai = request.getParameter("trangThai");
                String note = request.getParameter("note");
                //lay doi tương order
                try {
                    // lay doi tuong cap nhat 
                    HttpSession session = request.getSession();
//                    if( session.getAttribute("accountID").toString()!=null){
//                    
//                    }
                    String acc = "404";

                    Orders order = new Orders();
                    order = ordersFacade.find(Integer.parseInt(idOrder));
                    Date date = new Date();
                    String sau = "";

                    boolean setDate = false;
                    //truy gia tri cho orrder
                    order.setAccountID(order.getAccountID());
                    order.setDayTrading(order.getDayTrading());
                    order.setPaymentType(order.getPaymentType());
                    order.setPrice(order.getPrice());
                    order.setOrderDate(order.getOrderDate());
                    //cap nhat don  thanh don da mua thanh cong 
                    if (trangThai.equals("1")) {
                        sau = "Paid";
                        order.setStatus(1);
                        order.setTransactionStatus(1);
                        setDate = true;
                        order.setOrderDate(date);
                        order.setBankName("Admin");
                    } // cap nhat thanh don hang chua thanh toan
                    else if (trangThai.equals("2")) {
                        sau = "Unpaid";
                        order.setStatus(1);
                        order.setTransactionStatus(null);
                    } //cap nhat huy don hang da mua 
                    else if (trangThai.equals("3")) {
                        sau = "Canceled";
                        order.setStatus(3);
                        order.setTransactionStatus(1);
                    } //chuyeenr down hang da mua sang dang su ly 
                    else if (trangThai.equals("4")) {
                        order.setStatus(2);
                        order.setTransactionStatus(1);
                    } // chuyen don hang chua mua sang dang su ly
                    else if (!trangThai.equals("5")) {
                        order.setStatus(2);
                        order.setTransactionStatus(null);
                    }
                    
                    if (setDate == false) {
                        order.setOrderDate(order.getOrderDate());
                        order.setBankName(order.getBankName());
                    }
                    //tao gia ti note
                    String Note = (ordersFacade.getNote(order.getOrderID().toString()) != "null") ? ordersFacade.getNote(order.getOrderID().toString()): "";
                    System.out.println(ordersFacade.getNote(order.getOrderID().toString()).toString());
                    String bandau = SuLy.traRaTrangThai(order.getStatus().toString(),ordersFacade.getTransactionStatus(order.getOrderID().toString()).toString());
                    order.setNote(Note + "[" + note + "/" + acc + "/" + date + "/" + bandau + "/" + sau + "]");

                    ordersFacade.edit(order);
                    // thoong tin  phan hoi   thanh cong
                    request.setAttribute("tinNhan", "Update successful");

                } catch (Exception e) {
                    // thoong tin  phan hoi  loi
                    request.setAttribute("tinNhan", "Update Failed" + e.getMessage());
                    e.printStackTrace();
                    System.out.println(e.getMessage());
                } finally {
                    RequestDispatcher requestDispatcher = request.getRequestDispatcher("musics/retunr/retunr.jsp");
                    requestDispatcher.forward(request, response);
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