﻿using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;

namespace Comun
{
    public struct PlanLocal
    {
        private string _nivel;
        private string _descripcion;

        public PlanLocal(string nivel, string descripcion)
        {
            this._nivel = nivel;
            this._descripcion = descripcion;
        }

        public string nivel { get { return _nivel; } }
        public string descripcion { get { return _descripcion; } }
    }

    public struct PrmtrsReporte
    {
        private string _nombre;
        private string _tipo;

        public PrmtrsReporte(string nombre, string tipo)
        {
            this._nombre = nombre;
            this._tipo = tipo;
        }

        public string nombre { get { return _nombre; } }
        public string tipo { get { return _tipo; } }
    }

    public struct DireccionesEmail
    {
        private string _mailTo;
        private string _mailCC;
        private string _mailCCO;

        public DireccionesEmail(string mailTo, string mailCC, string mailCCO)
        {
            this._mailTo = mailTo;
            this._mailCC = mailCC;
            this._mailCCO = mailCCO;
        }

        public string mailTo { get { return _mailTo; } set { _mailTo = value; } }
        public string mailCC { get { return _mailCC; } set { _mailCC = value; } }
        public string mailCCO { get { return _mailCCO; } set { _mailCCO = value; } }
    }

    //public struct EstadosPermitidos
    //{
    //    private bool _emite;
    //    private bool _anula;
    //    private bool _imprime;
    //    private bool _publica;
    //    private bool _envia;
    //    public EstadosPermitidos(string emite, string anula, string imprime, string publica, string envia)
    //    {

    //    }
    //}

    public class Parametros
    {
        public string ultimoMensaje = "";
        public int iErr = 0;

        private string _nivelMinAsignacion = string.Empty; 
        private string _cuentasGasto = string.Empty;
        private string _segmentoContable = "3";
        private string _pais = string.Empty;
        private string _formatoCuentaGP = string.Empty;
        private List<PlanLocal> _listaEstructuraPlanLocal = new List<PlanLocal>();

        private string _URLArchivoXSD = "";
        private string _URLArchivoXSLT = "";
        private string _URLwebServPAC = "";
        private string _reporteador = "";
        private string _rutaReporteCrystal = "";
        private string _bottomMargin = "";
        private string _topMargin = "";
        private string _leftMargin = "";
        private string _rightMargin = "";
        private string _rutaReporteSSRS = "";
        private string _SSRSServer = "";
        private List<PrmtrsReporte> _ListaParametrosReporte = new List<PrmtrsReporte>();
        private List<PrmtrsReporte> _ListaParametrosRepSSRS = new List<PrmtrsReporte>();
        private string _servidor = "";
        private string _companniaDefault = "";
        private string _seguridadIntegrada = "0";
        private string _usuarioSql = "";
        private string _passwordSql = "";
        private string _emite = "0";
        private string _anula = "0";
        private string _imprime = "0";
        private string _publica = "0";
        private string _envia = "0";
        private string _zip = "0";              //default no comprime
        private string _emailSmtp = "";
        private string _emailPort = "";
        private string _emailAccount = "";
        private string _emailUser = "";
        private string _emailPwd = "";
        private string _emailSsl = "";
        private string _replyto = "";
        private string _emailCarta = "";
        private string _emailAdjEmite = "na";   //default no aplica
        private string _emailAdjImprm = "na";   //default no aplica

        public Parametros()
        {
            try
            {
                XmlDocument listaParametros = new XmlDocument();
                listaParametros.Load(new XmlTextReader("ParametrosLAndina.xml"));
                XmlNodeList listaElementos = listaParametros.DocumentElement.ChildNodes;
                
                foreach (XmlNode n in listaElementos)
                {
                    if (n.Name.Equals("servidor"))
                        this._servidor = n.InnerXml;
                    if (n.Name.Equals("seguridadIntegrada"))
                        this._seguridadIntegrada = n.InnerXml;
                    if (n.Name.Equals("usuariosql"))
                        this._usuarioSql = n.InnerXml;
                    if (n.Name.Equals("passwordsql"))
                        this._passwordSql = n.InnerXml;
                    if (n.Name.Equals("companniaDefault"))
                        this._companniaDefault = n.InnerXml;
                }
            }
            catch (Exception eprm)
            {
                ultimoMensaje = "Contacte al administrador. No se pudo obtener la configuración general. [Parametros()]" + eprm.Message;
                iErr++;
            }
        }

        public Parametros(string IdCompannia)
        {
            try
            {
                XmlDocument listaParametros = new XmlDocument();
                listaParametros.Load(new XmlTextReader("ParametrosLAndina.xml"));
                XmlNode elemento = listaParametros.DocumentElement;

                _nivelMinAsignacion = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/nivelMinAsignacion/text()").Value;
                _cuentasGasto = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/cuentasGasto/text()").Value;
                _segmentoContable = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/segmentoContable/text()").Value;
                _pais = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/pais/text()").Value;
                _formatoCuentaGP = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/formatoCuentaGP/text()").Value;
                //_URLArchivoXSD = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/URLArchivoXSD/text()").Value;
                //_URLArchivoXSLT = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/URLArchivoXSLT/text()").Value;
                //_URLwebServPAC = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/PAC/urlWebService/text()").Value;
                //_emite = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/emite/text()").Value;
                //_anula = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/anula/text()").Value;
                //_imprime = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/imprime/text()").Value;
                //_publica = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/publica/text()").Value;
                //_envia = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/envia/text()").Value;
                //_zip = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/zip/text()").Value;
                //_reporteador = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/reporteador/text()").Value;

                //_rutaReporteCrystal = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/rutaReporteCrystal[@tipo='default']/Ruta/text()").Value;
                //_bottomMargin = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/rutaReporteCrystal[@tipo='default']/Margenes/bottomMargin/text()").Value;
                //_topMargin = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/rutaReporteCrystal[@tipo='default']/Margenes/topMargin/text()").Value;
                //_leftMargin = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/rutaReporteCrystal[@tipo='default']/Margenes/leftMargin/text()").Value;
                //_rightMargin = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/rutaReporteCrystal[@tipo='default']/Margenes/rightMargin/text()").Value;

                //_rutaReporteSSRS = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/ReporteSSRS[@tipo='default']/Ruta/text()").Value;
                //_SSRSServer = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/ReporteSSRS[@tipo='default']/SSRSServer/text()").Value;

                //_emailSmtp = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/emailSetup/smtp/text()").Value;
                //_emailPort = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/emailSetup/puerto/text()").Value;
                //_emailAccount = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/emailSetup/cuenta/text()").Value;
                //_emailUser = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/emailSetup/usuario/text()").Value;
                //_emailPwd = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/emailSetup/clave/text()").Value;
                //_emailSsl = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/emailSetup/ssl/text()").Value;
                //_replyto = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/emailSetup/replyto/text()").Value;
                //_emailCarta = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/emailSetup/carta/text()").Value;
                //_emailAdjEmite = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/emailSetup/adjuntoEmite/text()").Value;
                //_emailAdjImprm = elemento.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/emailSetup/adjuntoImprime/text()").Value;

                XmlNodeList listaElementos = listaParametros.DocumentElement.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/estructuraPlanLocal[@tipo='default']").ChildNodes;
                foreach (XmlNode n in listaElementos)
                {
                    if (n.Name.Equals("Parametro"))
                    {
                        this._listaEstructuraPlanLocal.Add(new PlanLocal(n.SelectSingleNode("Nivel/text()").Value,
                                                                         n.SelectSingleNode("Descripcion/text()").Value));
                    }
                }

                //listaElementos = listaParametros.DocumentElement.SelectSingleNode("//compannia[@bd='" + IdCompannia + "']/ReporteSSRS[@tipo='default']").ChildNodes;
                //foreach (XmlNode n in listaElementos)
                //{
                //    if (n.Name.Equals("Parametro"))
                //    {
                //        this._ListaParametrosRepSSRS.Add(new PrmtrsReporte(n.SelectSingleNode("Nombre/text()").Value,
                //                                                            n.SelectSingleNode("Tipo/text()").Value));
                //    }
                //}
            }
            catch (Exception eprm)
            {
                ultimoMensaje = "Contacte al administrador. No se pudo obtener la configuración de la compañía " + IdCompannia + ". [Parametros(Compañía)] " + eprm.Message;
                iErr++;
            }
        }

        public string servidor
        {
            get { return _servidor; }
            set { _servidor = value; }
        }
        public string companniaDefault 
        {
            get { return _companniaDefault; }
            set { _companniaDefault = value; }
        }
        

        public bool seguridadIntegrada
        {
            get 
            { 
                return _seguridadIntegrada.Equals("1"); 
            }
            set 
            { 
                if (value)
                    _seguridadIntegrada = "1"; 
                else
                    _seguridadIntegrada = "0"; 
            }
        }

        public string usuarioSql
        {
            get { return _usuarioSql; }
            set{ _usuarioSql = value;}
        }

        public string passwordSql
        {
            get { return _passwordSql; }
            set {_passwordSql=value;}
        }

        public string nivelMinAsignacion
        {
            get { return _nivelMinAsignacion; }
            set { _nivelMinAsignacion = value; }
        }
        public string cuentasGasto 
        {
            get { return _cuentasGasto ; }
            set { _cuentasGasto  = value; }
        }
        public string segmentoContable 
        {
            get { return _segmentoContable; }
            set { _segmentoContable = value; }
        }
        public string pais 
        {
            get { return _pais; }
            set { _pais = value; }
        }

        public string formatoCuentaGP
        {
            get { return _formatoCuentaGP; }
            set { _formatoCuentaGP = value; }
        }

        public List<PlanLocal> listaEstructuraPlanLocal
        {
            get
            {
                return _listaEstructuraPlanLocal;
            }
            set { _listaEstructuraPlanLocal = value; }
        }

        public string URLArchivoXSD
        {
            get { return _URLArchivoXSD; }
            set { _URLArchivoXSD = value; }
        }

        public string URLArchivoXSLT
        {
            get { return _URLArchivoXSLT; }
            set { _URLArchivoXSLT = value; }
        }

        public string URLwebServPAC
        {
            get { return _URLwebServPAC; }
            set { _URLwebServPAC = value; }
        }

        public string reporteador
        {
            get { return _reporteador; }
            set { _reporteador = value; }
        }

        public string rutaReporteCrystal
        {
            get { return _rutaReporteCrystal; }
        }

        public int bottomMargin
        {
            get
            {
               return Convert.ToInt32(_bottomMargin); 
            }
        }

        public int topMargin
        {
            get
            {
               return Convert.ToInt32(_topMargin);
            }
        }

        public int leftMargin
        {
            get { 
                return Convert.ToInt32(_leftMargin); 
            }
        }

        public int rightMargin
        {
            get { 
                return Convert.ToInt32(_rightMargin); 
            }
        }

        public string rutaReporteSSRS
        {
            get { return _rutaReporteSSRS; }
            set { _rutaReporteSSRS = value; }
        }

        public string SSRSServer
        {
            get { return _SSRSServer; }
            set { _SSRSServer = value; }
        }

        public List<PrmtrsReporte> ListaParametrosReporte
        {
            get { return _ListaParametrosReporte; }
        }

        public List<PrmtrsReporte> ListaParametrosRepSSRS
        {
            get { return _ListaParametrosRepSSRS; }
        }

        public int intEstadosPermitidos
        {
            get
            {
                return
                        Convert.ToInt32(_emite) +
                    2 * Convert.ToInt32(_anula) +
                    4 * Convert.ToInt32(_imprime) +
                    8 * Convert.ToInt32(_publica) +
                    16 * Convert.ToInt32(_envia);
            }
        }

        public int intEstadoCompletado
        {
            get
            {
                return
                        Convert.ToInt32(_emite) +
                    2 * 0 +
                    4 * Convert.ToInt32(_imprime) +
                    8 * Convert.ToInt32(_publica) +
                    16 * Convert.ToInt32(_envia);
            }
        }
        public bool emite
        {
            get { return _emite.Equals("1"); }
        }

        public bool anula
        {
            get { return _anula.Equals("1"); }
        }

        public bool imprime
        {
            get { return _imprime.Equals("1"); }
        }

        public bool publica
        {
            get { return _publica.Equals("1"); }
        }

        public bool envia
        {
            get { return _envia.Equals("1"); }
        }

        public bool zip
        {
            get { return _zip.Equals("1"); }
        }

        public string tipoDoc
        {
            get { return "FACTURA"; }
        }

        public string emailSmtp
        {
            get { return _emailSmtp; }
        }

        public int emailPort
        {
            get { return Convert.ToInt32( _emailPort); }
        }

        public string emailUser
        {
            get { return _emailUser; }
        }

        public string emailPwd
        {
            get { return _emailPwd; }
        }

        public string emailCarta
        {
            get { return _emailCarta; }
        }

        public string emailAccount
        {
            get { return _emailAccount; }
        }

        public bool emailSsl
        {
            get { return _emailSsl.ToLower().Equals("true"); }
        }

        public string replyto
        {
            get { return _replyto; }
        }

        public string emailAdjEmite
        {
            get { return _emailAdjEmite; }
        }

        public string emailAdjImprm
        {
            get { return _emailAdjImprm; }
        }
    }
}
