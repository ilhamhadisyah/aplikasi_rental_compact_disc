/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Koneksi;

import Form.FormMenu;
import java.awt.HeadlessException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JComboBox;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author ilham
 */
public class dataSource {
    private Connection conn = new Koneksi().connect();
    private DefaultTableModel tabmode;
    
    public DefaultTableModel cd_select() {
        Object[] Baris = {"ID CD", "Judul", "Stock"};
        tabmode = new DefaultTableModel(null, Baris);
        String sql = "select * from barang";
        try {
            java.sql.Statement stat = conn.createStatement();
            ResultSet hasil = stat.executeQuery(sql);
            while (hasil.next()) {
                String ID_Barang = hasil.getString("ID_Barang");
                String judul_cd = hasil.getString("judul_cd");
                String Stock = hasil.getString("Stock");

                String[] data = {ID_Barang, judul_cd, Stock};
                tabmode.addRow(data);
            }
        } catch (Exception e) {

        }
        return tabmode;
    }
    //--------------------------------------------------------------------------
    public boolean cd_insert(String id,String nama,String stok) throws HeadlessException {
        boolean kondisi = false;
        String sql = "insert into barang(ID_Barang,judul_cd,Stock) values (?,?,?)";
        try {
            PreparedStatement stat = conn.prepareStatement(sql);
            stat.setString(1, id);
            stat.setString(2, nama);
            stat.setString(3, stok);
            System.out.println(id);
            System.out.println(nama);
            System.out.println(stok);
            
            stat.executeUpdate();
            JOptionPane.showMessageDialog(null, "DATA BERHASIL DISIMPAN");
            kondisi = true;
            
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "ERROR INPUT");
           
        }
        return kondisi;
    }
    //--------------------------------------------------------------------------
    public boolean cd_delete(String id) throws HeadlessException {
        boolean kondisi = false;
        String sql = "delete from barang where ID_Barang = '" + id + "'";
        try {
            PreparedStatement stat = conn.prepareStatement(sql);
            stat.executeUpdate();
            JOptionPane.showMessageDialog(null, "DATA BERHASIL DIHAPUS");
            kondisi= true;
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "data gagal dihapus" + e);
        }
        return kondisi;
    } 
    public boolean cd_update(String id,String nama,String stok) throws HeadlessException {
        boolean kondisi = false;
        try {
            String sql = "update barang set ID_Barang=?, judul_cd=?, Stock=? where ID_Barang='" + id + "'";
            PreparedStatement stat = conn.prepareStatement(sql);
            stat.setString(1, id);
            stat.setString(2, nama);
            stat.setString(3, stok);
            
            stat.executeUpdate();
            JOptionPane.showMessageDialog(null, "DATA BERHASIL DIUBAH");
            kondisi= true;
           
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "DATA GAGAL DIUBAH" + e);
        }
        return kondisi;
    }
    //--------------------------------------------------------------------------
    
    public DefaultTableModel kembali_select(String user) {
        Object[] Baris = {"ID cd","Judul", "Jumlah Pinjam", "Tanggal Pinjam", "Tanggal Kembali"};
        tabmode = new DefaultTableModel(null, Baris);
        
        String sql = "SELECT barang.id_barang, login.nrp,judul_cd,SUM(jmlpinjam)as jml,tgl_pinjam, tgl_kembali "
                + "FROM peminjaman,barang,login "
                + "WHERE barang.id_barang=peminjaman.id_barang "
                + "AND login.nrp=peminjaman.nrp AND login.nrp='" + user + "'"
                + "GROUP by peminjaman.ID_barang";
        try {
            java.sql.Statement stat = conn.createStatement();
            ResultSet hasil = stat.executeQuery(sql);
            while (hasil.next()) {
                String nrp = hasil.getString("nrp");
                String id = hasil.getString("id_barang");
                String brg = hasil.getString("judul_cd");
                String jml = hasil.getString("jml");
                String pinjam = hasil.getString("tgl_pinjam");
                String kembali = hasil.getString("tgl_kembali");

                String[] data = {id, brg, jml, pinjam, kembali};
                tabmode.addRow(data);
            }
        } catch (Exception e) {

        }
        return tabmode;
    }
    //--------------------------------------------------------------------------
    public boolean kembali_insert(String user,String id, String jml, String pinjam, String kembali) throws HeadlessException {
        boolean kondisi = false;
        try {
            String sql = "insert into pengembalian(id_barang,nrp,jmlpinjam, tgl_pinjam,tgl_kembali) values ('" +
                    id + "','" + user + "','" + jml + "','" + pinjam + "','" + kembali + "')";
            PreparedStatement stat = conn.prepareStatement(sql);
            stat.execute();
            JOptionPane.showMessageDialog(null, "BARANG DIKEMBALIKAN");
            kondisi = true;
            String delete="delete from peminjaman where id_barang='"+id+"' AND nrp='"+user+"' AND tgl_pinjam='"+pinjam+"'";
            PreparedStatement statdel = conn.prepareStatement(delete);
            statdel.executeUpdate(delete);
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex);
        }
        return kondisi;
    }
    //--------------------------------------------------------------------------
    public DefaultTableModel keranjang_select(String username) {
        Object[] Baris = {"Judul", "Jumlah Pinjam", "Tanggal Pinjam", "Tanggal Kembali"};
        tabmode = new DefaultTableModel(null, Baris);
        
        String sql = "SELECT login.nrp,judul_cd,SUM(jmlpinjam)as jml,tgl_pinjam, tgl_kembali "
                + "FROM peminjaman,barang,login "
                + "WHERE barang.id_barang=peminjaman.id_barang "
                + "AND login.nrp=peminjaman.nrp AND login.nrp='" + username + "'"
                + "GROUP by peminjaman.ID_barang";
        try {
            java.sql.Statement stat = conn.createStatement();
            ResultSet hasil = stat.executeQuery(sql);
            while (hasil.next()) {
                String nrp = hasil.getString("nrp");
                String brg = hasil.getString("judul_cd");
                String jml = hasil.getString("jml");
                String pinjam = hasil.getString("tgl_pinjam");
                String kembali = hasil.getString("tgl_kembali");

                String[] data = {brg, jml, pinjam, kembali};
                tabmode.addRow(data);
            }
        } catch (Exception e) {

        }
        return tabmode;
    }
   
        //----------------------------------------------------------------------
    public boolean login(String username,String Password) throws HeadlessException {
        boolean kondisi = false;
        String sql = "select NRP, Password from login where NRP=? AND Password=?";
        try {
            PreparedStatement stat = conn.prepareStatement(sql);
            stat.setString(1, username);
            stat.setString(2, Password);
            ResultSet result = stat.executeQuery();
            if (result.next()) {
                JOptionPane.showMessageDialog(null, "Login Sukses");
                new FormMenu().setVisible(true);
                kondisi= true;
                
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Login Gagal");
            
        }
        return kondisi;
    }
    //--------------------------------------------------------------------------
    public ResultSet pinjam_select() {
        ResultSet result = null;
        try {
            String sql = "select id_barang,judul_cd from barang";
            Statement stat = conn.createStatement();
            result = stat.executeQuery(sql);
            
        } catch (SQLException ex) {
            Logger.getLogger(dataSource.class.getName()).log(Level.SEVERE, null, ex);
        }
    return result;
}
    public ResultSet pinjam_add(String list) throws SQLException {
        String queryi = "select id_barang,stock from barang where judul_cd = '" + list + "'";
        PreparedStatement pst1 = conn.prepareStatement(queryi);
        ResultSet rs = pst1.executeQuery();
        return rs;
    }
    
    public ResultSet pinjam_select(String b) throws SQLException {
        String queryi = "select id_barang from barang where judul_cd = '" + b + "'";
        PreparedStatement pst1 = conn.prepareStatement(queryi);
        ResultSet rs = pst1.executeQuery();
        return rs;
    }
    public void pinjam_insert(String a, String c, String zzz, String d, String e) throws SQLException {
        String query = "Insert into peminjaman(NRP,JmlPinjam,ID_Barang, Tgl_Pinjam,Tgl_Kembali) values ('" + a + "','" + c + "','" + zzz + "','" + d + "','" + e + "')";
        PreparedStatement pst = conn.prepareStatement(query);
        pst.execute();
    }
}
    /*
     public String[] pinjam_add() {
        String[] item = new String[10];
        int a =0;
        try {
            String sql = "select id_barang,judul_cd from barang";
            Statement stat = conn.createStatement();
            ResultSet result = stat.executeQuery(sql);
            while (result.next()) {
                item[a] = result.getString(2);
                a++;
                //list_brg.addItem(result.getString(2));
            }
        } catch (SQLException e) {
        }
        return item;
    }
        
        
    */
   
        
        
    

