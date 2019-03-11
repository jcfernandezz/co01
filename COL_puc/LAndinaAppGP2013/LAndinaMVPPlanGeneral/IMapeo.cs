using System;
using System.Collections.Generic;
using System.Text;
using Comun;

namespace MVP.gpCustom
{
    public interface IMapeo
    {
        string MapeoCuentaGp { get; set;}
        string MapeoCuentaPuc { get; set;}
        Parametros parametros { get; set;}
    }
}
