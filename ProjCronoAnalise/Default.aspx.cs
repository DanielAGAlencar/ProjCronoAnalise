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
using Org.BouncyCastle.Bcpg;

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
                                                " ft.obs as observacao, " +
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

        protected void GDVFichaTempo_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "A")
            {


                int line = int.Parse(e.CommandArgument.ToString());
                int id_fichatempo = int.Parse(GDVFichaTempo.Rows[line].Cells[0].Text);
                string desc_operacao = string.Format(GDVFichaTempo.Rows[line].Cells[2].Text);
                string obs = (string.Format(GDVFichaTempo.Rows[line].Cells[7].Text));
                string situacao = string.Format(GDVFichaTempo.Rows[line].Cells[8].Text);
                int ficha = int.Parse(GDVFichaTempo.Rows[line].Cells[1].Text);

                lblFichaPausarCancelar.Text = ficha.ToString();
                lblFichaFinalizarCancelar.Text = ficha.ToString();
                lblFichaCancelar.Text = ficha.ToString();
                lblIDPausarCancelar.Text = id_fichatempo.ToString();
                lblIDFinalizarCancelar.Text = id_fichatempo.ToString();
                lblIDCancelar.Text = id_fichatempo.ToString();
                lblObsPausarCancelar.Text = obs.ToString().Replace("&nbsp;", "");
                lblObsFinalizarCancelar.Text = obs.ToString().Replace("&nbsp;", "");
                lblObeservacaoCancelar.Text = obs.ToString().Replace("&nbsp;", "");
                lblOperacaoFinalizarCancelar.Text = desc_operacao.ToString();
                lblOperacaoPausarCancelar.Text = desc_operacao.ToString();
                lblOperacaoCancelar.Text = desc_operacao.ToString();
                lblSituacaoFinalizarCancelar.Text = situacao.ToString();
                lblSituacaoPausarCancelar.Text = situacao.ToString();
                lblSituacaoCancelar.Text = situacao.ToString();

                if (situacao == "INICIADO")
                {
                    DisplayModalPausarFinalizarCancelarProducao(this);
                }
                if (situacao == "PAUSADO")
                {
                    DisplayModalFinalizarIniciarCancelarProducao(this);
                }
                if (situacao == "FINALIZADO")
                {
                    DisplayModalCancelarProducao(this);
                }
                if (situacao == "CANCELADO")
                {
                    lblMsg.Text = "Documento cancelado não podem ser alterados!";
                    DisplayModalMsgDefault(this);
                }

            }

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

        //Confirmar cria/inicializa produção
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
                lblMsg.Text = "Erro!";
                DisplayModalMsgDefault(this);
            }

        }

        //Confirmar pausa produção iniciada
        protected void btnConfirmPausaProducao_Click(object sender, EventArgs e)
        {
            int id_fichatempo = int.Parse(lblIDPausarCancelar.Text);
            string observacao = string.Format(lblObsPausarCancelar.Text);

            try
            {
                MySqlConnection conn = new MySqlConnection(MyConString);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(" update fichatempo " +
                                                    " set stop_tempo = now(), " +
                                                    " tempo_gasto = tempo_gasto + TIMESTAMPDIFF(MINUTE, start_tempo, now()), " +
                                                    " quantidade = null, " +
                                                    " desconto = null, " +
                                                    " obs = '"+ observacao + "', " +
                                                    " situacao = 'PAUSADO' " +
                                                    " where recnum = " +
                                                    id_fichatempo , conn);
                cmd.ExecuteNonQuery();
                conn.Close();
                LoadTable();
            }

            catch
            {
                lblMsg.Text = "Erro!";
                DisplayModalMsgDefault(this);
            }

        }

        //Confirmar finaliza produção iniciada
        protected void btnConfirmFinalizarProducaoX_Click(object sender, EventArgs e)
        {
            int id_fichatempo = int.Parse(lblIDPausarCancelar.Text);
            string observacao = string.Format(lblObsPausarCancelar.Text);
            string desconto = string.Format(lblDescontoPausarCancelar.Text);

            try
            {
                MySqlConnection conn = new MySqlConnection(MyConString);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(" update fichatempo " +
                                                    " set stop_tempo = now(), " +
                                                    " tempo_gasto = tempo_gasto + TIMESTAMPDIFF(MINUTE, start_tempo, now()), " +
                                                    " quantidade = 2, " +
                                                    " desconto = '0', " +
                                                    " obs = '" + observacao + "', " +
                                                    " desconto = '" + desconto + "', " +
                                                    " situacao = 'FINALIZADO' " +
                                                    " where recnum = " +
                                                    id_fichatempo, conn);
                cmd.ExecuteNonQuery();
                conn.Close();
                LoadTable();
            }

            catch
            {
                lblMsg.Text = "Erro!";
                DisplayModalMsgDefault(this);
            }

        }

        //Confirmar cancela produção iniciada
        protected void btnConfirmCancelarProducao_Click(object sender, EventArgs e)
        {
            int id_fichatempo = int.Parse(lblIDPausarCancelar.Text);
            string observacao = string.Format(lblObsPausarCancelar.Text);

            try
            {
                MySqlConnection conn = new MySqlConnection(MyConString);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(" update fichatempo " +                                                    
                                                    " set situacao = 'CANCELADO', " +
                                                    " obs = '" + observacao + "' " +
                                                    " where recnum = " +
                                                    id_fichatempo, conn);
                cmd.ExecuteNonQuery();
                conn.Close();
                LoadTable();
            }

            catch
            {
                lblMsg.Text = "Erro!";
                DisplayModalMsgDefault(this);
            }

        }

        //Confirmar finaliza produção pausada
        protected void btnConfirmFinalizarProducao_Click(object sender, EventArgs e)
        {
            int id_fichatempo = int.Parse(lblIDPausarCancelar.Text);
            string observacao = string.Format(lblObsFinalizarCancelar.Text);
            string desconto = string.Format(lblDescontoFinalizarCancelar.Text);

            try
            {
                MySqlConnection conn = new MySqlConnection(MyConString);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(" update fichatempo " +
                                                    " set stop_tempo = now(), " +
                                                    " tempo_gasto = tempo_gasto + TIMESTAMPDIFF(MINUTE, start_tempo, now()), " +
                                                    " quantidade = 2, " +
                                                    " desconto = '0', " +
                                                    " obs = '" + observacao + "', " +
                                                    " desconto = '" + desconto + "', " +
                                                    " situacao = 'FINALIZADO' " +
                                                    " where recnum = " +
                                                    id_fichatempo, conn);
                cmd.ExecuteNonQuery();
                conn.Close();
                LoadTable();
            }

            catch
            {
                lblMsg.Text = "Erro!";
                DisplayModalMsgDefault(this);
            }

        }

        //Confirmar reinicia produção pausada
        protected void btnConfirmReiniciarProducao_Click(object sender, EventArgs e)
        {
            int id_fichatempo = int.Parse(lblIDPausarCancelar.Text);
            string observacao = string.Format(lblObsFinalizarCancelar.Text);

            try
            {
                MySqlConnection conn = new MySqlConnection(MyConString);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(" update fichatempo " +
                                                    " set start_tempo = now(), " +
                                                    " stop_tempo = null, " +
                                                    " quantidade = null, " +
                                                    " desconto = null, " +
                                                    " obs = '" + observacao + "', " +
                                                    " situacao = 'INICIADO' " +
                                                    " where recnum = " +
                                                    id_fichatempo, conn);
                cmd.ExecuteNonQuery();
                conn.Close();
                LoadTable();
            }

            catch
            {
                lblMsg.Text = "Erro!";
                DisplayModalMsgDefault(this);
            }

        }

        //Confirmar cancela produção iniciada
        protected void btnConfirmCancelarProducao2_Click(object sender, EventArgs e)
        {
            int id_fichatempo = int.Parse(lblIDPausarCancelar.Text);
            string observacao = string.Format(lblObsFinalizarCancelar.Text);

            try
            {
                MySqlConnection conn = new MySqlConnection(MyConString);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(" update fichatempo " +
                                                    " set situacao = 'CANCELADO', " +
                                                    " obs = '" + observacao + "' " +
                                                    " where recnum = " +
                                                    id_fichatempo, conn);
                cmd.ExecuteNonQuery();
                conn.Close();
                LoadTable();
            }

            catch
            {
                lblMsg.Text = "Erro!";
                DisplayModalMsgDefault(this);
            }

        }

        //Confirmar cancela produção finalizada
        protected void btnConfirmCancelarProducao3_Click(object sender, EventArgs e)
        {
            int id_fichatempo = int.Parse(lblIDPausarCancelar.Text);
            string observacao = string.Format(lblObsFinalizarCancelar.Text);

            try
            {
                MySqlConnection conn = new MySqlConnection(MyConString);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(" update fichatempo " +
                                                    " set situacao = 'CANCELADO', " +
                                                    " obs = '" + observacao + "' " +
                                                    " where recnum = " +
                                                    id_fichatempo, conn);
                cmd.ExecuteNonQuery();
                conn.Close();
                LoadTable();
            }

            catch
            {
                lblMsg.Text = "Erro!";
                DisplayModalMsgDefault(this);
            }

        }

        // Exibe modal para pausar/cancelar produção
        private void DisplayModalPausarFinalizarCancelarProducao(Page page)
        {
            ClientScript.RegisterStartupScript(typeof(Page),
                                               Guid.NewGuid().ToString(),
                                               "MostrarModalPausarFinalizarCancelarProducao();",
                                               true);
        }

        // Exibe modal para finalizar/cancelar produção
        private void DisplayModalFinalizarIniciarCancelarProducao(Page page)
        {
            ClientScript.RegisterStartupScript(typeof(Page),
                                               Guid.NewGuid().ToString(),
                                               "MostrarModalFinalizarIniciarCancelarProducao();",
                                               true);
        }

        // Exibe modal para cancelar produção finalizada
        private void DisplayModalCancelarProducao(Page page)
        {
            ClientScript.RegisterStartupScript(typeof(Page),
                                               Guid.NewGuid().ToString(),
                                               "MostrarModalCancelarProducao();",
                                               true);
        }

        //Mostar modal de Msg Erro
        private void DisplayModalMsgDefault(Page page)
        {
            ClientScript.RegisterStartupScript(typeof(Page),
                                               Guid.NewGuid().ToString(),
                                               "MostrarModalMsgDefault();",
                                               true);
        }
    }
}