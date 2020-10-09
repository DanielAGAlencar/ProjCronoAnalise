using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
using MySql.Data.Types;
using System.Globalization;

namespace ProjCronoAnalise
{
    public partial class Default : System.Web.UI.Page
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
            string f_desc_produto = " where p.descricao like '%" + TxtDescricaoProduto_f.Text.Replace(' ','%') + "%' ";
            string f_data_c = " and data_criacao >= '" + DateTime.Parse(TxtDataCriacao_f.Text).ToString("yyyy-MM-dd") + " 00:00:00'";
            string f_situacao = " and ft.situacao like '%" + TxtSituacao_f.Text + "%' ";
            string f_ficha = " and fp.recnum like '%" + TxtFicha_f.Text + "%' ";

            // Cria a lista de itens
            MySqlConnection conn = new MySqlConnection(MyConString);
            MySqlCommand cmd = new MySqlCommand(" select ft.recnum as recnum, " +
                                                " ft.fkficha as ficha, " +
                                                " op.descricao as operacao, " +
                                                " concat(p.descricao, if (v.fkdetalhe is null, '',concat(' - ', d.descricao_completa))) as desc_produto, " +
                                                " DATE_FORMAT(ft.start_tempo, '%d-%m-%y às %H:%i:%s') as inicio, " +
                                                " DATE_FORMAT(ft.data_criacao, '%d-%m-%y às %H:%i:%s') as criacao, " +
                                                " DATE_FORMAT(ft.stop_tempo, '%d-%m-%y às %H:%i:%s') as fim, " +
                                                " ft.quantidade as quantidade, " +
                                                " ft.situacao as situacao " +
                                                " from fichatempo ft " +
                                                " inner join fichaproducao fp on fp.recnum = ft.fkficha " +
                                                " inner join producaooperacao op on op.recnum = ft.fkoperacao " +
                                                " inner join variacao v on v.recnum = fp.fkvariacao " +
                                                " left join detalhe d on d.recnum = v.fkdetalhe " +
                                                " inner join produto p on p.recnum = v.fkproduto "  +
                                                f_desc_produto +
                                                f_data_c +
                                                f_situacao +
                                                f_ficha +
                                                " order by recnum desc limit 50;", conn);
            conn.Open();
            DataTable dataTable = new DataTable();
            MySqlDataAdapter da = new MySqlDataAdapter(cmd);
            da.Fill(dataTable);
            conn.Close();

            // Envia a lista de itens para a grid GDVFichaTempo
            GDVFichaTempo.DataSource = dataTable;
            GDVFichaTempo.DataBind();

        }

        // Iniciar Produção
        protected void BtnIniciarProducao_Click(object sender, EventArgs e)
        {
            MySqlConnection connop = new MySqlConnection(MyConString);
            connop.Open();
            MySqlCommand cmdop = new MySqlCommand(" select descricao from producaooperacao ", connop);
            MySqlDataReader drop = cmdop.ExecuteReader();
            DataTable dtop = new DataTable();
            dtop.Load(drop);
            TxtOperacao.DataSource = dtop;
            TxtOperacao.DataTextField = "descricao";
            TxtOperacao.DataValueField = "descricao";
            TxtOperacao.DataBind();
            connop.Close();

            DisplayModalIniciarProducao(this);
        }

        // Exibe modal para iniciar produção
        private void DisplayModalIniciarProducao(Page page)
        {
            ClientScript.RegisterStartupScript(typeof(Page),
                                               Guid.NewGuid().ToString(),
                                               "MostrarModalIniciarProducao();",
                                               true);
        }

        //Confirmar cadastro
        protected void btnConfirmIniciarProducao_Click(object sender, EventArgs e)
        {
            string desc_operacao = TxtOperacao.Text;
            int ficha = int.Parse(TxtFicha.Text);

            try
            {
                MySqlConnection connft = new MySqlConnection(MyConString);
                connft.Open();
                MySqlCommand cmdft = new MySqlCommand("insert into fichatempo" +
                                                      "(fkficha, fkoperacao, data_criacao, start_tempo, stop_tempo, tempo_gasto, quantidade, desconto, obs, situacao) " +
                                                      "values(" + ficha + " , (select recnum from producaooperacao where descricao = '" + desc_operacao + "') " + ", now(), now(), null, '0', null, null, null, 'INICIADO');", connft);
                cmdft.ExecuteNonQuery();
                connft.Close();
                LoadTable();
            }

            catch
            {

            }

        }
    }
}