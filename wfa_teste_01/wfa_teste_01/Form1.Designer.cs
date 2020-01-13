namespace wfa_teste_01
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
            this.lblSayThis = new System.Windows.Forms.Label();
            this.lblOfTimes = new System.Windows.Forms.Label();
            this.txtSayThis = new System.Windows.Forms.TextBox();
            this.numericUpDown1 = new System.Windows.Forms.NumericUpDown();
            this.btnSpeak = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDown1)).BeginInit();
            this.SuspendLayout();
            // 
            // lblSayThis
            // 
            this.lblSayThis.AutoSize = true;
            this.lblSayThis.Location = new System.Drawing.Point(35, 30);
            this.lblSayThis.Name = "lblSayThis";
            this.lblSayThis.Size = new System.Drawing.Size(54, 13);
            this.lblSayThis.TabIndex = 0;
            this.lblSayThis.Text = "Say This :";
            // 
            // lblOfTimes
            // 
            this.lblOfTimes.AutoSize = true;
            this.lblOfTimes.Location = new System.Drawing.Point(27, 55);
            this.lblOfTimes.Name = "lblOfTimes";
            this.lblOfTimes.Size = new System.Drawing.Size(59, 13);
            this.lblOfTimes.TabIndex = 1;
            this.lblOfTimes.Text = "# of times :";
            // 
            // txtSayThis
            // 
            this.txtSayThis.Location = new System.Drawing.Point(92, 27);
            this.txtSayThis.Name = "txtSayThis";
            this.txtSayThis.Size = new System.Drawing.Size(338, 20);
            this.txtSayThis.TabIndex = 2;
            // 
            // numericUpDown1
            // 
            this.numericUpDown1.Location = new System.Drawing.Point(92, 53);
            this.numericUpDown1.Name = "numericUpDown1";
            this.numericUpDown1.Size = new System.Drawing.Size(120, 20);
            this.numericUpDown1.TabIndex = 3;
            // 
            // btnSpeak
            // 
            this.btnSpeak.Location = new System.Drawing.Point(280, 55);
            this.btnSpeak.Name = "btnSpeak";
            this.btnSpeak.Size = new System.Drawing.Size(150, 23);
            this.btnSpeak.TabIndex = 4;
            this.btnSpeak.Text = "Speak to me!";
            this.btnSpeak.UseVisualStyleBackColor = true;
            this.btnSpeak.Click += new System.EventHandler(this.btnSpeak_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(512, 95);
            this.Controls.Add(this.btnSpeak);
            this.Controls.Add(this.numericUpDown1);
            this.Controls.Add(this.txtSayThis);
            this.Controls.Add(this.lblOfTimes);
            this.Controls.Add(this.lblSayThis);
            this.Name = "Form1";
            this.Text = "Talker Tester";
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDown1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblSayThis;
        private System.Windows.Forms.Label lblOfTimes;
        private System.Windows.Forms.TextBox txtSayThis;
        private System.Windows.Forms.NumericUpDown numericUpDown1;
        private System.Windows.Forms.Button btnSpeak;
    }
}

