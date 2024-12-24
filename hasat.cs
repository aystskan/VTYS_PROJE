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
    public partial class hasat : Form
    {
        public hasat()
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
            this.Hide();
        }

        private void urunler_Click(object sender, EventArgs e)
        {
            urun u = new urun();
            u.Show();
            this.Hide();
        }

        private void label9_Click(object sender, EventArgs e)
        {
            ekipman ekipman = new ekipman();
            ekipman.Show();
            this.Hide();
        }

        private void bakim_Click(object sender, EventArgs e)
        {
            bakim bakim = new bakim();
            bakim.Show();
            this.Hide();
        }

        private void ekim_Click(object sender, EventArgs e)
        {
            ekim ekim = new ekim();
            ekim.Show();
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
        private void button2_Click(object sender, EventArgs e)
        {
            string sorgu = "select*from hasat";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sorgu, baglanti);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];
        }

        private void button1_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            NpgsqlCommand komut1 = new NpgsqlCommand("INSERT INTO public.\"hasat\" (\"HasatID\",\"EkimID\",\"HasatTarihi\",\"HasilatMiktari\") VALUES (@p1,@p2,@p3,@p4)", baglanti);
            komut1.Parameters.AddWithValue("@p1", int.Parse(id.Text));
            komut1.Parameters.AddWithValue("@p2", int.Parse(ek.Text));
            komut1.Parameters.AddWithValue("@p3", dateTimePicker1.Value);
            komut1.Parameters.AddWithValue("@p4", float.Parse(miktar.Text));
            komut1.ExecuteNonQuery();
            baglanti.Close();
            MessageBox.Show("Ekleme gerçekleştirildi!");
        }

        private void btnedit_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            NpgsqlCommand komut3 = new NpgsqlCommand("UPDATE public.\"hasat\" SET  \"EkimID\"=@p2, \"HasatTarihi\"=@p3, \"HasilatMiktari\"=@p4 WHERE \"HasatID\"=@p1", baglanti);
            komut3.Parameters.AddWithValue("@p1", int.Parse(id.Text));
            komut3.Parameters.AddWithValue("@p2", int.Parse(ek.Text));
            komut3.Parameters.AddWithValue("@p3", dateTimePicker1.Value);
            komut3.Parameters.AddWithValue("@p4", int.Parse(miktar.Text));
            komut3.ExecuteNonQuery();
            MessageBox.Show("Güncelleme işlemi başarılı! ", "Bilgi", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            baglanti.Close();
        }

        private void buttonsil_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            NpgsqlCommand komut2 = new NpgsqlCommand("DELETE FROM public.\"hasat\" WHERE \"HasatID\"=@p1", baglanti);
            komut2.Parameters.AddWithValue("@p1", int.Parse(id.Text));
            komut2.ExecuteNonQuery();
            baglanti.Close();
            MessageBox.Show("Silinme işlemi başarılı! ", "Bilgi",
                MessageBoxButtons.OK, MessageBoxIcon.Stop);
        }
    }
}
