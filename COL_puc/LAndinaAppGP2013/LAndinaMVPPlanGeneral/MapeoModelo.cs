using System;
using System.Collections.Generic;
using System.Text;
using Comun;

namespace MVP.gpCustom
{
    /// <summary>
    /// Modelo del mapeo de cuentas corporativas GP a cuentas locales PUC
    /// </summary>
    public class MapeoModelo: IMapeo, IValidatable
    {
        private string _mapeoCuentaGp;
        private string _mapeoCuentaPuc;
        private Parametros _parametros;
        private ErrorMessageCollection _errorMessages;

        public MapeoModelo()
        {
            _errorMessages = new ErrorMessageCollection();

        }
        public MapeoModelo(string cuentaGp, string cuentaPuc)
        {
            _errorMessages = new ErrorMessageCollection();
            _mapeoCuentaGp = cuentaGp;
            _mapeoCuentaPuc = cuentaPuc;
        }

        ////////////////////////////////////////////////////////////////
        #region ***** PROPIEDADES
        public ErrorMessageCollection ErrorMessages
        {
            get { return _errorMessages; }
        }
        public string MapeoCuentaGp
        {
            get { return _mapeoCuentaGp; }
            set
            {
                _mapeoCuentaGp = Formatea( value);
            }
        }
        public string MapeoCuentaPuc 
        {
            get { return _mapeoCuentaPuc; }
            set
            {
                _mapeoCuentaPuc = value;
            }
        }
        public Parametros parametros
        {
            get { return _parametros; }
            set { _parametros = value; }
        }
        #endregion

        ////////////////////////////////////////////////////////////////
        #region ***** METODOS
        /// <summary>
        /// Formatea la cuenta gp. El código A indica un alfanumérico. 
        /// </summary>
        /// <returns></returns>
        public string Formatea(string codigoSinFormato)
        { 
            try
            {
                string cuenta = string.Empty;
                int lenFormato = _parametros.formatoCuentaGP.Trim().Length;

                for (int i = 0; i < lenFormato; i++)
                {
                    if (i < codigoSinFormato.Length && _parametros.formatoCuentaGP[i].Equals('A'))
                        cuenta += codigoSinFormato[i].ToString();
                    else
                        cuenta += _parametros.formatoCuentaGP[i].ToString();
                }
                return cuenta;
            }
            catch
            {
                return string.Empty;
            }
        }

        /// <summary>
        /// Valida la asociación de la cuenta corporativa con la cuenta local puc
        /// </summary>
        /// <returns></returns>
        public bool Validate()
        {
            if (MapeoCuentaPuc.Trim().Length < Convert.ToInt16(parametros.nivelMinAsignacion))
            {
                _errorMessages.Add(new ErrorMessage("La cuenta corporativa debe asignarse a una cuenta local de nivel mayor o igua a: " + parametros.nivelMinAsignacion));
            }

            //if (MapeoCuentaGp.Trim().Length != 5)
            //{
            //    _errorMessages.Add(new ErrorMessage("La cuenta debe tener 5 dígitos."));
            //}

            if (String.IsNullOrEmpty(MapeoCuentaGp))
            {
                _errorMessages.Add(new ErrorMessage("La cuenta corporativa no puede estar vacía."));
            }

            return _errorMessages.Count == 0; //-- no error
        }
        public bool Validate(int i)
        {

            return _errorMessages.Count == 0; //-- no error
        }
        #endregion
    }
}
