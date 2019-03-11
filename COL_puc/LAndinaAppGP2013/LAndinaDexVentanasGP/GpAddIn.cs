using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;

using Microsoft.Dexterity.Bridge;
using Microsoft.Dexterity.Applications;
using Microsoft.Dexterity.Applications.DynamicsDictionary;
    
namespace gp.localizacionAndina
{
    public class GPAddIn : IDexterityAddIn
    {
        // Application Name
        const string sAPPNAME = "Plan de Cuentas General";
        // Keep a reference to WinForms.
        static GPFrmPlanGeneralyMapeo GPFrmPlanLocalyMapeo;

        // Dictionary ID Constants
        const short shDYNAMICS = 0;

        // Create a reference to the GlAccountMaintenanceForm
        static GlAccountMaintenanceForm GlAccountMaintenanceForm = Dynamics.Forms.GlAccountMaintenance;

        // Create a reference to the GlAccountMaintenanceWindow 
        static GlAccountMaintenanceForm.GlAccountMaintenanceWindow GlAccountMaintenanceWindow = GlAccountMaintenanceForm.GlAccountMaintenance;
        
        // IDexterityAddIn interface
        public void Initialize()
        {
            // Add the menu item to open the WinForm
            GlAccountMaintenanceForm.AddMenuHandler(AbrirFrmGeneraPlanilla, sAPPNAME, "P");

        }

         // Method to open the Genera Planilla WinForm
        static void AbrirFrmGeneraPlanilla(object sender, EventArgs e)
        {
            if (GPFrmPlanLocalyMapeo == null)
            {
                try
                {
                    GPFrmPlanLocalyMapeo = new GPFrmPlanGeneralyMapeo();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
            else
            {
                if (GPFrmPlanLocalyMapeo.Created == false)
                {
                    GPFrmPlanLocalyMapeo = new GPFrmPlanGeneralyMapeo();
                }
            }

            // Always show and activate the WinForm
            GPFrmPlanLocalyMapeo.Show();
            GPFrmPlanLocalyMapeo.Activate();
        }

    }
}
