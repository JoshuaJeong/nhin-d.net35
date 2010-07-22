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

namespace DnsResolver
{
    //                                 1  1  1  1  1  1
    //   0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5
    // +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    // |                                               |
    // /                     QNAME                     /
    // /                                               /
    // +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    // |                     QTYPE                     |
    // +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    // |                     QCLASS                    |
    // +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

    public class DnsQuestion
    {
        string m_qname;
        
        internal DnsQuestion()
        {
        }

        internal DnsQuestion(ref DnsBufferReader reader)
        {
            this.Parse(ref reader);
        }
        
        public DnsQuestion(string qName, Dns.RecordType qType)
            : this(qName, qType, Dns.Class.IN)
        {
        }
        
        public DnsQuestion(string qName, Dns.RecordType qType, Dns.Class qClass)
        {
            this.QName = qName;
            this.QType = qType;
            this.QClass = qClass;
        }
        
        // QNAME
        public string QName
        {
            get
            {
                return this.m_qname;
            }
            set
            {
                if (value == null)
                {
                    throw new DnsProtocolException(DnsProtocolError.InvalidQName);
                }
                
                this.m_qname = value;
            }
        }

        // QTYPE
        public Dns.RecordType QType
        {
            get;
            set;
        }
        
        // QCLASS 
        public Dns.Class QClass
        {
            get;
            set;
        }
        
        internal void Parse(ref DnsBufferReader reader)
        {
            this.QName = reader.ReadString();
            this.QType = (Dns.RecordType) reader.ReadShort();
            this.QClass = (Dns.Class) reader.ReadShort();
        }

        internal void ToBytes(DnsBuffer buffer)
        {
            buffer.AddPath(this.QName);
            buffer.AddShort((short)QType);
            buffer.AddShort((short)QClass);
        }
    }
}