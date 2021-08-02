/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbean;

import entities.Orders;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author asus
 */
@Stateless
public class OrdersFacade extends AbstractFacade<Orders> implements OrdersFacadeLocal {

    @PersistenceContext(unitName = "sem4Test-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public OrdersFacade() {
        super(Orders.class);
    }
    
     @Override
    public String orderIdEnd() {
        String id = "";
        Query query = em.createNativeQuery("SELECT TOP 1 OrderID FROM Orders ORDER BY OrderID DESC");
        for (int i = 0; i < query.getResultList().size(); i++) {
            id = query.getResultList().get(i).toString();
        }
        return id;
    }
//Tong doanh thu trong khoang thoi gian da chon

    @Override
    public String sumPriceOderAll(String start, String end) {
        String sum = "";
        Query query = null;
        // chuyen string sang LocalDate
        LocalDate s = LocalDate.parse(start);
        LocalDate e = LocalDate.parse(end);
        if (!start.equals(end)) {
            String sql = "SELECT SUM(Price) FROM dbo.Orders where DayTrading  between  ?  and  ? "
                    + "and Status=1 and TransactionStatus=1 ";
            query = em.createNativeQuery(sql);
            query.setParameter(1, s.plusDays(-1));
            query.setParameter(2, e.plusDays(1));
        } else if (start.equals(end)) {
            String sql = "SELECT SUM(Price) FROM dbo.Orders where datediff(day, DayTrading, ?) = 0  "
                    + "and Status=1 and TransactionStatus=1 ";
            query = em.createNativeQuery(sql);
            query.setParameter(1, start);

        }
        if (query.getResultList().get(0) == null) {
            sum = "0";
        } else {
            for (int i = 0; i < query.getResultList().size(); i++) {
                sum = query.getResultList().get(i).toString();
            }
            DecimalFormat formatter = new DecimalFormat("###,###,##0");
            sum = formatter.format(Double.parseDouble(sum));
        }
        return sum;
    }

    @Override
    public String sumPriceOderAllNo(String start, String end) {
        String sum = "";
        String sql = "SELECT SUM(Price) FROM dbo.Orders where DayTrading  between  ? and ? ";
        Query query = em.createNativeQuery(sql);
        query.setParameter(1, start);
        query.setParameter(2, end);
        if (query.getResultList().get(0) == null) {
            sum = "0";
        } else {
            for (int i = 0; i < query.getResultList().size(); i++) {
                sum = query.getResultList().get(i).toString();
            }
        }
        return sum;
    }
//Bieeur do tong daon thu 

    @Override
    public List PriceAll(String start, String end) {
        // List listDay = SuLy.SuLyDate.days(start, end);
        List listDate = SuLy.SuLyDate.dates(start, end);
        List priceAll = new ArrayList();
        for (int i = 0; i < listDate.size(); i++) {
            //du dung o day    
            String sumOnDate = sumOnDate(listDate.get(i).toString());
            if (!sumOnDate.equals("[null]")) {
                priceAll.add(locGiaTri(sumOnDate));
            } else {
                priceAll.add("0");
            }
        }
        return priceAll;
    }

    public String sumOnDate(String date) {

        String sum = date;
        String sql = "SELECT sum(Price) FROM Orders where datediff(day, DayTrading, ?) = 0  "
                + "and  "
                + "Status=1 and TransactionStatus=1 ";
        Query query = em.createNativeQuery(sql);
        query.setParameter(1, sum);
        sum = null;
        sum = query.getResultList().toString();
        return sum;
    }

    public String locGiaTri(String loc) {
        int d, c;
        d = loc.indexOf("[");
        c = loc.indexOf("]");
        String trave = loc.substring(d + 1, c);
        loc = trave;
        return loc;
    }
//Dem so sluot order co trong thang

    @Override
    public String countOrderNo(String start, String end) {
        String countOrder = null;
        countOrder = countOrder(start, end);
        return countOrder;
    }

    public String countOrder(String start, String end) {
        String sum = "";
        Query query = null;
        // chuyen string sang LocalDate
        LocalDate s = LocalDate.parse(start);
        LocalDate e = LocalDate.parse(end);

        if (!start.equals(end)) {
            String sql = "SELECT COUNT(OrderID) FROM dbo.Orders where DayTrading  between  ? and ? ";
            query = em.createNativeQuery(sql);
            query.setParameter(1, s.plusDays(-1));
            query.setParameter(2, e.plusDays(1));
        } else {
            String sql = "SELECT COUNT(OrderID) FROM dbo.Orders where datediff(day, DayTrading, ?) = 0 ";
            query = em.createNativeQuery(sql);
            query.setParameter(1, start);
        }

        sum = query.getResultList().toString();
        sum = locGiaTri(sum);
        return sum;
    }
    //So luong  order da thanh toan trong  trong thang

    @Override
    public String countOrderNotIs(String start, String end) {
        return countOrderNI(start, end);
    }

    public String countOrderNI(String start, String end) {
        String sum = "";
        Query query = null;
        // chuyen string sang LocalDate
        LocalDate s = LocalDate.parse(start);
        LocalDate e = LocalDate.parse(end);
        if (!start.equals(end)) {
            String sql = "SELECT COUNT(OrderID) FROM dbo.Orders where DayTrading  between  ? and ?  "
                    + "and Status=1 and TransactionStatus=1 ";
            query = em.createNativeQuery(sql);
            query.setParameter(1, s.plusDays(-1));
            query.setParameter(2, e.plusDays(1));

        } else {
            String sql = "SELECT COUNT(OrderID) FROM dbo.Orders where  datediff(day, DayTrading, ?) = 0 "
                    + "and Status=1 and TransactionStatus=1 ";
            query = em.createNativeQuery(sql);
            query.setParameter(1, start);
        }
        sum = query.getResultList().toString();
        sum = locGiaTri(sum);
        return sum;
    }
// day du lieu len bieu do top 5 bai hat duong yeu thich 

    @Override
    public String sumPriceTop(String start, String end) {
        List<Object[]> authors = sumPriceTop10(start, end);
        List list = new ArrayList();
        for (Object[] a : authors) {
            String tam = "['" + a[0] + "'," + a[1] + "]";
            list.add(tam);
            tam = null;
        }
        String loc = list.toString();
        loc = loc.substring(1, loc.lastIndexOf("]"));
        System.out.println(loc);
        return loc;
    }

    public List sumPriceTop10(String start, String end) {
        Query query = null;
        // chuyen string sang LocalDate
        LocalDate s = LocalDate.parse(start);
        LocalDate e = LocalDate.parse(end);
        if (!start.equals(end)) {
            String sql = "SELECT top 5 SongName,SUM(OrderDetails.Price) as 'd' from OrderDetails  "
                    + "full  join Orders on OrderDetails.OrderID = Orders.OrderID "
                    + "full  join Songs on OrderDetails.SongID = Songs.SongID where DayTrading between  ?  and  ?  "
                    + "and Status=1 and TransactionStatus=1 "
                    + " group by SongName ORDER BY d DESC";
            query = em.createNativeQuery(sql);
            query.setParameter(1, s.plusDays(-1));
            query.setParameter(2, e.plusDays(1));
        } else {
            String sql = "SELECT top 5 SongName,SUM(OrderDetails.Price) as 'd' from OrderDetails  "
                    + "full  join Orders on OrderDetails.OrderID = Orders.OrderID "
                    + "full  join Songs on OrderDetails.SongID = Songs.SongID where datediff(day, DayTrading, ?) = 0 "
                    + "and Status=1 and TransactionStatus=1 "
                    + " group by SongName ORDER BY d DESC";
            query = em.createNativeQuery(sql);
            query.setParameter(1, start);
        }

        return query.getResultList();
    }

    @Override
    public List sumSongNameTop(String start, String end) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
// danhn sach detail doanh thu 

    @Override
    public List listSong(String start, String end) {
        Query query = null;
        LocalDate s = LocalDate.parse(start);
        LocalDate e = LocalDate.parse(end);
        if (!start.equals(end)) {
            String sql = "SELECT Songs.SongID,Orders.OrderID,SongName,Accounts.Fullname,DayTrading,OrderDetails.Price,Songs.Thumbnail,Songs.Path,Artists.ArtistID,Artists.Nickname    "
                    + "                from OrderDetails      "
                    + "                full  join Orders on OrderDetails.OrderID = Orders.OrderID      "
                    + "                full  join Songs on OrderDetails.SongID = Songs.SongID      "
                    + "                full  join Accounts on Orders.AccountID =Accounts.AccountID     "
                    + "                full  join Artists on Artists.ArtistID =Songs.ArtistID     "
                    + "                where  DayTrading between  ?  and  ?     "
                    + "                and TransactionStatus is not null     "
                    + "                order by DayTrading desc";
            query = em.createNativeQuery(sql);
            query.setParameter(1, s.plusDays(-1));
            query.setParameter(2, e.plusDays(1));
        } else {
            String sql = "SELECT Songs.SongID,Orders.OrderID,SongName,Accounts.Fullname,DayTrading,OrderDetails.Price,Songs.Thumbnail,Songs.Path,Artists.ArtistID,Artists.Nickname    "
                    + "                from OrderDetails      "
                    + "                full  join Orders on OrderDetails.OrderID = Orders.OrderID      "
                    + "                full  join Songs on OrderDetails.SongID = Songs.SongID      "
                    + "                full  join Accounts on Orders.AccountID =Accounts.AccountID     "
                    + "                full  join Artists on Artists.ArtistID =Songs.ArtistID     "
                    + "                where  datediff(day, DayTrading, ?) = 0    "
                    + "                and TransactionStatus is not null     "
                    + "                order by DayTrading desc";
            query = em.createNativeQuery(sql);
            query.setParameter(1, start);
        }
        List<Object[]> authors = query.getResultList();
        List list = new ArrayList();
        for (Object[] a : authors) {
            String tam = "[" + a[0] + "/" + a[1] + "/" + a[2] + "/" + a[3] + "/" + a[4] + "/" + a[5] + "/" + a[6] + "/" + a[7] + "/" + a[8] + "/" + a[9] + "]";
            list.add(tam);
            tam = null;
        }
        return list;
    }

    //truy xuar thong tin order 
    public List thongTinOrder(String start, String end) {
        Query query = null;
        System.out.println(start);
        System.out.println(end);
        LocalDate s = LocalDate.parse(start);
        LocalDate e = LocalDate.parse(end);
        if (!start.equals(end)) {
            String sql = "SELECT Songs.SongID,Orders.OrderID,SongName,Fullname,DayTrading,Orders.Price,TransactionStatus,Orders.Status ,OrderDate,DetailID "
                    + "from OrderDetails  "
                    + "full  join Orders on OrderDetails.OrderID = Orders.OrderID  "
                    + "full  join Songs on OrderDetails.SongID = Songs.SongID  "
                    + "full  join Accounts on Orders.AccountID =Accounts.AccountID  "
                    + "where DayTrading between  ?  and  ?  "
                    + "order by DayTrading desc";
            query = em.createNativeQuery(sql);
            query.setParameter(1, s.plusDays(-1));
            query.setParameter(2, e.plusDays(1));
        } else {
            String sql = "SELECT Songs.SongID,Orders.OrderID,SongName,Fullname,DayTrading,Orders.Price,TransactionStatus,Orders.Status ,OrderDate,DetailID "
                    + "from OrderDetails  "
                    + "full  join Orders on OrderDetails.OrderID = Orders.OrderID  "
                    + "full  join Songs on OrderDetails.SongID = Songs.SongID  "
                    + "full  join Accounts on Orders.AccountID =Accounts.AccountID  "
                    + "where datediff(day,DayTrading, ?) = 0  "
                    + "order by DayTrading desc";
            query = em.createNativeQuery(sql);
            query.setParameter(1, start);
        }

        List<Object[]> authors = query.getResultList();
        String tam = null;
        List list = new ArrayList();
        for (Object[] a : authors) {
            tam = "[" + a[0] + "/" + a[1] + "/" + a[2] + "/" + a[3] + "/" + a[4] + "/" + a[5] + "/" + a[6] + "/" + a[7] + "/" + a[8] + "/" + a[9] + "]";
            list.add(tam);
            tam = null;
        }
        return list;
    }
// banr detail order admin

    @Override
    public List nformationOrder(String start, String end) {
        return thongTinOrder(start, end);
    }

    @Override
    public String getTransactionStatus(String idOrder) {
        String sql = "select TransactionStatus from Orders "
                + "where OrderID = ?";
        Query query = em.createNativeQuery(sql);
        query.setParameter(1, idOrder);
        return query.getResultList().toString().substring(1, query.getResultList().toString().indexOf("]"));
    }

    @Override
    public List sumOrrder(String start, String end) {
        //khoi tao gia tri tra ve 
        List listAll = new ArrayList();
        List listA = null, listB = null;
        String string = null;
        List listDay = new ArrayList();
        //danh sach  so order da thanh toan
        listA = orderPaid(start, end);
        //danh sach  so order chua thanh toan
        listB = orderPaidNull(start, end);
        //danh sachs date da chon 
        List listDate = SuLy.SuLyDate.dates(start, end);
        //danh sach Day da chon 
        List listDays = SuLy.SuLyDate.days(start, end);
        //gan gia tri dau tien 
        listAll.add("['','Paid', 'Unpaid']");
        for (int i = 0; i < listDate.size(); i++) {
            string = "['" + listDays.get(i).toString() + "'," + listA.get(i) + "," + listB.get(i) + "]";
            listAll.add(string);
        }
        return listAll;
    }

    //su ly truy van sql 
    //duyb xuat order da thanh toan 
    public List orderPaid(String start, String end) {
        //Lay danh sach date trong thangs 
        List listDate = SuLy.SuLyDate.dates(start, end);
        //khoi tao danh schs ket qua tra ve 
        List priceAll = new ArrayList();
        for (int i = 0; i < listDate.size(); i++) {
            //truy van theo ngay 
            String sumOnDate = orderPaidChild(listDate.get(i).toString());
            if (!sumOnDate.equals("[null]")) {
                priceAll.add(locGiaTri(sumOnDate));
            } else {
                priceAll.add("0");
            }
        }
        return priceAll;
    }

    public String orderPaidChild(String end) {
        String sql = "select COUNT(OrderID) from Orders  "
                + "where  datediff(day,DayTrading, ?) = 0   and Status=1 and TransactionStatus=1";
        Query query = em.createNativeQuery(sql);
        query.setParameter(1, end);
        return query.getResultList().toString();
    }

    //truy xuat order chua thanh toan 
    public List orderPaidNull(String start, String end) {
        //Lay danh sach date trong thangs 
        List listDate = SuLy.SuLyDate.dates(start, end);
        //khoi tao danh schs ket qua tra ve 
        List priceAll = new ArrayList();
        for (int i = 0; i < listDate.size(); i++) {
            //truy van theo ngay
            String sumOnDate = orderPaidChildNull(listDate.get(i).toString());
            if (!sumOnDate.equals("[null]")) {
                priceAll.add(locGiaTri(sumOnDate));
            } else {
                priceAll.add("0");
            }
        }
        return priceAll;
    }

    public String orderPaidChildNull(String end) {
        String sql = "select COUNT(OrderID) from Orders  "
                + "where  datediff(day,DayTrading, ?) = 0   and    Status =1  and TransactionStatus is null ";
        Query query = em.createNativeQuery(sql);
        query.setParameter(1, end);
        return query.getResultList().toString();
    }

    @Override
    public String getNote(String idOrder) {
        String sql = "select Note from Orders "
                + "where OrderID = ?";
        Query query = em.createNativeQuery(sql);
        query.setParameter(1, idOrder);
        String tam = null;
       if (!query.getResultList().toString().equals("[null]")) {
            tam = query.getResultList().get(0).toString();
        } else {
            tam = "null";
        }
        return tam;
    }
}
