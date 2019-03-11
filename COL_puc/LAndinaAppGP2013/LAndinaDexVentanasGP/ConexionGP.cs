using System;
using System.Collections.Generic;
using System.Text;
using System.Security.Principal;
using System.Windows.Forms;

using Comun;

namespace gp.localizacionAndina
{
    class ConexionDB
    {
        private string _ServerAddress = "";
        private bool _IntegratedSecurity = false;

        private string _Compannia = "";
        private string _Usuario = "";
        private string _Password = "";
        private string _Intercompany = "";
        private string _SqlDSN = "";

        public ConexionAFuenteDatos DBDatos = null;
        public string sMensaje = "";
        public ConexionDB ()
        {
            try
            {
                _Compannia = Microsoft.Dexterity.Applications.Dynamics.Globals.CompanyName;
                _Usuario = Microsoft.Dexterity.Applications.Dynamics.Globals.UserId.Value;
                _Password = Microsoft.Dexterity.Applications.Dynamics.Globals.SqlPassword.Value;
                _Intercompany = Microsoft.Dexterity.Applications.Dynamics.Globals.IntercompanyId.Value;
                _SqlDSN = Microsoft.Dexterity.Applications.Dynamics.Globals.SqlDataSourceName;
            }
            catch
            {
                MessageBox.Show("No está usando GP. La conexión será a la compañía predeterminada.");
            }

            Parametros config = new Parametros();
            _ServerAddress = config.servidor;
            sMensaje = config.ultimoMensaje;

            //Si la app no viene de GP usar la compañía configurada en el archivo parámetros
            if (_Usuario.Equals(string.Empty))
                _Intercompany = config.companniaDefault;

            _IntegratedSecurity = config.seguridadIntegrada;
            if (_IntegratedSecurity)                                    //Usar seguridad integrada
                _Usuario = WindowsIdentity.GetCurrent().Name.Trim();
            else
            {                                                           //Usar un usuario sql con privilegios
                _Usuario = config.usuarioSql;
                _Password = config.passwordSql;
            }

            DBDatos = new ConexionAFuenteDatos(_Compannia, _Usuario, _Password, _Intercompany, _ServerAddress, _IntegratedSecurity, _SqlDSN);
        }

        public ConexionDB(ConexionAFuenteDatos fuente)
        {
            DBDatos = fuente;
        }

    }
 
}
