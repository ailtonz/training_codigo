namespace CriarArquivoExcel
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
            this.txtArquivoExcel = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.btnCriarArquivoExcel = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // txtArquivoExcel
            // 
            this.txtArquivoExcel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtArquivoExcel.Location = new System.Drawing.Point(23, 49);
            this.txtArquivoExcel.Name = "txtArquivoExcel";
            this.txtArquivoExcel.Size = new System.Drawing.Size(437, 28);
            this.txtArquivoExcel.TabIndex = 0;
            this.txtArquivoExcel.Text = "c:\\dados\\Macoratti_Excel.xls";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(23, 26);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(225, 17);
            this.label1.TabIndex = 1;
            this.label1.Text = "Caminho e Nome do Arquivo Excel";
            // 
            // btnCriarArquivoExcel
            // 
            this.btnCriarArquivoExcel.Location = new System.Drawing.Point(23, 78);
            this.btnCriarArquivoExcel.Name = "btnCriarArquivoExcel";
            this.btnCriarArquivoExcel.Size = new System.Drawing.Size(189, 51);
            this.btnCriarArquivoExcel.TabIndex = 2;
            this.btnCriarArquivoExcel.Text = "Criar Arquivo Excel";
            this.btnCriarArquivoExcel.UseVisualStyleBackColor = true;
            this.btnCriarArquivoExcel.Click += new System.EventHandler(this.btnCriarArquivoExcel_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.ClientSize = new System.Drawing.Size(484, 191);
            this.Controls.Add(this.btnCriarArquivoExcel);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtArquivoExcel);
            this.Name = "Form1";
            this.Text = "Criar Arquivo Excel";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox txtArquivoExcel;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnCriarArquivoExcel;
    }
}

