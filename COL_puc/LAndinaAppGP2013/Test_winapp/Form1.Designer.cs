namespace gp.localizacionAndina
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.button1 = new System.Windows.Forms.Button();
            this.txtbIdPlanilla = new System.Windows.Forms.TextBox();
            this.txtbDescriPlanilla = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.chlbxPagosAsignados = new System.Windows.Forms.CheckedListBox();
            this.chlBoxDeduccionesAsig = new System.Windows.Forms.CheckedListBox();
            this.chlBoxBeneficiosAsig = new System.Windows.Forms.CheckedListBox();
            this.chlBoxImpuestoAsig = new System.Windows.Forms.CheckedListBox();
            this.buttonPrimero = new System.Windows.Forms.Button();
            this.buttonAnterior = new System.Windows.Forms.Button();
            this.buttonSiguiente = new System.Windows.Forms.Button();
            this.buttonUltimo = new System.Windows.Forms.Button();
            this.btnLimpiar = new System.Windows.Forms.Button();
            this.btnEliminar = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.dGridVPlanGeneral = new System.Windows.Forms.DataGridView();
            this.dGridVMapeo = new System.Windows.Forms.DataGridView();
            this.dataSet1 = new System.Data.DataSet();
            this.button3 = new System.Windows.Forms.Button();
            this.btnActualizar = new System.Windows.Forms.Button();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dGridVPlanGeneral)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dGridVMapeo)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataSet1)).BeginInit();
            this.SuspendLayout();
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(28, 7);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(96, 21);
            this.button1.TabIndex = 0;
            this.button1.Text = "Save";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.btnGuardar_Click);
            // 
            // txtbIdPlanilla
            // 
            this.txtbIdPlanilla.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.txtbIdPlanilla.Location = new System.Drawing.Point(80, 34);
            this.txtbIdPlanilla.MaxLength = 15;
            this.txtbIdPlanilla.Name = "txtbIdPlanilla";
            this.txtbIdPlanilla.Size = new System.Drawing.Size(163, 20);
            this.txtbIdPlanilla.TabIndex = 1;
            this.txtbIdPlanilla.TextChanged += new System.EventHandler(this.txtbIdPlanilla_TextChanged);
            this.txtbIdPlanilla.Leave += new System.EventHandler(this.txtbIdPlanilla_Leave);
            // 
            // txtbDescriPlanilla
            // 
            this.txtbDescriPlanilla.Location = new System.Drawing.Point(314, 34);
            this.txtbDescriPlanilla.Name = "txtbDescriPlanilla";
            this.txtbDescriPlanilla.Size = new System.Drawing.Size(211, 20);
            this.txtbDescriPlanilla.TabIndex = 2;
            this.txtbDescriPlanilla.TextChanged += new System.EventHandler(this.txtbDescriPlanilla_TextChanged);
            this.txtbDescriPlanilla.Leave += new System.EventHandler(this.txtbDescriPlanilla_Leave);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(25, 36);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(18, 13);
            this.label1.TabIndex = 3;
            this.label1.Text = "ID";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(272, 41);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(36, 13);
            this.label2.TabIndex = 4;
            this.label2.Text = "DESC";
            // 
            // chlbxPagosAsignados
            // 
            this.chlbxPagosAsignados.FormattingEnabled = true;
            this.chlbxPagosAsignados.Location = new System.Drawing.Point(417, 357);
            this.chlbxPagosAsignados.Name = "chlbxPagosAsignados";
            this.chlbxPagosAsignados.Size = new System.Drawing.Size(51, 34);
            this.chlbxPagosAsignados.TabIndex = 5;
            // 
            // chlBoxDeduccionesAsig
            // 
            this.chlBoxDeduccionesAsig.FormattingEnabled = true;
            this.chlBoxDeduccionesAsig.Location = new System.Drawing.Point(474, 350);
            this.chlBoxDeduccionesAsig.Name = "chlBoxDeduccionesAsig";
            this.chlBoxDeduccionesAsig.Size = new System.Drawing.Size(64, 34);
            this.chlBoxDeduccionesAsig.TabIndex = 6;
            // 
            // chlBoxBeneficiosAsig
            // 
            this.chlBoxBeneficiosAsig.FormattingEnabled = true;
            this.chlBoxBeneficiosAsig.Location = new System.Drawing.Point(544, 357);
            this.chlBoxBeneficiosAsig.Name = "chlBoxBeneficiosAsig";
            this.chlBoxBeneficiosAsig.Size = new System.Drawing.Size(59, 34);
            this.chlBoxBeneficiosAsig.TabIndex = 7;
            // 
            // chlBoxImpuestoAsig
            // 
            this.chlBoxImpuestoAsig.FormattingEnabled = true;
            this.chlBoxImpuestoAsig.Location = new System.Drawing.Point(609, 350);
            this.chlBoxImpuestoAsig.Name = "chlBoxImpuestoAsig";
            this.chlBoxImpuestoAsig.Size = new System.Drawing.Size(59, 34);
            this.chlBoxImpuestoAsig.TabIndex = 8;
            // 
            // buttonPrimero
            // 
            this.buttonPrimero.Location = new System.Drawing.Point(13, 358);
            this.buttonPrimero.Name = "buttonPrimero";
            this.buttonPrimero.Size = new System.Drawing.Size(75, 23);
            this.buttonPrimero.TabIndex = 9;
            this.buttonPrimero.Text = "button2";
            this.buttonPrimero.UseVisualStyleBackColor = true;
            this.buttonPrimero.Click += new System.EventHandler(this.buttonPrimero_Click);
            // 
            // buttonAnterior
            // 
            this.buttonAnterior.Location = new System.Drawing.Point(95, 357);
            this.buttonAnterior.Name = "buttonAnterior";
            this.buttonAnterior.Size = new System.Drawing.Size(75, 23);
            this.buttonAnterior.TabIndex = 10;
            this.buttonAnterior.Text = "button3";
            this.buttonAnterior.UseVisualStyleBackColor = true;
            this.buttonAnterior.Click += new System.EventHandler(this.buttonAnterior_Click);
            // 
            // buttonSiguiente
            // 
            this.buttonSiguiente.Location = new System.Drawing.Point(176, 357);
            this.buttonSiguiente.Name = "buttonSiguiente";
            this.buttonSiguiente.Size = new System.Drawing.Size(75, 23);
            this.buttonSiguiente.TabIndex = 11;
            this.buttonSiguiente.Text = "button4";
            this.buttonSiguiente.UseVisualStyleBackColor = true;
            this.buttonSiguiente.Click += new System.EventHandler(this.buttonSiguiente_Click);
            // 
            // buttonUltimo
            // 
            this.buttonUltimo.Location = new System.Drawing.Point(257, 358);
            this.buttonUltimo.Name = "buttonUltimo";
            this.buttonUltimo.Size = new System.Drawing.Size(75, 23);
            this.buttonUltimo.TabIndex = 12;
            this.buttonUltimo.Text = "button5";
            this.buttonUltimo.UseVisualStyleBackColor = true;
            this.buttonUltimo.Click += new System.EventHandler(this.buttonUltimo_Click);
            // 
            // btnLimpiar
            // 
            this.btnLimpiar.Location = new System.Drawing.Point(139, 7);
            this.btnLimpiar.Name = "btnLimpiar";
            this.btnLimpiar.Size = new System.Drawing.Size(103, 20);
            this.btnLimpiar.TabIndex = 13;
            this.btnLimpiar.Text = "Limpiar";
            this.btnLimpiar.UseVisualStyleBackColor = true;
            this.btnLimpiar.Click += new System.EventHandler(this.btnLimpiar_Click_1);
            // 
            // btnEliminar
            // 
            this.btnEliminar.Location = new System.Drawing.Point(257, 7);
            this.btnEliminar.Name = "btnEliminar";
            this.btnEliminar.Size = new System.Drawing.Size(103, 20);
            this.btnEliminar.TabIndex = 14;
            this.btnEliminar.Text = "Eliminar";
            this.btnEliminar.UseVisualStyleBackColor = true;
            this.btnEliminar.Click += new System.EventHandler(this.btnEliminar_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(253, 35);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(22, 18);
            this.button2.TabIndex = 15;
            this.button2.Text = "button2";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // splitContainer1
            // 
            this.splitContainer1.Location = new System.Drawing.Point(12, 78);
            this.splitContainer1.Name = "splitContainer1";
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.dGridVPlanGeneral);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.dGridVMapeo);
            this.splitContainer1.Size = new System.Drawing.Size(717, 237);
            this.splitContainer1.SplitterDistance = 485;
            this.splitContainer1.TabIndex = 16;
            // 
            // dGridVPlanGeneral
            // 
            this.dGridVPlanGeneral.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dGridVPlanGeneral.Location = new System.Drawing.Point(24, 22);
            this.dGridVPlanGeneral.Name = "dGridVPlanGeneral";
            this.dGridVPlanGeneral.Size = new System.Drawing.Size(431, 156);
            this.dGridVPlanGeneral.TabIndex = 1;
            this.dGridVPlanGeneral.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.dGridVPlanGeneral_CellEndEdit);
            this.dGridVPlanGeneral.CellEnter += new System.Windows.Forms.DataGridViewCellEventHandler(this.dGridVPlanGeneral_CellEnter);
            this.dGridVPlanGeneral.CellValidated += new System.Windows.Forms.DataGridViewCellEventHandler(this.dGridVPlanGeneral_CellValidated);
            this.dGridVPlanGeneral.CellValidating += new System.Windows.Forms.DataGridViewCellValidatingEventHandler(this.dGridVPlanGeneral_CellValidating);
            this.dGridVPlanGeneral.RowEnter += new System.Windows.Forms.DataGridViewCellEventHandler(this.dGridVPlanGeneral_RowEnter);
            this.dGridVPlanGeneral.RowValidating += new System.Windows.Forms.DataGridViewCellCancelEventHandler(this.dGridVPlanGeneral_RowValidating);
            // 
            // dGridVMapeo
            // 
            this.dGridVMapeo.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dGridVMapeo.Location = new System.Drawing.Point(20, 14);
            this.dGridVMapeo.Name = "dGridVMapeo";
            this.dGridVMapeo.Size = new System.Drawing.Size(205, 200);
            this.dGridVMapeo.TabIndex = 0;
            this.dGridVMapeo.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.dGridVMapeo_CellEndEdit);
            this.dGridVMapeo.RowEnter += new System.Windows.Forms.DataGridViewCellEventHandler(this.dGridVMapeo_RowEnter);
            // 
            // dataSet1
            // 
            this.dataSet1.DataSetName = "NewDataSet";
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(609, 12);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(96, 21);
            this.button3.TabIndex = 17;
            this.button3.Text = "Close";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // btnActualizar
            // 
            this.btnActualizar.Location = new System.Drawing.Point(392, 7);
            this.btnActualizar.Name = "btnActualizar";
            this.btnActualizar.Size = new System.Drawing.Size(103, 20);
            this.btnActualizar.TabIndex = 18;
            this.btnActualizar.Text = "Actualizar";
            this.btnActualizar.UseVisualStyleBackColor = true;
            this.btnActualizar.Click += new System.EventHandler(this.btnActualizar_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(742, 429);
            this.Controls.Add(this.btnActualizar);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.splitContainer1);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.btnEliminar);
            this.Controls.Add(this.btnLimpiar);
            this.Controls.Add(this.buttonUltimo);
            this.Controls.Add(this.buttonSiguiente);
            this.Controls.Add(this.buttonAnterior);
            this.Controls.Add(this.buttonPrimero);
            this.Controls.Add(this.chlBoxImpuestoAsig);
            this.Controls.Add(this.chlBoxBeneficiosAsig);
            this.Controls.Add(this.chlBoxDeduccionesAsig);
            this.Controls.Add(this.chlbxPagosAsignados);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtbDescriPlanilla);
            this.Controls.Add(this.txtbIdPlanilla);
            this.Controls.Add(this.button1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_FormClosing);
            this.Load += new System.EventHandler(this.Form1_Load);
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel2.ResumeLayout(false);
            this.splitContainer1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dGridVPlanGeneral)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dGridVMapeo)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataSet1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.TextBox txtbIdPlanilla;
        private System.Windows.Forms.TextBox txtbDescriPlanilla;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.CheckedListBox chlbxPagosAsignados;
        private System.Windows.Forms.CheckedListBox chlBoxDeduccionesAsig;
        private System.Windows.Forms.CheckedListBox chlBoxBeneficiosAsig;
        private System.Windows.Forms.CheckedListBox chlBoxImpuestoAsig;
        private System.Windows.Forms.Button buttonPrimero;
        private System.Windows.Forms.Button buttonAnterior;
        private System.Windows.Forms.Button buttonSiguiente;
        private System.Windows.Forms.Button buttonUltimo;
        private System.Windows.Forms.Button btnLimpiar;
        private System.Windows.Forms.Button btnEliminar;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.SplitContainer splitContainer1;
        private System.Windows.Forms.DataGridView dGridVMapeo;
        private System.Data.DataSet dataSet1;
        private System.Windows.Forms.DataGridView dGridVPlanGeneral;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.Button btnActualizar;
    }
}

