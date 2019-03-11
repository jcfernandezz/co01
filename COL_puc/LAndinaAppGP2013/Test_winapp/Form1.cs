using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
//using Microsoft.Dexterity.Shell;

using Comun;
using MVP.gpCustom;
//using PPERLookup;
using MyGeneration.dOOdads;

namespace gp.localizacionAndina
{
    public partial class Form1 : Form, IPlanGeneralView
    {
        static GPFrmPlanGeneralyMapeo GPFrmPlanLocalyMapeo;

        //static PlanillaLookup FrmPlanillaLookup;
        private PlanGeneralPresenter _presenter;
        private bool _isDirty;
        private bool _isNew;
        private bool _suppressEvents = false;

        private int _columnaActual = 0;
        static private int _filaActual = 0;
        private short _cuentaPucActualNivel = 0;
        private string _cuentaPucActual = "";
        private string _cuentaPucActualDesc = "";
        private string _cuentaPucActualNivelDesc = "";
        private MapeoModelo _mapeoCuentaActual = new MapeoModelo();
        private nsaPUC_GL10000 _arbolPlanCuentas = null;
        private tii_mapeo_puc _mapeoCuentas = null;

        private List<int> _listaFilasModificadas = new List<int>();
        private List<int> _listaIsDirtyMapeo = new List<int>();
        private BindingSource binSNsaPUC_GL10000 = new BindingSource();
        private BindingSource binStii_mapeo_puc = new BindingSource();

        private int _colNivel = 0;
        private int _colCuenta = 1;
        private int _colDescripcion = 2;
        private int _colMapeoCuentaGP = 0;
        private int _colMapeoCuentaPuc = 1;

        private ConexionDB DatosDB = new ConexionDB();

        public Form1()
        {
            this.WindowState = FormWindowState.Minimized;
            this.ShowInTaskbar = false;
            this.Visible = false;
            InitializeComponent();
        }
        private void Form1_Load(object sender, EventArgs e)
        {
            this.Hide();
            this.AbrirFrmGeneraPlanilla();
            //_presenter = new PlanGeneralPresenter(this, new PlanGeneralModelo(), new PlanGeneralService(DatosDB.DBDatos), DatosDB.DBDatos.Intercompany);
            //try
            //{
            //    _suppressEvents = true;
            //    //-- initialize presenter
            //    _presenter.Initialize();
            //    _isDirty = false;
            //}

            //finally
            //{
            //    _suppressEvents = false;
            //}
        }
        public void AbrirFrmGeneraPlanilla()    //(object sender, EventArgs e)
        {

            if (GPFrmPlanLocalyMapeo == null)
            {
                try
                {
                    GPFrmPlanLocalyMapeo = new GPFrmPlanGeneralyMapeo(DatosDB.DBDatos);
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
            else
            {
                if (GPFrmPlanLocalyMapeo.Created == false)
                {
                    GPFrmPlanLocalyMapeo = new GPFrmPlanGeneralyMapeo(DatosDB.DBDatos);
                }
            }

            // Always show and activate the WinForm
            GPFrmPlanLocalyMapeo.Show();
            GPFrmPlanLocalyMapeo.Activate();

            GPFrmPlanLocalyMapeo.Cierra += new GPFrmPlanGeneralyMapeo.LogHandler(cierraTodo);    //suscribe a cierre de forma
        }
        public void cierraTodo(string mensaje)
        {
            this.CloseForm();
        }







        //*************************************************************************
    /// <summary>
    /// Miembros de la interfaz IPlanillaView
    /// </summary>
    #region Propiedades de la interfaz IPlanillaView

        public int ColumnaActual
        {
            get { return _columnaActual; }
            set { _columnaActual = value; }
        }
        public short CuentaPucActualNivel
        {
            get { return _cuentaPucActualNivel; }
            set { _cuentaPucActualNivel = value; }
        }
        public string CuentaPucActual
        {
            get
            {
                return _cuentaPucActual;
            }
            set 
            {
                _cuentaPucActual = value; 
            }
        }
        public string CuentaPucActualDesc
        {
            get
            {
                return _cuentaPucActualDesc;
            }
            set 
            {
                _cuentaPucActualDesc = value; 
            }
        }
        public string CuentaPucActualNivelDesc
        {
            get
            {
                return _cuentaPucActualNivelDesc;
            }
            set
            {
                _cuentaPucActualNivelDesc = value;
            }
        }
        public MapeoModelo MapeoCuentaActual 
        {
            get
            {
                return _mapeoCuentaActual;
            }
            set
            {
                _mapeoCuentaActual = value;
            }
        }
        public List<Componente> componentesAsignados
        {
            get
            {
                return null;
            }
            set
            {
            }
        }

        public nsaPUC_GL10000 arbolPlanCuentas
        {
            get { return _arbolPlanCuentas; }
            set 
            {
                if (value != null)
                {
                    binSNsaPUC_GL10000.DataSource = null;  
                    binSNsaPUC_GL10000.DataSource = value.DefaultView;
                    dGridVPlanGeneral.DataSource = binSNsaPUC_GL10000;  

                    dGridVPlanGeneral.Columns[_colNivel].Width=40;
                    dGridVPlanGeneral.Columns[_colCuenta].Width=80;
                    //dGridVPlanGeneral.Columns[_colCuenta].ReadOnly = true;
                    dGridVPlanGeneral.Columns[_colDescripcion].Width=200;
                    dGridVPlanGeneral.Columns[_colNivel].HeaderText = "Nivel";
                    dGridVPlanGeneral.Columns[_colCuenta].HeaderText = "Cuenta Local";
                    dGridVPlanGeneral.Columns[_colDescripcion].HeaderText = "Descripción";

                    dGridVPlanGeneral.Refresh();
                }
                _arbolPlanCuentas = value;
            }
        }

        public tii_mapeo_puc MapeoCuentas
        {
            get { return _mapeoCuentas; }
            set 
            {
                binStii_mapeo_puc.DataSource = null;
                binStii_mapeo_puc.DataSource = value.DefaultView;
                dGridVMapeo.DataSource = binStii_mapeo_puc;
                _mapeoCuentas = value;

                dGridVMapeo.Columns[_colMapeoCuentaGP].Width = 100;
                dGridVMapeo.Columns[_colMapeoCuentaGP].HeaderText = "Cuenta GP";
                dGridVMapeo.Columns[_colMapeoCuentaPuc].Visible = false;
                dGridVMapeo.Refresh();

                if (binStii_mapeo_puc.Count > 0)
                {
                    MapeoCuentaActual.MapeoCuentaGp = dGridVMapeo[_colMapeoCuentaGP, 0].Value.ToString().Trim();
                    MapeoCuentaActual.MapeoCuentaPuc = dGridVMapeo[_colMapeoCuentaPuc, 0].Value.ToString().Trim();
                }
            }
        }

        public List<IPlanGeneral> CuentasPuc
        {
            get 
            {
                return null;
            }
            set
            {
            }
        }

        public bool IsDirty
        {
            get { return _isDirty; }
        }

        public bool ConfirmClose()
        {
            return MessageBox.Show("Are you sure you want to proceed?", "Question",
                                   MessageBoxButtons.YesNo,
                                   MessageBoxIcon.Question,
                                   MessageBoxDefaultButton.Button2) == DialogResult.Yes;
        }

        public void CloseForm()
        {
            this.Close();
        }

        public bool ConfirmDelete()
        {
            return MessageBox.Show("Are you sure you want to delete?", "Question",
                                   MessageBoxButtons.YesNo,
                                   MessageBoxIcon.Question,
                                   MessageBoxDefaultButton.Button2) == DialogResult.Yes;
        }

        public void ShowMessage(string message)
        {
            MessageBox.Show(message);
        }

        public void ShowValidationErrors(string errorMessages)
        {
            dGridVPlanGeneral.Rows[Convert.ToInt32(dGridVPlanGeneral.CurrentRow.Index)].ErrorText = errorMessages;
        }

        public void ShowValidationErrors(ErrorMessageCollection errorMessages)
        {
            try
            {
                dGridVPlanGeneral.Rows[Convert.ToInt32(dGridVPlanGeneral.CurrentRow.Index)].ErrorText = errorMessages.ToString();
            }
            catch (Exception gr) 
            {
                MessageBox.Show("[ShowValidationErrors] " + gr.Message);
            }
        }

        public void ShowValidationErrorsMapeo(string errorMessages)
        {
            dGridVMapeo.Rows[Convert.ToInt32(dGridVMapeo.CurrentRow.Index)].ErrorText = errorMessages;
        }

        public void ShowValidationErrorsMapeo(ErrorMessageCollection errorMessages)
        {
            try
            {
                dGridVMapeo.Rows[Convert.ToInt32(dGridVMapeo.CurrentRow.Index)].ErrorText = errorMessages.ToString();
            }
            catch { }
        }

        #endregion

    //*************************************************************************
    /// <summary>
    /// Métodos de la forma
    /// </summary>
    #region Métodos de la forma


        private void limpiar()
        {
        }

        private void refresh()
        {
            _presenter.Initialize();
            _isDirty = false;
        }

        private static bool filaActual(int contenido)
        {
            return contenido == _filaActual;
        }

        private static bool filaMarcada(int contenido)
        {
            return contenido == -1;
        }

        private bool guardarPucYDetalleActual()
        {
            _filaActual = binSNsaPUC_GL10000.Position;
            CuentaPucActualNivel = Convert.ToInt16(dGridVPlanGeneral[0, _filaActual].Value.ToString());
            CuentaPucActual = dGridVPlanGeneral[1, _filaActual].Value.ToString().Trim();
            CuentaPucActualDesc = dGridVPlanGeneral[2, _filaActual].Value.ToString().Trim();
            if (_presenter.Save())
            {
                _listaFilasModificadas.RemoveAll(filaActual);
                ShowValidationErrors("");

                for (int i = 0; i < _listaIsDirtyMapeo.Count; i++)
                {
                    if (dGridVMapeo.Rows[_listaIsDirtyMapeo[i]].ErrorText.ToString().Equals("Listo"))
                    {
                        dGridVMapeo.CurrentCell = this.dGridVMapeo[_colMapeoCuentaGP, _listaIsDirtyMapeo[i]];
                        MapeoCuentaActual.MapeoCuentaGp = dGridVMapeo.CurrentCell.Value.ToString().Trim();
                        MapeoCuentaActual.MapeoCuentaPuc = this.dGridVPlanGeneral[_colCuenta, _filaActual].Value.ToString().Trim();
                        _isDirty = true;
                        if (_presenter.SaveMapeo())
                        {
                            _listaIsDirtyMapeo[i] = -1;             //marca las filas guardadas
                            ShowValidationErrorsMapeo("");
                        }
                    }
                    else
                        if (dGridVMapeo.Rows[_listaIsDirtyMapeo[i]].ErrorText.ToString().Equals(""))
                            _listaIsDirtyMapeo[i] = -1;                 //marca las filas guardadas

                }
                _listaIsDirtyMapeo.RemoveAll(filaMarcada);          //elimina las filas marcadas
                //_suppressEvents = (_listaIsDirtyMapeo.Count != 0);
                _isDirty = (_listaIsDirtyMapeo.Count != 0);
            }

            return (!_isDirty);
        }

    #endregion

    //*************************************************************************
    /// <summary>
    /// Eventos de la forma
    /// </summary>
    #region Eventos de la forma

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
           // e.Cancel = !_presenter.CloseForm(true);
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            int iOK = 0;
            string msj = "";
            try
            {
                if (guardarPucYDetalleActual())
                {
                    iOK++;
                    for (int i = 0; i < _listaFilasModificadas.Count; i++)
                    {
                        if (dGridVPlanGeneral.Rows[_listaFilasModificadas[i]].ErrorText.ToString().Equals("Listo"))
                        {
                            ColumnaActual = 0;
                            CuentaPucActualNivel = Convert.ToInt16(dGridVPlanGeneral[_colNivel, _listaFilasModificadas[i]].Value.ToString());
                            CuentaPucActual = dGridVPlanGeneral[_colCuenta, _listaFilasModificadas[i]].Value.ToString();
                            CuentaPucActualDesc = dGridVPlanGeneral[_colDescripcion, _listaFilasModificadas[i]].Value.ToString();
                            dGridVPlanGeneral.CurrentCell = this.dGridVPlanGeneral[_colNivel, _listaFilasModificadas[i]];

                            _isDirty = true;
                            if (_presenter.Save())
                            {
                                iOK++;
                                _listaFilasModificadas[i] = -1;             //marca las filas guardadas
                                ShowValidationErrors("");
                            }
                        }
                        else
                            if (dGridVPlanGeneral.Rows[_listaFilasModificadas[i]].ErrorText.ToString().Equals(""))
                                _listaFilasModificadas[i] = -1;                 //marca las filas guardadas
                    }
                    _listaFilasModificadas.RemoveAll(filaMarcada);          //elimina las filas marcadas
                    _isDirty = (_listaFilasModificadas.Count != 0);
                }
                
                if (iOK > 0)
                    msj = iOK.ToString() + " registro(s) guardado(s) exitosamente. \n";
                if (_listaFilasModificadas.Count != 0)
                    msj = msj + _listaFilasModificadas.Count.ToString() + " registro(s) incorrectos. Revíselos y vuelva a intentar.";
                if (!msj.Equals(""))
                    MessageBox.Show(msj);
            }
            catch (Exception ex)
            {
                MessageBox.Show(" Error al guardar un registro: " + ex.Message);
            }
        }

        private void txtbDescriPlanilla_TextChanged(object sender, EventArgs e)
        {
            if (_suppressEvents)
                return;

            _isDirty = true;
        }

        private void chlbxCompAsignados_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (_suppressEvents)
                return;

            _isDirty = true;
            _presenter.OnComponentesAsignadosChanged();

        }

        private void txtbIdPlanilla_TextChanged(object sender, EventArgs e)
        {
            if (_suppressEvents)
                return;

            _isDirty = true;
        }

        private void btnLimpiar_Click_1(object sender, EventArgs e)
        {
            this.AbrirFrmGeneraPlanilla();
            _isDirty = false;

        }

        private void txtbIdPlanilla_Leave(object sender, EventArgs e)
        {
            if (_suppressEvents)
                return;

            _isDirty = _presenter.OnIdPlanillaChanged();
            _isNew = _isDirty;
            txtbIdPlanilla.Enabled = false;
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                int iNumMapeos = binStii_mapeo_puc.Count;
                string cuentaPuc = dGridVPlanGeneral[_colCuenta, dGridVPlanGeneral.CurrentCell.RowIndex].Value.ToString().Trim();
                if (dGridVMapeo.SelectedCells.Count > 0 && iNumMapeos > 0)
                {
                    _filaActual = dGridVMapeo.CurrentCell.RowIndex;

                    if (_presenter.DeleteMapeo(dGridVMapeo[_colMapeoCuentaGP, _filaActual].Value.ToString().Trim(), cuentaPuc))
                    {
                        binStii_mapeo_puc.RemoveAt(_filaActual);
                        _listaIsDirtyMapeo.RemoveAll(filaActual);
                        _isDirty = (_listaIsDirtyMapeo.Count != 0);
                    }
                }

                if (dGridVPlanGeneral.SelectedCells.Count > 0 && iNumMapeos == 0)
                {
                    _filaActual = dGridVPlanGeneral.CurrentCell.RowIndex;

                    if (_presenter.Delete(cuentaPuc))
                    {
                        binSNsaPUC_GL10000.RemoveAt(_filaActual);
                        _listaFilasModificadas.RemoveAll(filaActual);
                        _isDirty = (_listaFilasModificadas.Count != 0);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("[btnEliminar] " + ex.Message);
            }
        }

        private void buttonPrimero_Click(object sender, EventArgs e)
        {
            if (_presenter.CloseForm(true))
            {
                this.limpiar();
                _presenter.getPrimero();
                txtbIdPlanilla.Enabled = false;
                _isDirty = false;
            }
        }

        private void buttonUltimo_Click(object sender, EventArgs e)
        {
            if (_presenter.CloseForm(true))
            {
                this.limpiar();
                _presenter.getUltima();
                txtbIdPlanilla.Enabled = false;
                _isDirty = false;
            }
        }

        private void buttonAnterior_Click(object sender, EventArgs e)
        {
            if (_presenter.CloseForm(true) && !this.txtbIdPlanilla.Text.Equals(string.Empty))
            {
                string idpl = this.txtbIdPlanilla.Text;
                this.limpiar();
                this.txtbIdPlanilla.Text = idpl;

                _presenter.getAnterior();
                txtbIdPlanilla.Enabled = false;
                _isDirty = false;
            }
        }

        private void buttonSiguiente_Click(object sender, EventArgs e)
        {
            if (_presenter.CloseForm(true))
            {
                string idpl = this.txtbIdPlanilla.Text;
                this.limpiar();
                this.txtbIdPlanilla.Text = idpl;

                _presenter.getSiguiente();
                txtbIdPlanilla.Enabled = false;
                _isDirty = false;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {

        }

        private void dGridVPlanGeneral_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
            if (_suppressEvents)
                return;
            if (e.RowIndex < 0 || e.ColumnIndex < 0)
                return;

            try
            {
                if (_listaIsDirtyMapeo.Count > 0)
                    if (MessageBox.Show("Desea guardar el detalle de cuentas GP? ", "", MessageBoxButtons.YesNo) == DialogResult.Yes)
                    {
                        if (!this.guardarPucYDetalleActual())
                            return;
                    }
                    else
                        _listaIsDirtyMapeo.Clear();

                if (dGridVPlanGeneral[_colCuenta, e.RowIndex].Value != null &&
                    dGridVPlanGeneral.Rows[e.RowIndex].ErrorText.ToString().Equals(""))
                {
                    _presenter.afterNodeSelect(dGridVPlanGeneral[_colCuenta, e.RowIndex].Value.ToString().Trim());
                    
                    dGridVPlanGeneral[_colCuenta, e.RowIndex].ReadOnly = true;
                }
                else
                    _presenter.afterNodeSelect("");
                
            }
            catch (Exception ex)
            {
                MessageBox.Show("[dGridVPlanGeneral_RowEnter]: " + ex.Message);
            }
        }

        private void dGridVPlanGeneral_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            if (_suppressEvents)
                return;

            try
            {
                ColumnaActual = e.ColumnIndex;
                CuentaPucActualNivel = Convert.ToInt16(dGridVPlanGeneral[_colNivel, e.RowIndex].Value.ToString());
                CuentaPucActual = dGridVPlanGeneral[_colCuenta, e.RowIndex].Value.ToString().Trim();
                CuentaPucActualDesc = dGridVPlanGeneral[_colDescripcion, e.RowIndex].Value.ToString().Trim();

                _isDirty = true;
                if (_presenter.Valida())
                {
                    _listaFilasModificadas.Add(e.RowIndex);
                    ShowValidationErrors("Listo");
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show("[dGridVPlanGeneral_CellEndEdit] " + ex.Message);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
                this.CloseForm();

            //_presenter.CloseForm(false);
        }

        private void dGridVMapeo_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            if (_suppressEvents)
                return;
            try
            {
                MapeoCuentaActual.MapeoCuentaGp = dGridVMapeo[_colMapeoCuentaGP, e.RowIndex].Value.ToString().Trim();
                MapeoCuentaActual.MapeoCuentaPuc = dGridVPlanGeneral[_colCuenta, binSNsaPUC_GL10000.Position].Value.ToString().Trim();
                _isDirty = true;
                if (_presenter.ValidaMapeo())
                {
                    _listaIsDirtyMapeo.Add(e.RowIndex);
                    ShowValidationErrorsMapeo("Listo");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("[dGridVMapeo_CellEndEdit] " + ex.Message);
            }
        }

        #endregion

        private void txtbDescriPlanilla_Leave(object sender, EventArgs e)
        {
        }

        private void dGridVPlanGeneral_CellEnter(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        private void dGridVPlanGeneral_RowValidating(object sender, DataGridViewCellCancelEventArgs e)
        {
            
        }

        private void dGridVPlanGeneral_CellValidating(object sender, DataGridViewCellValidatingEventArgs e)
        {
            
        }

        private void dGridVPlanGeneral_CellValidated(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        private void dGridVMapeo_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
            if (_suppressEvents)
                return;
            if (e.RowIndex < 0 || e.ColumnIndex < 0)
                return;

            try
            {
                if (dGridVMapeo[_colMapeoCuentaGP, e.RowIndex].Value != null &&
                    dGridVMapeo.Rows[e.RowIndex].ErrorText.ToString().Equals(""))
                {
                    dGridVMapeo[_colMapeoCuentaGP, e.RowIndex].ReadOnly = true;
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show("[dGridVMapeo_RowEnter]: " + ex.Message);
            }
        }

        private void btnActualizar_Click(object sender, EventArgs e)
        {
            this.refresh();
        }





    }
}