using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;
using Renci.SshNet.Messages;

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
            string f_desc_produto = " and p.descricao like '%" + TxtDescricaoProduto.Text.Replace(' ','%') + "%' ";
            string f_desc_variacao = " and d.descricao_completa like '%" + TxtDescricaoVariacao.Text.Replace(' ', '%') + "%' ";
            string f_id_variacao = " and v.recnum like '%" + TxtIDVariacao.Text + "%' ";

            // Cria a lista de itens
            MySqlConnection conn = new MySqlConnection(MyConString);
            MySqlCommand cmd = new MySqlCommand(" select " +
                                                " p.referencia as referencia, " +
                                                " v.recnum as id_variacao, " +
                                                " p.descricao desc_produto, " +
                                                " d.descricao_completa as desc_variacao, " +
                                                " pt.tempopadrao as tempo, " +
                                                " pt.recnum as id_tempopadrao, " +
                                                " po.descricao as desc_operacao " +
                                                " from variacao v " +
                                                " left join detalhe d on d.recnum = v.fkdetalhe " +
                                                " inner join produto p on p.recnum = v.fkproduto " +
                                                " left join produtotempo pt on pt.fkvariacao = v.recnum " +
                                                " left join producaooperacao po on po.recnum = pt.fkoperacao " +
                                                " where v.situacao = 'A' " +
                                                " and p.situacao = 'A' " +
                                                " and p.origem = 'P' " +
                                                f_referencia +
                                                f_desc_produto +
                                                f_desc_variacao +
                                                f_id_variacao +
                                                " order by referencia, id_variacao limit 50;", conn);
            conn.Open();
            DataTable dataTable = new DataTable();
            MySqlDataAdapter da = new MySqlDataAdapter(cmd);
            da.Fill(dataTable);
            conn.Close();

            // Envia a lista de itens para a grid GDVItemSalada
            GDVProduto.DataSource = dataTable;
            GDVProduto.DataBind();

        }

        protected void GDVTempoPadrao_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            
            if (e.CommandName == "A")
            {
                

                int line = int.Parse(e.CommandArgument.ToString());
                int id_variacao = int.Parse(GDVProduto.Rows[line].Cells[1].Text);
                string desc_operacao = string.Format(GDVProduto.Rows[line].Cells[5].Text);
                string tempo_p = (string.Format(GDVProduto.Rows[line].Cells[6].Text)).Replace(",",".");                
                int id_tempo = int.Parse((string.Format(GDVProduto.Rows[line].Cells[4].Text)).Replace("&nbsp;","0"));

                lblIDVariacao.Text = id_variacao.ToString();
                lblIDVariacaoAlterarDeletar.Text = id_variacao.ToString();
                lblOperacaoAlterarDeletar.Text = desc_operacao;
                lblIDTempo.Text = id_tempo.ToString();
                TxtTempoAlterarDeletar.Text = tempo_p;
                TxtTempo.Text = "0.0";

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

                if (desc_operacao == "&nbsp;")                
                 {                     
                     DisplayModalCadastrar(this);
                 }
                else
                {
                    DisplayModalAcao(this);
                }

            }

        }
        
        // Mostrar modal de Ação
        private void DisplayModalAcao(Page page)
        {
            ClientScript.RegisterStartupScript(typeof(Page),
                                               Guid.NewGuid().ToString(),
                                               "MostrarModalAcao();",
                                               true);
        }

        // Botão Novo Cadastro na modal Ação
        protected void btnNovoCadastroTempo_Click(object sender, EventArgs e)
        {
            DisplayModalCadastrar(this);
        }

        protected void btnAlterarDeletar_Click(object sender, EventArgs e)
        {
            DisplayModalAlterarDeletar(this);
        }

        //Mostar modal de Cadastro
        private void DisplayModalCadastrar(Page page)
        {
            ClientScript.RegisterStartupScript(typeof(Page),
                                               Guid.NewGuid().ToString(),
                                               "MostrarModalCadastrar();",
                                               true);
        }

        //Confirmar cadastro
        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                int id_variacao = int.Parse(lblIDVariacao.Text);
                string desc_operacao = TxtOperacao.Text;
                string tempo = TxtTempo.Text;

                MySqlConnection connpt = new MySqlConnection(MyConString);
                connpt.Open();
                MySqlCommand cmdpt = new MySqlCommand(" insert into produtotempo (fkvariacao, fkoperacao, tempopadrao) " +
                                                    " values( " + id_variacao + " , " +
                                                    " (select recnum from producaooperacao where descricao = '" + desc_operacao + "') " +
                                                    " , " + tempo + " ); ", connpt);
                cmdpt.ExecuteNonQuery();
                connpt.Close();
                LoadTable();
                lblMsg.Text = "Cadastro feito com sucesso!";
                DisplayModalMsg(this);
            }
            catch
            {
                lblMsg.Text = "Já existe um cadastro de tempo dessa operação para essa variação!";
                DisplayModalMsg(this);
            }
            
        }

        //Mostar modal de Alterar/Deletar
        private void DisplayModalAlterarDeletar(Page page)
        {
            ClientScript.RegisterStartupScript(typeof(Page),
                                               Guid.NewGuid().ToString(),
                                               "MostrarModalAlterarDeletar();",
                                               true);
        }

        // Botão Alterar
        protected void btnAlterar_Click(object sender, EventArgs e)
        {
            int id_variacao = int.Parse(lblIDVariacao.Text);
            string desc_operacao = TxtOperacao.Text;
            string tempo = TxtTempoAlterarDeletar.Text;
            int id_tempo = int.Parse(lblIDTempo.Text);

            MySqlConnection conntp = new MySqlConnection(MyConString);
            conntp.Open();
            MySqlCommand cmdtp = new MySqlCommand(" update produtotempo set tempopadrao = '" +
                                                tempo + "'"+
                                                " where recnum = " +
                                                id_tempo, conntp);
            cmdtp.ExecuteNonQuery();
            conntp.Close();
            LoadTable();
            lblMsg.Text = "Cadastro alterado com sucesso!";
            DisplayModalMsg(this);

        }

        // Botão Deletar
        protected void btnDeletar_Click(object sender, EventArgs e)
        {
            int id_tempo = int.Parse(lblIDTempo.Text);

            MySqlConnection conntp = new MySqlConnection(MyConString);
            conntp.Open();
            MySqlCommand cmdtp = new MySqlCommand(" delete from produtotempo where recnum = " + id_tempo, conntp);
            cmdtp.ExecuteNonQuery();
            conntp.Close();
            LoadTable();
            lblMsg.Text = "Cadastro deletado com sucesso!";
            DisplayModalMsg(this);

        }        
        
        //Mostar modal de Msg Erro
        private void DisplayModalMsg(Page page)
        {
            ClientScript.RegisterStartupScript(typeof(Page),
                                               Guid.NewGuid().ToString(),
                                               "MostrarModalMsg();",
                                               true);
        }
    }
}