using System;
using System.Collections.Generic;
using System.Text;
using Comun;
using MyGeneration.dOOdads;

namespace MVP.gpCustom
{
    public class MapeoService : IMapeoService
    {
        private string _connStr;
        private ErrorMessageCollection _errorMessages;
        private string _descSegmento;
        private Parametros _parametros;
        public string _codigoPuc="";
        public short _pstngtyp = 0;

        public MapeoService(ConexionAFuenteDatos DatosConexion)
        {
            _connStr = DatosConexion.ConnStr;
            _errorMessages = new ErrorMessageCollection();
        }

        /////////////////////////////////////////////////////////////////
        #region ***** PROPIEDADES
        public ErrorMessageCollection ErrorMessages
        {
            get { return _errorMessages; }
        }

        public short pstngtyp
        {
            get { return _pstngtyp;}
        }

        public Parametros parametros
        {
            set { _parametros = value; }
        }
        #endregion
        /////////////////////////////////////////////////////////////////
        #region ***** METODOS
        public bool Save(IMapeo mapeo)
        {
            tii_mapeo_puc _mapeo = new tii_mapeo_puc(_connStr);
            try
            {
                if (!_mapeo.LoadByPrimaryKey(mapeo.MapeoCuentaGp, mapeo.MapeoCuentaPuc))
                {
                    _mapeo.AddNew();
                    _mapeo.Codigopuc = mapeo.MapeoCuentaPuc.Trim();
                    _mapeo.Cuentagp = mapeo.MapeoCuentaGp.Trim();
                    _mapeo.Procesado = "S";
                }
                _mapeo.Save();
            }
            catch (Exception eSave)
            {
                _errorMessages.Add(new ErrorMessage("Contacte al administrador. Error al acceder a la base de datos." + eSave.Message, "[MapeoService.Save] Cuenta GP: " + mapeo.MapeoCuentaGp));
            }
            return _errorMessages.Count == 0;
        }

        public void Delete(string cuentaGp, string cuentaPuc)
        {
            tii_mapeo_puc _mapeo = new tii_mapeo_puc(_connStr);
            try
            {
                if (_mapeo.LoadByPrimaryKey(cuentaGp, cuentaPuc))
                {
                    _mapeo.MarkAsDeleted();
                    _mapeo.Save();
                }
            }
            catch (Exception eDel)
            {
                _errorMessages.Add(new ErrorMessage("Contacte al administrador. Error al acceder a la base de datos." + eDel.Message, "[MapeoService.Delete] Cuenta: " + cuentaGp));
            }
        }

        public bool get(string sPuc, string sGp)
        {
            tii_mapeo_puc mapeo = new tii_mapeo_puc(_connStr);

            mapeo.Where.Codigopuc.Value = sPuc.Trim();
            mapeo.Where.Codigopuc.Operator = WhereParameter.Operand.Equal;
            mapeo.Where.Cuentagp.Value = sGp.Trim();
            mapeo.Where.Cuentagp.Operator = WhereParameter.Operand.Equal;

            try
            {
                if (mapeo.Query.Load())
                {
                    _codigoPuc = mapeo.Codigopuc;
                }
                else
                    return false;
            }
            catch (Exception ePla)
            {
                _errorMessages.Add(new ErrorMessage("Contacte al administrador. Error al obtener el mapeo de plan de cuentas local. " + ePla.Message, "[MapeoService.get()]"));
                return false;
            }
            return true;
        }
        public tii_mapeo_puc getCuentasCorporaMapeadasA(string sCuentaLocal)
        {
            tii_mapeo_puc mapeo = new tii_mapeo_puc(_connStr);

            if (sCuentaLocal.IndexOf(" ", 0) > 0)
                mapeo.Where.Codigopuc.Value = sCuentaLocal.Substring(0, sCuentaLocal.IndexOf(" ", 0));
            else
                mapeo.Where.Codigopuc.Value = sCuentaLocal.Trim();

            mapeo.Where.Codigopuc.Operator = WhereParameter.Operand.Equal;
            mapeo.Query.AddResultColumn(tii_mapeo_puc.ColumnNames.Cuentagp);
            mapeo.Query.AddResultColumn(tii_mapeo_puc.ColumnNames.Codigopuc);

            try
            {
                if (mapeo.Query.Load())
                {
                    mapeo.Rewind();
                }
                else
                    return mapeo;
            }
            catch (Exception ePla)
            {
                _errorMessages.Add(new ErrorMessage("Contacte al administrador. Error al obtener cuentas corporativas asociadas a una cuenta local. " + ePla.Message, "[getCuentasCorporaMapeadasA()]"));
                return null;
            }
            return mapeo;
        }
        public tii_mapeo_puc getCuentasLocalesMapeadasA(string sCuentaCorporativa)
        {
            tii_mapeo_puc mapeo = new tii_mapeo_puc(_connStr);

            mapeo.Where.Cuentagp.Value = sCuentaCorporativa.Trim();
            mapeo.Where.Cuentagp.Operator = WhereParameter.Operand.Equal;
            mapeo.Query.AddOrderBy(tii_mapeo_puc.ColumnNames.Codigopuc, WhereParameter.Dir.ASC);
            try
            {
                if (mapeo.Query.Load())
                {
                    mapeo.Rewind();
                }
                else
                    return mapeo;
            }
            catch (Exception ePla)
            {
                _errorMessages.Add(new ErrorMessage("Contacte al administrador. Error al obtener cuentas locales asociadas a una cuenta corporativa. " + ePla.Message, "[MapeoService.getCuentasLocalesMapeadasA()]"));
                return null;
            }
            return mapeo;
        }
        public bool getPrimeraCuentaDeSegmentoGp(string id)
        {
            GL00100 segmento = new GL00100(_connStr);
            if (_parametros.segmentoContable.Equals("1"))
            {
                segmento.Where.ACTNUMBR_1.Value = id;
                segmento.Where.ACTNUMBR_1.Operator = WhereParameter.Operand.Equal;
            }
            if (_parametros.segmentoContable.Equals("2"))
            {
                segmento.Where.ACTNUMBR_2.Value = id;
                segmento.Where.ACTNUMBR_2.Operator = WhereParameter.Operand.Equal;
            }
            if (_parametros.segmentoContable.Equals("3"))
            {
                segmento.Where.ACTNUMBR_3.Value = id;
                segmento.Where.ACTNUMBR_3.Operator = WhereParameter.Operand.Equal;
            }
            if (_parametros.segmentoContable.Equals("4"))
            {
                segmento.Where.ACTNUMBR_4.Value = id;
                segmento.Where.ACTNUMBR_4.Operator = WhereParameter.Operand.Equal;
            }
            if (_parametros.segmentoContable.Equals("5"))
            {
                segmento.Where.ACTNUMBR_5.Value = id;
                segmento.Where.ACTNUMBR_5.Operator = WhereParameter.Operand.Equal;
            }
            if (_parametros.segmentoContable.Equals("6"))
            {
                segmento.Where.ACTNUMBR_6.Value = id;
                segmento.Where.ACTNUMBR_6.Operator = WhereParameter.Operand.Equal;
            }

            try
            {
                if (segmento.Query.Load())
                {
                    segmento.Rewind();
                    _descSegmento = segmento.ACTDESCR;
                    _pstngtyp = segmento.PSTNGTYP;
                }
                else
                    return false;
            }
            catch (Exception ePla)
            {
                _errorMessages.Add(new ErrorMessage("Contacte al administrador. Error al obtener el segmento de cuenta. " + ePla.Message, "[MapeoService.getPrimeraCuentaDeSegmentoGp()]"));
                return false;
            }
            return true;
        }
        public bool getCuentaGpByActnumst(string id)
        {
            GL00100 cuenta = new GL00100(_connStr);
            GL00105 cuentaIdx = new GL00105(_connStr);
            cuentaIdx.Where.ACTNUMST.Value = id;
            cuentaIdx.Where.ACTNUMST.Operator = WhereParameter.Operand.Equal;

            try
            {
                if (cuentaIdx.Query.Load())
                {
                    cuenta.Where.ACTINDX.Value = cuentaIdx.ACTINDX;
                    cuenta.Where.ACTINDX.Operator = WhereParameter.Operand.Equal;
                    if (cuenta.Query.Load())
                    {
                        _descSegmento = cuenta.ACTDESCR;
                        _pstngtyp = cuenta.PSTNGTYP;
                    }
                }
                else
                    return false;
            }
            catch (Exception ePla)
            {
                _errorMessages.Add(new ErrorMessage("Contacte al administrador. Error al obtener la cuenta corporativa. " + ePla.Message, "[MapeoService.getCuentaGp()]"));
                return false;
            }
            return true;

        }
        public bool getCuentaGpByActnumstLike(string id)
        {
            GL00100 cuenta = new GL00100(_connStr);
            GL00105 cuentaIdx = new GL00105(_connStr);
            cuentaIdx.Where.ACTNUMST.Value = id;
            cuentaIdx.Where.ACTNUMST.Operator = WhereParameter.Operand.Like;

            try
            {
                if (cuentaIdx.Query.Load())
                {
                    cuenta.Where.ACTINDX.Value = cuentaIdx.ACTINDX;
                    cuenta.Where.ACTINDX.Operator = WhereParameter.Operand.Equal;
                    if (cuenta.Query.Load())
                    {
                        _descSegmento = cuenta.ACTDESCR;
                        _pstngtyp = cuenta.PSTNGTYP;
                    }
                }
                else
                    return false;
            }
            catch (Exception ePla)
            {
                _errorMessages.Add(new ErrorMessage("Contacte al administrador. Error al obtener la cuenta corporativa. " + ePla.Message, "[MapeoService.getCuentaGp()]"));
                return false;
            }
            return true;

        }
#endregion

    }
}
