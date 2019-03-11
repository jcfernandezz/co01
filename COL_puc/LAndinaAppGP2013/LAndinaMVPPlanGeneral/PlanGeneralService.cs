using System;
using System.Collections.Generic;
using System.Text;
using Comun;
using MyGeneration.dOOdads;

namespace MVP.gpCustom
{
    public class PlanGeneralService : IPlanGeneralService
    {
        private string _sUsuario;
        private string _sPassword;
        private string _sIntercompany;
        private string _sSqlDSN;
        private string _sServerAddress;
        private string _connStr;

        private string _id = "";
        private string _descripcion = "";
        private ErrorMessageCollection _errorMessages;
        private IMapeoService _mapeo;

        public PlanGeneralService(ConexionAFuenteDatos DatosConexion)
        {
            _connStr = DatosConexion.ConnStr;
            _sUsuario = DatosConexion.Usuario;
            _sPassword = DatosConexion.Password;
            _sIntercompany = DatosConexion.Intercompany;
            _sSqlDSN = DatosConexion.SqlDsn;
            _sServerAddress = DatosConexion.ServerAddress;

            _mapeo = new MapeoService(DatosConexion);
            _errorMessages = new ErrorMessageCollection();
        }
        /////////////////////////////////////////////////////////////////
        #region ***** PROPIEDADES
        public ErrorMessageCollection ErrorMessages
        {
            get { return _errorMessages; }
        }
        public string id
        {
            get { return _id; }
        }
        public string descripcion
        {
            get{return _descripcion;}
        }
        public IMapeoService Mapeo
        {
            get { return _mapeo; }
        }
        #endregion

        /////////////////////////////////////////////////////////////////
        #region ***** METODOS
        public bool IsExists(string id)
        {             
            //-- [call to BLL or DAL goes here].

            //-- this is dummy data and logic
            if (id.Equals("0"))
                return false;

            return false;
        }

        public bool Save(IPlanGeneral PlanDeCuentas)
        {
            nsaPUC_GL10000 _planDeCuentas = new nsaPUC_GL10000(_connStr);
            try
            {
                if (_planDeCuentas.LoadByPrimaryKey(PlanDeCuentas.Cuenta))
                {
                    _planDeCuentas.Nsa_Descripcion_Codigo = PlanDeCuentas.Descripcion;
                }
                else
                {
                    _planDeCuentas.AddNew();
                    _planDeCuentas.Nsa_Codigo = PlanDeCuentas.Cuenta.Trim();
                    _planDeCuentas.Nsa_Descripcion_Codigo = PlanDeCuentas.Descripcion.Trim();
                    _planDeCuentas.Nsa_Nivel_Cuenta = PlanDeCuentas.Nivel.ToString();
                    _planDeCuentas.Nsa_Descripcion_Nivel = PlanDeCuentas.DescripcionNivel.Trim();
                }
                _planDeCuentas.Save();
            }
            catch (Exception eSave)
            {
                _errorMessages.Add(new ErrorMessage("Contacte al administrador. Error al acceder a la base de datos." + eSave.Message, "[PlanGeneralService.Save] Cuenta: " + PlanDeCuentas.Cuenta));
            }
            return _errorMessages.Count == 0;
        }

        public void Delete(string id)
        {
            nsaPUC_GL10000 _planDeCuentas = new nsaPUC_GL10000(_connStr);
            try
            {
                if (_planDeCuentas.LoadByPrimaryKey(id))
                {
                    _planDeCuentas.MarkAsDeleted();
                    _planDeCuentas.Save();
                }
            }
            catch (Exception eDel)
            {
                _errorMessages.Add(new ErrorMessage("Contacte al administrador. Error al acceder a la base de datos." + eDel.Message, "[PlanGeneralService.Delete] Cuenta: " + id));
            }

        }

        public bool get(string id) 
        {
            nsaPUC_GL10000 pcge = new nsaPUC_GL10000(_connStr);
            try
            {
                if (pcge.LoadByPrimaryKey(id))
                {
                    _id = pcge.Nsa_Codigo;
                }
                else
                    return false;
            }
            catch (Exception ePla)
            {
                _errorMessages.Add(new ErrorMessage("Contacte al administrador. Error al obtener el plan de cuentas. " + ePla.Message, "[PlanillaService.get()]"));
                return false;
            }
            return true;
        }

        public nsaPUC_GL10000 getUpToLevel(int sLevel)
        {
            nsaPUC_GL10000 pcge = new nsaPUC_GL10000(_connStr);

            pcge.Where.Nsa_Nivel_Cuenta.Value = sLevel.ToString();
            pcge.Where.Nsa_Nivel_Cuenta.Operator = WhereParameter.Operand.LessThanOrEqual;
            pcge.Query.AddOrderBy(nsaPUC_GL10000.ColumnNames.Nsa_Codigo, WhereParameter.Dir.ASC);
            pcge.Query.AddResultColumn(nsaPUC_GL10000.ColumnNames.Nsa_Nivel_Cuenta);
            pcge.Query.AddResultColumn(nsaPUC_GL10000.ColumnNames.Nsa_Codigo);
            pcge.Query.AddResultColumn(nsaPUC_GL10000.ColumnNames.Nsa_Descripcion_Codigo);
            try
            {
                if (pcge.Query.Load())
                {
                    pcge.Rewind();
                }
                //else
                //    return null;
            }
            catch (Exception ePla)
            {
                _errorMessages.Add(new ErrorMessage("Contacte al administrador. Error al obtener códigos del plan de cuentas. " + ePla.Message, "[PlanillaService.getUpToLevel()]"));
                return null;
            }
            return pcge;
        }

        public List<IPlanGeneral> getLookup()
        {
            return null;
        }
        public List<IPlanGeneral> getLookup(string Texto)
        {
            return null;
        }
        public bool getPrimera()
        {

            return false;
        }
        public bool getUltima()
        {

            return false;
        }
        public bool getSiguiente(string id)
        {
            return false;
        }
        public bool getAnterior(string id)
        {
              return false;
          }

        public bool activaMapeo()
        {
            tii_mapeo_puc _mapeo = new tii_mapeo_puc(_connStr);
            try
            {
                _mapeo.loadFromSqlNoExec("sp_LAndinaActivaMapeo");
            }
            catch (Exception eSave)
            {
                _errorMessages.Add(new ErrorMessage("Contacte al administrador. Error al activar el mapeo." + eSave.Message, "[PlanGeneralService.activaMapeo]"));
            }
            return _errorMessages.Count == 0;
            
        }
#endregion

      }
}
