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
    public partial class Default : System.Web.UI.Page
    {
        String MyConString = "server=localhost;port=3900;User Id=gvm;database=dados;password=gvmsistemas#";

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadTable();
        }


        private void LoadTable()
        {

            // Cria a lista de itens
            MySqlConnection conn = new MySqlConnection(MyConString);
            MySqlCommand cmd = new MySqlCommand("select ft.recnum as recnum," +
                                                "ft.fkficha as ficha," +
                                                "op.descricao as operacao," +
                                                "concat(p.descricao, if (v.fkdetalhe is null, '',concat(' - ', d.descricao_completa))) as desc_produto," +
                                                "DATE_FORMAT(ft.inicio, '%d-%m-%y às %H:%i:%s') as inicio," +
                                                "DATE_FORMAT(ft.fim, '%d-%m-%y às %H:%i:%s') as fim, " +
                                                "ft.quantidade as quantidade, " +
                                                "ft.situacao as situacao " +
                                                "from fichatempo ft " +
                                                "inner join fichaproducao fp on fp.recnum = ft.fkficha " +
                                                "inner join producaooperacao op on op.recnum = ft.fkoperacao " +
                                                "inner join variacao v on v.recnum = fp.fkvariacao " +
                                                "left join detalhe d on d.recnum = v.fkdetalhe " +
                                                "inner join produto p on p.recnum = v.fkproduto "  +
                                                "order by recnum desc limit 50;", conn);
            conn.Open();
            DataTable dataTable = new DataTable();
            MySqlDataAdapter da = new MySqlDataAdapter(cmd);
            da.Fill(dataTable);
            conn.Close();

            // Envia a lista de itens para a grid GDVItemSalada
            GDVFichaTempo.DataSource = dataTable;
            GDVFichaTempo.DataBind();

        }
    }
}