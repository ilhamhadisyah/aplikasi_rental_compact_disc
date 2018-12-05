/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Form;

/**
 *
 * @author USER
 */
public class DataPinjam {

    public String nrp, nama_brg, jml_pinjam, tgl_pinjam, tgl_kembali;

    public DataPinjam() {
    }

    public DataPinjam(String nrp, String nama_brg, String jml_pinjam, String tgl_pinjam, String tgl_kembali) {
        this.nrp = nrp;
        this.nama_brg = nama_brg;
        this.jml_pinjam = jml_pinjam;
        this.tgl_pinjam = tgl_pinjam;
        this.tgl_kembali = tgl_kembali;
    }

    public String getNRP() {
        return nrp;
    }

    public String getBarang() {
        return nama_brg;
    }

    public String getJml() {
        return jml_pinjam;
    }

    public String getTglPinjam() {
        return tgl_pinjam;
    }

    public String getTglKembali() {
        return tgl_kembali;
    }
}
