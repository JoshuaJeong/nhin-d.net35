﻿/* 
 Copyright (c) 2010, NHIN Direct Project
 All rights reserved.

 Authors:
    Umesh Madan     umeshma@microsoft.com
    Sean Nolan      seannol@microsoft.com
 
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
Neither the name of the The NHIN Direct Project (nhindirect.org). nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.IO;
using System.Net;

namespace DnsResolver
{
    public class DNSCert
    {
        X509Certificate2 m_cert;
        ushort m_keyTag;
        string m_name;
        int m_ttl;

        public DNSCert(ushort keyTag, string certificate)
        {
            if (string.IsNullOrEmpty(certificate))
            {
                throw new ArgumentException();
            }
            m_keyTag = keyTag;
            //
            // TODO: Support
            //  - Remove '(' and ')'
            //  - Remove spaces
            //
            this.Certificate = new X509Certificate2(Convert.FromBase64String(this.NormalizeInputCertString(certificate)));
        }

        public DNSCert(ushort keyTag, byte[] certificate)
        {
            if (certificate == null || certificate.Length == 0)
            {
                throw new ArgumentException();
            }
            m_keyTag = keyTag;
            //
            // TODO: Support
            //  - Remove '(' and ')'
            //  - Remove spaces
            //
            this.Certificate = new X509Certificate2(certificate);
        }

        public DNSCert(X509Certificate2 cert)
        {
            this.Certificate = cert;
        }

        public X509Certificate2 Certificate
        {
            get
            {
                return m_cert;
            }
            set
            {
                if (value == null)
                {
                    throw new ArgumentNullException();
                }

                m_cert = value;
                m_name = m_cert.ExtractEmailNameOrName();
                if (string.IsNullOrEmpty(m_name))
                {
                    throw new NotSupportedException();
                }
                m_name = m_name.Replace('@', '.');
                this.ExtractTag();
            }
        }

        public string Name
        {
            get
            {
                return m_name;
            }
        }

        public ushort KeyTag
        {
            get
            {
                return m_keyTag;
            }
        }

        public int TTL
        {
            get
            {
                return m_ttl;
            }
            set
            {
                m_ttl = value;
            }
        }
        
        /// <summary>
        /// Exports this record as a DNS CERT RR.
        /// </summary>
        /// <param name="dnsDomain">The domain name to use for the address.</param>
        /// <returns>A string representation of the DNS CERT RR.</returns>
        public string Export(string dnsDomain)
        {
            StringWriter writer = new StringWriter();
            this.Export(writer, dnsDomain);
            return writer.ToString();
        }

        /// <summary>
        /// Exports this record as a DNS CERT RR
        /// </summary>
        /// <param name="writer">The writer to which to export the RR.</param>
        /// <param name="dnsDomain">The domain name to use for the address.</param>
        public void Export(TextWriter writer, string dnsDomain)
        {
            if (writer == null || string.IsNullOrEmpty(dnsDomain))
            {
                throw new ArgumentNullException();
            }

            string exported = this.NormalizeOutputCertString(Convert.ToBase64String(m_cert.Export(X509ContentType.Cert)));
            string certName = m_name;
            if (!certName.EndsWith(dnsDomain))
            {
                certName = dnsDomain.ConstructEmailDnsDomainName(m_name);
            }
            
            if (m_ttl > 0)
            {
                writer.Write("{0}. {1} IN CERT 1 {2} 5 {3}", certName, m_ttl, (ushort)IPAddress.HostToNetworkOrder((short)m_keyTag), exported);
            }
            else
            {
                writer.Write("{0}. IN CERT 1 {1} 5 {2}", certName, (ushort)IPAddress.HostToNetworkOrder((short)m_keyTag), exported);
            }
        }

        void ExtractTag()
        {
            RSACryptoServiceProvider rsaProvider = m_cert.PublicKey.Key as RSACryptoServiceProvider;
            if (rsaProvider == null)
            {
                throw new NotSupportedException();
            }

            RSAParameters rsaParams = rsaProvider.ExportParameters(false);
            byte[] modulus = rsaParams.Modulus;

            m_keyTag = (ushort)((modulus[modulus.Length - 2] << 8) | (modulus[modulus.Length - 1]));
        }


        string NormalizeInputCertString(string cert)
        {
            StringBuilder builder = new StringBuilder();
            for (int i = 0; i < cert.Length; ++i)
            {
                char ch = cert[i];
                if (ch != '(' && ch != ')' && !char.IsWhiteSpace(ch))
                {
                    builder.Append(ch);
                }
            }

            return builder.ToString();
        }

        string NormalizeOutputCertString(string cert)
        {
            StringBuilder builder = new StringBuilder();
            builder.AppendLine("(");
            for (int i = 0; i < cert.Length; ++i)
            {
                char ch = cert[i];
                if (i > 0 && (i % 28) == 0)
                {
                    builder.AppendLine();
                }
                builder.Append(ch);
            }
            builder.AppendLine();
            builder.AppendLine(")");
            return builder.ToString();
        }

    }
}
