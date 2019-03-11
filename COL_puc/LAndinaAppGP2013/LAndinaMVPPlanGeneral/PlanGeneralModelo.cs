using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

using Comun;

namespace MVP.gpCustom
{
    public class PlanGeneralModelo : IPlanGeneral, INotifyPropertyChanged, IValidatable
    {
        private short _nivel=0;
        private string _cuenta;
        private string _descripcion;
        private string _descripcionNivel;
        private Parametros _parametros;
        private List<MapeoModelo> _mapeoCuentagp;
        private tii_mapeo_puc _mapeo;
        private ErrorMessageCollection _errorMessages;

        public PlanGeneralModelo()
        {
            _errorMessages = new ErrorMessageCollection();
            _mapeoCuentagp = new List<MapeoModelo>();
        }

        /////////////////////////////////////////////////////////////////
        #region ***** PROPIEDADES
        public short Nivel
        {
            get { return _nivel; }
            set
            {
                _nivel = value;
                OnPropertyChanged("Nivel");
            }
        }
        public string Cuenta
        {
            get { return _cuenta; }
            set
            {
                _cuenta = value;
                OnPropertyChanged("Cuenta");
            }
        }
        public string Descripcion
        {
            get { return _descripcion; }
            set
            {
                _descripcion = value;
                OnPropertyChanged("Descripcion");
            }
        }
        public string DescripcionNivel
        {
            get 
            {
                string desNivel = "";
                for (int i=0; i< _parametros.listaEstructuraPlanLocal.Count; i++)
                {
                    if (Nivel.ToString().Equals(_parametros.listaEstructuraPlanLocal[i].nivel))
                        desNivel = _parametros.listaEstructuraPlanLocal[i].descripcion;
                }

                return desNivel; 
            }
            set
            {
                _descripcionNivel = value;
                OnPropertyChanged("DescripcionNivel");
            }
        }
        public Parametros parametros
        {
            get { return _parametros; }
            set { _parametros = value; }
        }
        public tii_mapeo_puc Mapeo
        {
            get { return _mapeo; }
            set 
            {
                _mapeo = value;
                OnPropertyChanged("mapeo");
            }
        }
        public List<MapeoModelo> MapeoCuentas
        {
            get { return _mapeoCuentagp; }
            set
            {
                _mapeoCuentagp = value;
                OnPropertyChanged("MapeoCuentas");
            }
        }
        public ErrorMessageCollection ErrorMessages
        {
            get { return _errorMessages; }
        }
        #endregion

        /////////////////////////////////////////////////////////////////
        #region ***** METODOS
        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged(string propertyName)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
            }
        }

        public int getUltimoNivel()
        {
            int posicion = _parametros.listaEstructuraPlanLocal.Count -1;
            try
            {
                return (Convert.ToInt16( _parametros.listaEstructuraPlanLocal[posicion].nivel));
            }
            catch (Exception ex)
            {
                _errorMessages.Add(new ErrorMessage("Error al obtener último nivel de la estructura del plan de cuentas. "+ ex.Message));
                return 0;
            }

        }
        /// <summary>
        /// Validar el formato de la cuenta local (PUC)
        /// </summary>
        public bool Validate()
        {
            int max = getUltimoNivel();
            if (Nivel < 1 || Nivel > max)
            {
                _errorMessages.Add(new ErrorMessage("El nivel debe estar en el rango de 1 a " + max.ToString()));
            }

            if (String.IsNullOrEmpty(Cuenta))
            {
                _errorMessages.Add(new ErrorMessage("La cuenta no puede estar vacía."));
            }

            if (Cuenta.Trim().Length != Nivel)
            {
                _errorMessages.Add(new ErrorMessage("El número de dígitos de la cuenta debe ser igual al nivel."));
            }

            if (String.IsNullOrEmpty(Descripcion))
            {
                _errorMessages.Add(new ErrorMessage("La descripción de cuenta no puede estar vacía."));
            }

            return _errorMessages.Count == 0; //-- no error
        }
        public bool Validate(int campo)
        {
            return _errorMessages.Count == 0; //-- no error
        }
        #endregion
    }
}
