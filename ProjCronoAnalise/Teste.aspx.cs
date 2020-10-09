using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;
using System.Windows;


namespace ProjCronoAnalise
{
    public partial class Teste : System.Web.UI.Page
    {

        String MyConString = "server=localhost;port=3900;User Id=gvm;database=dados;password=gvmsistemas#";

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadTable();
            MySqlConnection connop = new MySqlConnection(MyConString);
            connop.Open();
            MySqlCommand cmdop = new MySqlCommand(" select descricao from producaooperacao ", connop);
            MySqlDataReader drop = cmdop.ExecuteReader();
            DataTable dtop = new DataTable();
            dtop.Load(drop);
            DropDownList1.DataSource = dtop;
            DropDownList1.DataTextField = "descricao";
            DropDownList1.DataValueField = "descricao";
            DropDownList1.DataBind();
            connop.Close();
        }


        private void LoadTable()
        {

            // Cria a lista de itens
            MySqlConnection conn = new MySqlConnection(MyConString);
            MySqlCommand cmd = new MySqlCommand("SELECT recnum, login FROM usuario limit 5;", conn);
            conn.Open();
            DataTable dataTable = new DataTable();
            MySqlDataAdapter da = new MySqlDataAdapter(cmd);
            da.Fill(dataTable);

            // Envia a lista de itens para a grid GDVItemSalada
            GDVUsuario.DataSource = dataTable;
            GDVUsuario.DataBind();
                        
        }
    }
}