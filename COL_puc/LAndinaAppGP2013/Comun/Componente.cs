using System;
using System.Collections.Generic;
using System.Text;

namespace Comun
{
    public class Componente
    {
        private short _tipoComponente;
        private string _idComponente;
        private bool _asignado;

        public Componente(short tipoComponente, string idComponente, bool asignado)
        {
            this._tipoComponente = tipoComponente;
            this._idComponente = idComponente;
            this._asignado = asignado;
        }

        public short tipoComponente
        {
            get { return _tipoComponente; }
            set { _tipoComponente = value; }
        }
        public string idComponente { 
            get { return _idComponente; } 
            set { _idComponente = value; } 
        }
        public bool asignado
        {
            get { return _asignado; }
            set { _asignado = value; }
        }
    }

}
