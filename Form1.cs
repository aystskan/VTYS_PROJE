namespace VTYS_PROJE
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string secim = comboBox1.SelectedItem?.ToString();

            if (secim == "B�REYSEL KULLANICI")
            {
                bkullanici bireyselForm = new bkullanici();
                bireyselForm.Show();
                this.Hide(); // Mevcut formu gizler
            }
            else if (secim == "KURUMSAL KULLANICI")
            {
                kkullanici kurumsalForm = new kkullanici();
                kurumsalForm.Show();
                this.Hide(); // Mevcut formu gizler
            }
            else
            {
                MessageBox.Show("L�tfen bir kullan�c� t�r� se�iniz!", "Uyar�", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
