using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;

namespace ProjCronoAnalise
{
    public partial class CadastroTempoPadraoProducao : System.Web.UI.Page
    {

        String MyConString = "server=localhost;port=3900;User Id=gvm;database=dados;password=gvmsistemas#";

        protected void Page_Load(object sender, EventArgs e)
        {            
            LoadTable();
        }

        protected void BtnFiltrar_Click(object sender, EventArgs e)
        {
            LoadTable();
        }

        private void LoadTable()
        {
            string f_referencia = " and p.referencia like '%" + TxtReferencia.Text + "%' ";
            string f_desc_produto = " and p.descricao like '%" + TxtDescricao.Text + "%' ";
            string f_id_variacao = " and v.recnum like '%" + TxtIDVariacao.Text + "%' ";

            // Cria a lista de itens
            MySqlConnection conn = new MySqlConnection(MyConString);
            MySqlCommand cmd = new MySqlCommand(" select " +
                                                " p.referencia as referencia, " +
                                                " v.recnum as id_variacao, " +
                                                " concat(p.descricao, if (v.fkdetalhe is null, '',concat(' - ', d.descricao_completa))) as desc_produto " +
                                                " from variacao v " +
                                                " left join detalhe d on d.recnum = v.fkdetalhe " +
                                                " inner join produto p on p.recnum = v.fkproduto " +
                                                " where v.situacao = 'A' " +
                                                " and p.situacao = 'A' " +
                                                " and p.origem = 'P' " +
                                                f_referencia +
                                                f_desc_produto +
                                                f_id_variacao +
                                                " order by referencia limit 50;", conn);
            conn.Open();
            DataTable dataTable = new DataTable();
            MySqlDataAdapter da = new MySqlDataAdapter(cmd);
            da.Fill(dataTable);
            conn.Close();

            // Envia a lista de itens para a grid GDVItemSalada
            GDVProduto.DataSource = dataTable;
            GDVProduto.DataBind();

        }
    }
}