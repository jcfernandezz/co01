using System;
using System.Collections.Generic;
using System.Text;

namespace Comun
{
    public struct TipoComponente
        {
            private short _codTipoComponente;
            private string _desTipoComponente;

            public TipoComponente(short codTipoComponente, string desTipoComponente)
            {
                this._codTipoComponente = codTipoComponente;
                this._desTipoComponente = desTipoComponente;
            }

            public short CodTipoComponente { get { return _codTipoComponente; } }
            public string DesTipoComponente { get { return _desTipoComponente; } }
        }

    //public struct Componente
    //{
    //    private int _tipoComponente;
    //    private string _idComponente;

    //    public Componente(int tipoComponente, string idComponente)
    //    {
    //        this._tipoComponente = tipoComponente;
    //        this._idComponente = idComponente;
    //    }

    //    public int tipoComponente { get { return _tipoComponente; } }
    //    public string idComponente { get { return _idComponente; } }
    //}

    public class ParamIni
    {
        // Define the Array of States for the DropDown List
        public static TipoComponente[] TipoComp = new TipoComponente[] {
               new TipoComponente(0,"Ninguno")
              ,new TipoComponente(1,"Pagos")
              ,new TipoComponente(2,"Deducciones")
              ,new TipoComponente(3,"Beneficios")
              ,new TipoComponente(4,"Impuestos")
        };
    }

    
}
