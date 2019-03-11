using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using Comun;

namespace MVP.gpCustom
{
    /// <summary>
    /// Plan general se refiere al plan de cuentas local (PUC)
    /// </summary>
    public class PlanGeneralPresenter
    {
        private IPlanGeneralView _view;
        private PlanGeneralModelo _model;       //Plan único de cuentas PUC
        private IPlanGeneralService _service;
        private Parametros _parametros;

        public PlanGeneralPresenter(IPlanGeneralView view, PlanGeneralModelo model, IPlanGeneralService service, string company)
        {
            _view = view;
            _model = model;
            _service = service;
            _parametros = new Parametros(company);
            _model.parametros = _parametros;
            _model.PropertyChanged += new System.ComponentModel.PropertyChangedEventHandler(Model_PropertyChanged);
            if (_parametros.iErr != 0)
            {
                _view.ShowMessage("Error al obtener los parámetros de configuración. Verifique el archivo ParámetrosLAndina.xml. [PlanGeneralPresenter] " + _parametros.ultimoMensaje);
            }

        }

        /////////////////////////////////////////////////////////////////
        #region ***** PROPIEDADES
        public ErrorMessageCollection ErrorMessages
        {
            get
            {
                return _model.ErrorMessages;
            }
        }
        #endregion

        /////////////////////////////////////////////////////////////////
        #region ***** METODOS 
        private void Model_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            //-- if you want to process data when item value was changed.
            switch (e.PropertyName)
            {
                case "Descripcion":
                    //-- code goes here
                    break;
                case "Cuenta":
                    //-- code goes here
                    break;
            }
        }
        public void Initialize()
        {
            getAll() ;
        }

        /// <summary>
        /// Confirm the user before closing the form.
        /// </summary>
        /// <param name="formClosing">set to true if you are exectuting the method inside the Form_Closing event to avoid stack overflow.</param>
        public bool CloseForm(bool formClosing)
        {
            bool result = true;

            if (_view.IsDirty)
            {
                result = _view.ConfirmClose();

                if (!result)
                {
                    return result;
                }
            }

            if (!formClosing)
            {
                _view.CloseForm();
            }

            return result;
        }
        public bool afterNodeSelect(string sText)
        {
            _view.MapeoCuentas = _service.Mapeo.getCuentasCorporaMapeadasA(sText);  
            return true;
        }

        /// <summary>
        /// Retorna true si la planilla es nueva o hay algún error
        /// </summary>
        /// <param name=""></param>
        public bool OnIdPlanillaChanged()
        {
            bool nuevoDato = false;
            if (!_view.CuentaPucActual.Equals(string.Empty))
                if (_service.get(_view.CuentaPucActual))
                {
                    _view.CuentaPucActual = _service.id;
                    _view.CuentaPucActualDesc = _service.descripcion;
                    //_view.componentesAsignados = _service.getComponentes(_view.IdPlanilla); //ParamIni.TipoComp[1].CodTipoComponente, 
                }
                else
                {
                    if (_service.ErrorMessages.Count>0)
                        _view.ShowValidationErrors(_service.ErrorMessages);
                    //else
                    //    _view.componentesAsignados = _service.getComponentes(string.Empty);
                    nuevoDato = true;
                }
            return nuevoDato;
            //Debug.WriteLine(String.Format("On Id Planilla Changed!!!!")            );
        }
        public void OnDescripcionPlanillaChanged()
        {
            _model.Cuenta = _view.CuentaPucActual;
            _model.Descripcion = _view.CuentaPucActualDesc;
            //_model.componentesAsignados = _view.componentesAsignados;

            //-- validate the data.
            if (!_model.Validate())
            {
                Debug.WriteLine("Messages: " + ErrorMessages);
                _view.ShowValidationErrors(ErrorMessages);
                ErrorMessages.Clear();
            }
        }
        public void OnComponentesAsignadosChanged()
        {
            Debug.WriteLine(
                String.Format("On Componentes Asignados Changed!!!!")
            );
        }
        public bool OnLoadLookup()
        {
            _view.CuentasPuc = _service.getLookup();
            if (_service.ErrorMessages.Count > 0)
            {
                _view.ShowValidationErrors(_service.ErrorMessages);
                return false;
            }
            else
                return true;
        }
        public bool OnLoadLookup(string Texto)
        {
            _view.CuentasPuc = _service.getLookup(Texto);
            if (_service.ErrorMessages.Count > 0)
            {
                _view.ShowValidationErrors(_service.ErrorMessages);
                return false;
            }
            else
                return true;
        }

        /// <summary>
        /// Llama a la validación del objeto modelo de la cuenta local puc
        /// </summary>
        /// <returns></returns>
        public bool Valida()
        {
            bool ok = true;
            if (!_view.IsDirty)
                return true; //-- no changes
            
            _model.Cuenta = _view.CuentaPucActual;
            _model.Descripcion = _view.CuentaPucActualDesc;
            _model.Nivel = _view.CuentaPucActualNivel;

            ok = _model.Validate();
            if (!ok)
                _view.ShowValidationErrors(ErrorMessages);

            ErrorMessages.Clear();
            return ok;
        }
        /// <summary>
        /// Validar la jerarquía de la cuenta local PUC
        /// </summary>
        /// <returns></returns>
        public bool ValidarEnBd()
        {
            try
            {
                //Valida formato de la cuenta local puc
                bool ok = this.Valida();
                if (ok)
                {
                    PlanLocal nivelBuscado = new PlanLocal(_model.Nivel.ToString(), _model.DescripcionNivel);
                    int posicion = _parametros.listaEstructuraPlanLocal.IndexOf(nivelBuscado);
                    if (posicion > 0)
                    {
                        int nivelPadre = Convert.ToInt16(_parametros.listaEstructuraPlanLocal[posicion-1].nivel);
                        if (_model.Cuenta.Length > 1 && !_service.get(_model.Cuenta.Substring(0, nivelPadre)))
                        {
                            ErrorMessages.Add(new ErrorMessage("La cuenta local es incorrecta. Verifique que pertenezca a una jerarquía."));
                            _view.ShowValidationErrors(ErrorMessages);
                            ok = false;
                        }
                    }
                }

                ErrorMessages.Clear();
                return ok;
            }
            catch(Exception val)
            {
                ErrorMessages.Add(new ErrorMessage("Error desconocido. " + val.Message));
                _view.ShowValidationErrors(ErrorMessages);
                ErrorMessages.Clear();
                return false;
            }
        }
        /// <summary>
        /// Llama a la validación del modelo del mapeo de cuentas
        /// </summary>
        /// <returns></returns>
        public bool ValidaMapeo()
        {
            bool ok = true;
            if (!_view.IsDirty)
                return true; //-- no changes

            _model.MapeoCuentas.Clear();
            _model.MapeoCuentas.Add(_view.MapeoCuentaActual);
            _model.MapeoCuentas[0].parametros = _parametros;
            ok = _model.MapeoCuentas[0].Validate();             //Valida la asociación de la cuenta corporativa con la cuenta local puc
            if (!ok)
                _view.ShowValidationErrorsMapeo(_model.MapeoCuentas[0].ErrorMessages);

            _model.MapeoCuentas[0].ErrorMessages.Clear();
            ErrorMessages.Clear();
            return ok;
        }
        /// <summary>
        /// Valida que la cuenta corporativa exista en GP. 
        /// La cuenta corporativa debe ser guardada en el formato: AAAA______AAA___A donde A representa los segmentos contables alfanuméricos.
        /// Si el mapeo es por segmento, basta con poner el segmento
        /// </summary>
        /// <returns></returns>
        public bool ValidaMapeoEnBd()
        {
            bool ok = this.ValidaMapeo();                       //Valida la asociación de la cuenta corporativa con la cuenta local puc
            if (ok)
            {
                _service.Mapeo.parametros = _parametros;
                if (_parametros.segmentoContable == "0")        //El mapeo es por segmento contable de GP? 0:no, 1:sí
                {
                    if (!_service.Mapeo.getCuentaGpByActnumstLike(_model.MapeoCuentas[0].MapeoCuentaGp))
                    {
                        ErrorMessages.Add(new ErrorMessage("La cuenta no existe en el plan de cuentas corporativo."));
                        _view.ShowValidationErrorsMapeo(ErrorMessages);
                    }
                }
                else
                    if (!_service.Mapeo.getPrimeraCuentaDeSegmentoGp(_model.MapeoCuentas[0].MapeoCuentaGp))
                    {
                        ErrorMessages.Add(new ErrorMessage("El segmento no existe en el plan de cuentas corporativo."));
                        _view.ShowValidationErrorsMapeo(ErrorMessages);
                    }

                if (_service.Mapeo.get(_model.MapeoCuentas[0].MapeoCuentaPuc, _model.MapeoCuentas[0].MapeoCuentaGp))
                {
                    ErrorMessages.Add(new ErrorMessage("Este mapeo ya existe."));
                    _view.ShowValidationErrorsMapeo(ErrorMessages);
                }

                //No importa si el mapeo es por segmento o por cuenta, debe obtener las cuentas locales puc mapeadas a una cuenta corporativa gp
                tii_mapeo_puc mapeo = _service.Mapeo.getCuentasLocalesMapeadasA(_model.MapeoCuentas[0].MapeoCuentaGp);
                if (mapeo != null)
                {
                    if (_service.Mapeo.pstngtyp == 1 &&             //cuenta de resultado
                        _parametros.pais.Equals("PERU"))            //validación que aplica a PERU
                    {
                        if (mapeo.RowCount == 1)
                        {
                            //Validar que la segunda cuenta local que se quiere mapear sea una sola cuenta 9
                            if ((mapeo.Codigopuc.Substring(0, 1).Equals("9") && _model.MapeoCuentas[0].MapeoCuentaPuc.Substring(0, 1).Equals("9")) ||
                                (!mapeo.Codigopuc.Substring(0, 1).Equals("9") && !_model.MapeoCuentas[0].MapeoCuentaPuc.Substring(0, 1).Equals("9")))
                            {
                                ErrorMessages.Add(new ErrorMessage("La cuenta corporativa ya está asignada a la cuenta local: " + mapeo.Codigopuc));
                                _view.ShowValidationErrorsMapeo(ErrorMessages);
                            }
                        }
                        if (mapeo.RowCount >= 2)
                        {
                            //Ya están asignadas dos cuentas locales (6 y 9) a una cuenta corporativa. No se permiten más.
                            for (int i=1; i <= 2; i++)
                            {
                                ErrorMessages.Add(new ErrorMessage("La cuenta corporativa ya está asignada a la cuenta local: " + mapeo.Codigopuc + ". Puede desasignarla y volver a intentar."));
                                mapeo.MoveNext();
                            }
                            _view.ShowValidationErrorsMapeo(ErrorMessages);
                        }
                    }
                    else
                        if (mapeo.RowCount >= 1)
                        {
                            ErrorMessages.Add(new ErrorMessage("La cuenta corporativa ya está asignada a la cuenta local: " + mapeo.Codigopuc));
                            _view.ShowValidationErrorsMapeo(ErrorMessages);
                        }
                }
                ok = (ErrorMessages.Count == 0);
            }

            ErrorMessages.Clear();
            return ok;
        }

        /// <summary>
        /// Guarda las cuentas locales puc
        /// </summary>
        /// <returns></returns>
        public bool Save()
        {
            if (!_view.IsDirty)
                return true; //-- no changes

            if (!this.ValidarEnBd())
                return false;

            if (!_service.Save(_model))
            {
                _view.ShowValidationErrors(_service.ErrorMessages);
                return false;
            }

            return true;
        }
        /// <summary>
        /// Guarda el mapeo de una cuenta local puc asociada a una cuenta corporativa
        /// </summary>
        /// <returns></returns>
        public bool SaveMapeo()
        {
            if (!_view.IsDirty)
                return true; //-- no changes

            if (!this.ValidaMapeoEnBd())
                return false;

            if (!_service.Mapeo.Save(_model.MapeoCuentas[0]))
            {
                _view.ShowValidationErrorsMapeo(_service.Mapeo.ErrorMessages);
                return false;
            }

            return true;
        }

        public bool Delete(string id)
        {
            ErrorMessageCollection e = new ErrorMessageCollection();
            e.Add(new ErrorMessage("Primero debe eliminar las cuentas corporativas asociadas a la cuenta local."));
            tii_mapeo_puc detalle = _service.Mapeo.getCuentasCorporaMapeadasA(id);
            if (detalle.DefaultView.Count > 0)
                _view.ShowValidationErrors(e);
            else
                if (!id.Equals(string.Empty) && _view.ConfirmDelete())
                {
                    _service.Delete(id);
                    return true;
                }

            return false;
        }
        public bool DeleteMapeo(string cuentaGp, string cuentaPuc)
        {
            if (!cuentaGp.Equals(string.Empty) && !cuentaPuc.Equals(string.Empty) && _view.ConfirmDelete())
            {
                _service.Mapeo.Delete(cuentaGp, cuentaPuc);
                if (_service.Mapeo.ErrorMessages.Count >0 )
                    _view.ShowMessage(_service.Mapeo.ErrorMessages.ToString());
                return true;
            }

            return false;
        }

        public bool getAll()
        {
            _view.arbolPlanCuentas = _service.getUpToLevel(9);
            return true;
        }
        public bool getPrimero()
        {
            if (_service.getPrimera())
            {
                _view.CuentaPucActual = _service.id;
                _view.CuentaPucActualDesc = _service.descripcion;
                return true;
            }
            else
                return false;
        }
        public bool getUltima()
        {
            if (_service.getUltima())
            {
                _view.CuentaPucActual = _service.id;
                _view.CuentaPucActualDesc = _service.descripcion;
                return true;
            }
            else
                return false;
        }
        public bool getSiguiente()
        {
            if (_service.getSiguiente(_view.CuentaPucActual))
            {
                _view.CuentaPucActual = _service.id;
                _view.CuentaPucActualDesc = _service.descripcion;
                return true;
            }
            else
                return false;
        }
        public bool getAnterior()
        {
            if (_service.getAnterior(_view.CuentaPucActual))
            {
                _view.CuentaPucActual = _service.id;
                _view.CuentaPucActualDesc = _service.descripcion;
                return true;
            }
            else
                return false;
        }

        public bool ActivarMapeo()
        {
            if (!_service.activaMapeo())
            {
                _view.ShowMessage(_service.ErrorMessages.ToString());
                return false;
            }

            return true;
        }

#endregion
    }
}
