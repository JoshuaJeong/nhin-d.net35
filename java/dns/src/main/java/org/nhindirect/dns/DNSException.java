/* 
Copyright (c) 2010, NHIN Direct Project
All rights reserved.

Authors:
   Greg Meyer      gm2552@cerner.com
 
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer 
in the documentation and/or other materials provided with the distribution.  Neither the name of the The NHIN Direct Project (nhindirect.org). 
nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS 
BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE 
GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, 
STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF 
THE POSSIBILITY OF SUCH DAMAGE.
*/

package org.nhindirect.dns;

/**
 * Exception for DNS server errors.
 * @author Greg Meyer
 * @since 1.0
 */
public class DNSException extends Exception 
{
	
	static final long serialVersionUID = 1852021431664662496L;
	
	
	private DNSError<?> error;
	
	/**
	 * Construct an exception with an error message.
	 * @param error The error message.
	 */
    public DNSException(String error)
    {
    	super(error);
    }	
	
	/**
	 * Construct an exception with a given DNS error.
	 * @param error The DNS error.
	 */
    public DNSException(DNSError<?> error)
    {
    	this(error, "");
    }
    
	/**
	 * Constructs an exception with a message and the DNS error.
	 * @param error The DNS error
	 * @param msg The exception message.
	 */    
    public DNSException(DNSError<?> error, String message)
    {
    	this(error,"",null);
    }
       
	/**
	 * Constructs an exception with the DNS error and the exception that caused the error.
	 * @param error The DNS error.
	 * @param innerException The exception that caused the error.
	 */     
    public DNSException(DNSError<?> error, Exception innerException)
    {
    	this(error, "", innerException);
    }
    
	/**
	 * Constructs an exception with the DNS error, a message, and the exception that caused the error.
	 * @param error The DNS error.
	 * @param msg The exception message.
	 * @param innerException The exception that caused the error.
	 */      
    public DNSException(DNSError<?> error, String message, Exception innerException)
    {
    	super(message, innerException);
    	this.error = error;
    }
    
    /**
     * Gets the internal DNSError.
     * @return The internal DNSError.
     */
    public DNSError<?> getError()
    {
    	return this.error;
    }
}
