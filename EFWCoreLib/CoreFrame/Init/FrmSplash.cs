using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace EFWCoreLib.CoreFrame.Init
{
	/// <summary>
	/// frmSplash ��ժҪ˵����
	/// </summary>
    public class FrmSplash : Form, ILoading
    {
        private Timer timer1;
        private NotifyIcon notifyIcon1;
        private ContextMenuStrip contextMenuStrip1;
        private ToolStripMenuItem ������ToolStripMenuItem;
        private ToolStripMenuItem �л��û�ToolStripMenuItem;
        private ToolStripMenuItem ��Ϣ���ToolStripMenuItem;
        private ToolStripSeparator toolStripSeparator1;
        private ToolStripMenuItem �˳�ToolStripMenuItem;
        private PictureBox pictureBox1;
        private IContainer components;


        public FrmSplash()
        {
            //
            // Windows ���������֧���������
            //
            InitializeComponent();

            //
            // TODO: �� InitializeComponent ���ú�����κι��캯������
            //
        }

        private EventHandler _handler;
        public FrmSplash(EventHandler handler)
        {
            InitializeComponent();
            _handler = handler;
        }

        /// <summary>
        /// ������������ʹ�õ���Դ��
        /// </summary>
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                if (components != null)
                {
                    components.Dispose();
                }
            }
            base.Dispose(disposing);
        }

        #region Windows ������������ɵĴ���
        /// <summary>
        /// �����֧������ķ��� - ��Ҫʹ�ô���༭���޸�
        /// �˷��������ݡ�
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FrmSplash));
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.notifyIcon1 = new System.Windows.Forms.NotifyIcon(this.components);
            this.contextMenuStrip1 = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.������ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.�л��û�ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.��Ϣ���ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.�˳�ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.contextMenuStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // timer1
            // 
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // notifyIcon1
            // 
            this.notifyIcon1.ContextMenuStrip = this.contextMenuStrip1;
            this.notifyIcon1.Visible = true;
            this.notifyIcon1.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.notifyIcon1_MouseDoubleClick);
            // 
            // contextMenuStrip1
            // 
            this.contextMenuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.������ToolStripMenuItem,
            this.�л��û�ToolStripMenuItem,
            this.��Ϣ���ToolStripMenuItem,
            this.toolStripSeparator1,
            this.�˳�ToolStripMenuItem});
            this.contextMenuStrip1.Name = "contextMenuStrip1";
            this.contextMenuStrip1.Size = new System.Drawing.Size(125, 98);
            // 
            // ������ToolStripMenuItem
            // 
            this.������ToolStripMenuItem.Name = "������ToolStripMenuItem";
            this.������ToolStripMenuItem.Size = new System.Drawing.Size(124, 22);
            this.������ToolStripMenuItem.Text = "������";
            this.������ToolStripMenuItem.Click += new System.EventHandler(this.������ToolStripMenuItem_Click);
            // 
            // �л��û�ToolStripMenuItem
            // 
            this.�л��û�ToolStripMenuItem.Name = "�л��û�ToolStripMenuItem";
            this.�л��û�ToolStripMenuItem.Size = new System.Drawing.Size(124, 22);
            this.�л��û�ToolStripMenuItem.Text = "�л��û�";
            this.�л��û�ToolStripMenuItem.Visible = false;
            // 
            // ��Ϣ���ToolStripMenuItem
            // 
            this.��Ϣ���ToolStripMenuItem.Name = "��Ϣ���ToolStripMenuItem";
            this.��Ϣ���ToolStripMenuItem.Size = new System.Drawing.Size(124, 22);
            this.��Ϣ���ToolStripMenuItem.Text = "��Ϣ���";
            this.��Ϣ���ToolStripMenuItem.Visible = false;
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(121, 6);
            // 
            // �˳�ToolStripMenuItem
            // 
            this.�˳�ToolStripMenuItem.Name = "�˳�ToolStripMenuItem";
            this.�˳�ToolStripMenuItem.Size = new System.Drawing.Size(124, 22);
            this.�˳�ToolStripMenuItem.Text = "�˳�";
            this.�˳�ToolStripMenuItem.Click += new System.EventHandler(this.�˳�ToolStripMenuItem_Click);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(0, 0);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(347, 167);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox1.TabIndex = 1;
            this.pictureBox1.TabStop = false;
            // 
            // FrmSplash
            // 
            this.BackColor = System.Drawing.Color.WhiteSmoke;
            this.ClientSize = new System.Drawing.Size(347, 167);
            this.ControlBox = false;
            this.Controls.Add(this.pictureBox1);
            this.DoubleBuffered = true;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "FrmSplash";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.TopMost = true;
            this.TransparencyKey = System.Drawing.Color.Red;
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.FrmSplash_FormClosing);
            this.Load += new System.EventHandler(this.FrmSplash_Load);
            this.contextMenuStrip1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);

        }
        #endregion


        private void FrmSplash_Load(object sender, EventArgs e)
        {
            this.timer1.Enabled = true;
            this.notifyIcon1.Visible = true;
            this.notifyIcon1.Icon = EFWCoreLib.Properties.Resources.msn;
            this.notifyIcon1.Text = "EFW��ܿͻ��˳���";
        }

        private void FrmSplash_FormClosing(object sender, FormClosingEventArgs e)
        {

        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            this.timer1.Enabled = false;
            if (_handler != null)
                _handler.Invoke(null, null);
            this.Hide();
        }

        private void notifyIcon1_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (MainForm != null)
                MainForm.Show();
        }

        private void ������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (MainForm != null)
                MainForm.Show();
        }

        private void �˳�ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Dispose();
        }

        #region ILoading ��Ա

        private Form _mainform;
        public Form MainForm
        {
            get
            {
                return _mainform;
            }
            set
            {
                _mainform = value;
            }
        }

        #endregion
    }
}
