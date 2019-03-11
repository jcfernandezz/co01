using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

using Comun;
using MVP.gpCustom;
using MyGeneration.dOOdads;

namespace PPERLookup
{
    public partial class PlanillaLookup : Form , IPlanGeneralView
    {
        private PlanGeneralPresenter _presenter;
        private bool _isDirty;
        private bool _suppressEvents = false;
        private ConexionAFuenteDatos _DatosConexion;
        private string _IdPlanilla = "";
        private bool _Selecciona = false;

        private int _columnaActual = 0;
        private short _cuentaPucActualNivel = 0;
        private string _cuentaPucActual = "";
        private string _cuentaPucActualDesc = "";
        private string _cuentaPucActualNivelDesc = "";
        private MapeoModelo _mapeoCuentaActual = null;

        public PlanillaLookup()
        {
            InitializeComponent();
        }

        public PlanillaLookup(ConexionAFuenteDatos DatosConexion, string textoABuscar)
        {
            InitializeComponent();
            _DatosConexion = DatosConexion;
            _IdPlanilla = textoABuscar;
        }

        //*************************************************************************
        // <summary>
        // Miembros de la interfaz IPlanillaView
        // </summary>
        #region Miembros de la interfaz IPlanillaView

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
                List<Componente> _componentesAsignados = new List<Componente>();
                return _componentesAsignados;
            }
            set
            {
            }
        }

        public nsaPUC_GL10000 arbolPlanCuentas 
        { 
            get
            {
                return null;
            }
            set { }
        }
        public tii_mapeo_puc MapeoCuentas
        {
            get { return null; }
            set
            {
            }
        }

        public List<IPlanGeneral> CuentasPuc
        {
            get {
                return null;
            }
            set 
            {
                dgViewLookup.DataSource = value;
                dgViewLookup.Refresh();
            }
        }

        public bool IsDirty
        {
            get
            {
                return _isDirty;
            }
        }

        public bool ConfirmClose()
        {
            return MessageBox.Show("Seguro que desea continuar?", "Question",
                                   MessageBoxButtons.YesNo,
                                   MessageBoxIcon.Question,
                                   MessageBoxDefaultButton.Button2) == DialogResult.Yes;
        }
        public void CloseForm()
        { 
        }

        public bool ConfirmDelete()
        {
            return MessageBox.Show("Seguro que quiere eliminar esta planilla?", "Question",
                                   MessageBoxButtons.YesNo,
                                   MessageBoxIcon.Question,
                                   MessageBoxDefaultButton.Button2) == DialogResult.Yes;
        }

        public void ShowMessage(string message)
        {
            MessageBox.Show(message);
        }
        public void ShowValidationErrors(ErrorMessageCollection errorMessages)
        {
            MessageBox.Show(errorMessages.ToString());
        }
        public void ShowValidationErrorsMapeo(ErrorMessageCollection errorMessages)
        {
            MessageBox.Show(errorMessages.ToString());
        }

        public bool Selecciona
        { 
            get{ return _Selecciona;}
        }

        #endregion

        private void PlanillaLookup_Load(object sender, EventArgs e)
        {
            _presenter = new PlanGeneralPresenter(this, new PlanGeneralModelo(), new PlanGeneralService(_DatosConexion), "");
            try
            {
                _suppressEvents = true;
                //-- initialize presenter
                _presenter.Initialize();
                _isDirty = false;

                if (_IdPlanilla.Equals(string.Empty))
                    _presenter.OnLoadLookup();
                else
                    _presenter.OnLoadLookup(_IdPlanilla);
            }
            finally
            {
                _suppressEvents = false;
            }
        }

        private void tsBtnBuscar_Click(object sender, EventArgs e)
        {
            _presenter = new PlanGeneralPresenter(this, new PlanGeneralModelo(), new PlanGeneralService(_DatosConexion), "");
            try
            {
                _suppressEvents = true;
                //-- initialize presenter
                _presenter.Initialize();
                _isDirty = false;
                
                if (tsTxtBxBuscar.Text.Trim().Equals(""))
                    _presenter.OnLoadLookup();
                else
                    _presenter.OnLoadLookup(tsTxtBxBuscar.Text);
            }
            finally
            {
                _suppressEvents = false;
            }
        }

        private void btnSeleccionar_Click(object sender, EventArgs e)
        {
            _Selecciona = true;
            this.Close();
        }
    }
}