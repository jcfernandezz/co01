using System;
using System.Collections.Generic;
using System.Text;
using Comun;

namespace MVP.gpCustom
{
    public interface IMapeoService
    {
        ErrorMessageCollection ErrorMessages { get;}
        short pstngtyp {get;}
        Parametros parametros { set;}

        bool Save(IMapeo mapeo);
        void Delete(string cuentaGp, string cuentaPuc);
        bool get(string sPuc, string sGp);
        tii_mapeo_puc getCuentasCorporaMapeadasA(string sCuentaLocal);
        tii_mapeo_puc getCuentasLocalesMapeadasA(string sCuentaCorporativa);
        bool getPrimeraCuentaDeSegmentoGp(string id);
        bool getCuentaGpByActnumst(string id);
        bool getCuentaGpByActnumstLike(string id);
    }
}
