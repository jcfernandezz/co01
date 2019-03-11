using System;
using System.Collections.Generic;
using System.Text;
using System.Security.Principal;
using Comun;

namespace gp.localizacionAndina
{
    class ConexionDB
    {
        private string _Compannia = "";
        private string _Usuario = "";
        private string _Password = "";
        private string _Intercompany = "";
        private string _SqlDSN = "";
        private string _ServerAddress = "";
        private bool _IntegratedSecurity = false;

        //private string _Compannia = Microsoft.Dexterity.Applications.Dynamics.Globals.CompanyName;
        //private string _Usuario = Microsoft.Dexterity.Applications.Dynamics.Globals.UserId.Value;
        //private string _Password = Microsoft.Dexterity.Applications.Dynamics.Globals.SqlPassword.Value;
        //private string _Intercompany = Microsoft.Dexterity.Applications.Dynamics.Globals.IntercompanyId.Value;
        //private string _SqlDSN = Microsoft.Dexterity.Applications.Dynamics.Globals.SqlDataSourceName;

        public ConexionAFuenteDatos DBDatos = null;
        public string sMensaje = "";
        public ConexionDB ()
        {//I
            Parametros config = new Parametros();
            _ServerAddress = config.servidor;
            sMensaje = config.ultimoMensaje;

            //Si la app no viene de GP usar seguridad integrada o un usuario sql (configurado en el archivo de inicio)
            if (_Usuario.Equals(string.Empty))
            {
                _IntegratedSecurity = config.seguridadIntegrada;
                _Intercompany = config.companniaDefault;

                if (_IntegratedSecurity)            //Usar seguridad integrada
                    _Usuario = WindowsIdentity.GetCurrent().Name.Trim();
                else
                {                                   //Usar un usuario sql con privilegios
                    _Usuario = config.usuarioSql;
                    _Password = config.passwordSql;
                }
            }

            DBDatos = new ConexionAFuenteDatos(_Compannia, _Usuario, _Password, _Intercompany, _ServerAddress, _IntegratedSecurity, _SqlDSN);
        }
    }
}
