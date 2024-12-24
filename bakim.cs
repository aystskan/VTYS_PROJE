using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace VTYS_PROJE
{
    public partial class bakim : Form
    {
        public bakim()
        {
            InitializeComponent();
        }

        private void kullanici_Click(object sender, EventArgs e)
        {
            Form1 kullanici = new Form1();
            kullanici.Show();
        }

        private void tarla_Click(object sender, EventArgs e)
        {
            tarla t = new tarla();
            t.Show();
            this.Hide(); // Mevcut formu gizler
        }

        private void urunler_Click(object sender, EventArgs e)
        {
            urun u = new urun();
            u.Show();
            this.Hide();
        }

        private void label10_Click(object sender, EventArgs e)
        {
            ekipman ekipman = new ekipman();
            ekipman.Show();
            this.Hide();
        }

        private void ekim_Click(object sender, EventArgs e)
        {
            ekim ekim = new ekim();
            ekim.Show();
            this.Hide();
        }

        private void label3_Click(object sender, EventArgs e)
        {
            hasat h = new hasat();
            h.Show();
            this.Hide();
        }

        private void label8_Click(object sender, EventArgs e)
        {
            bolge bolge = new bolge();
            bolge.Show();
            this.Hide();
        }

        private void logout_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        NpgsqlConnection baglanti = new NpgsqlConnection("server = localHost; port=5432; Database=tarimProje; user ID=postgres; password=1");

        private void button3_Click(object sender, EventArgs e)
        {
            string sorgu = "select*from bakimislemi";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sorgu, baglanti);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];
        }

        private void button1_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            NpgsqlCommand komut1 = new NpgsqlCommand("INSERT INTO public.\"bakimislemi\" (\"BakimIslemiID\",\"EkimID\",\"BakimTuruID\",\"Tarih\",\"Sure\",\"EkipmanID\") VALUES (@p1,@p2,@p3,@p4,@p5,@p6)", baglanti);
            komut1.Parameters.AddWithValue("@p1", int.Parse(idtb.Text));
            komut1.Parameters.AddWithValue("@p2", int.Parse(ek.Text));
            komut1.Parameters.AddWithValue("@p3", int.Parse(tur.Text));
            komut1.Parameters.AddWithValue("@p4", dateTimePicker1.Value);
            komut1.Parameters.AddWithValue("@p5", int.Parse(sur.Text));
            komut1.Parameters.AddWithValue("@p6", int.Parse(ekip.Text));

            komut1.ExecuteNonQuery();
            baglanti.Close();
            MessageBox.Show("Ekleme gerçekleştirildi!");
        }

        private void buttonsil_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            NpgsqlCommand komut2 = new NpgsqlCommand("DELETE FROM public.\"bakimislemi\" WHERE \"BakimIslemiID\"=@p1", baglanti);
            komut2.Parameters.AddWithValue("@p1", int.Parse(idtb.Text));
            komut2.ExecuteNonQuery();
            baglanti.Close();
            MessageBox.Show("Silinme işlemi başarılı! ", "Bilgi",
                MessageBoxButtons.OK, MessageBoxIcon.Stop);
        }

        private void btnedit_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            NpgsqlCommand komut3 = new NpgsqlCommand("UPDATE public.\"bakimislemi\" SET  \"EkimID\"=@p2, \"BakimTuruID\"=@p3,\"Tarih\"=@p4,\"Süre\"=@p5,\"EkipmanID\"=@p6 WHERE \"BakimIslemiID\"=@p1", baglanti);
            komut3.Parameters.AddWithValue("@p1", int.Parse(idtb.Text));
            komut3.Parameters.AddWithValue("@p2", int.Parse(ek.Text));
            komut3.Parameters.AddWithValue("@p3", int.Parse(tur.Text));
            komut3.Parameters.AddWithValue("@p4", dateTimePicker1.Value);
            komut3.Parameters.AddWithValue("@p5", int.Parse(sur.Text));
            komut3.Parameters.AddWithValue("@p6", int.Parse(ekip.Text));
            komut3.ExecuteNonQuery();
            MessageBox.Show("Güncelleme işlemi başarılı! ", "Bilgi", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            baglanti.Close();
        }
    }
}
