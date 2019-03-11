using System;
using System.Collections.Generic;
using System.Collections;
using System.Text;
using Comun;

namespace MVP.gpCustom
{
    public interface IPlanGeneralView
    {
        nsaPUC_GL10000 arbolPlanCuentas { get; set;}
        tii_mapeo_puc MapeoCuentas { get; set;}
        List<IPlanGeneral> CuentasPuc { get; set;}
        int ColumnaActual { get; set;}
        short CuentaPucActualNivel { get; set;}
        string CuentaPucActual { get; set;}
        string CuentaPucActualDesc { get; set;}
        string CuentaPucActualNivelDesc { get; set;}
        MapeoModelo MapeoCuentaActual { get; set;}

        //////////////////////////////////////////////////////////////////////
        bool IsDirty { get;}

        bool ConfirmClose();

        void CloseForm();

        bool ConfirmDelete();

        void ShowMessage(string message);
        void ShowValidationErrors(ErrorMessageCollection errorMessages);
        void ShowValidationErrorsMapeo(ErrorMessageCollection errorMessages);

    }
}
