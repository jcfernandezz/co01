using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

using Comun;

namespace MVP.gpCustom
{
    public interface IPlanGeneral
    {
        short Nivel { get; set;}
        string Cuenta {get; set;}
        string Descripcion { get; set;}
        string DescripcionNivel { get; set;}
        Parametros parametros { get; set;}
        tii_mapeo_puc Mapeo { get; set;}
        List<MapeoModelo> MapeoCuentas { get; set;}
    }
}
