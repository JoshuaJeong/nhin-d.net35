
package org.nhindirect.config.service.jaxws;

import java.util.Collection;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;
import org.nhindirect.config.store.Address;

@XmlRootElement(name = "listAddresssResponse", namespace = "http://nhind.org/config")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "listAddresssResponse", namespace = "http://nhind.org/config")
public class ListAddresssResponse {

    @XmlElement(name = "return", namespace = "")
    private Collection<Address> _return;

    /**
     * 
     * @return
     *     returns Collection<Address>
     */
    public Collection<Address> getReturn() {
        return this._return;
    }

    /**
     * 
     * @param _return
     *     the value for the _return property
     */
    public void setReturn(Collection<Address> _return) {
        this._return = _return;
    }

}
