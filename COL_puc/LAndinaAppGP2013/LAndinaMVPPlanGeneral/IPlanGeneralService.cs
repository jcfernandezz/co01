using System;
using System.Collections.Generic;
using System.Text;
using Comun;

namespace MVP.gpCustom
{
    public interface IPlanGeneralService
    {
        string id { get;}
        string descripcion { get;}
        IMapeoService Mapeo { get;}
        ErrorMessageCollection ErrorMessages { get;}

        bool IsExists(string id);
        bool Save(IPlanGeneral planilla);
        void Delete(string id);

        bool get(string idPlanilla);
        nsaPUC_GL10000 getUpToLevel(int sLevel);

        List<IPlanGeneral> getLookup();
        List<IPlanGeneral> getLookup(string Texto);
        bool getPrimera();
        bool getUltima();
        bool getSiguiente(string id);
        bool getAnterior(string id);
        bool activaMapeo();
    }
}
