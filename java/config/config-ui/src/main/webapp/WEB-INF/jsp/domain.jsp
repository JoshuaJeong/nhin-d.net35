<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><fmt:message key="domain.title" /></title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/header.jsp" %>
	<div id="form">
    <fieldset>
    <center><h3>NHIN Direct Java Reference Implememtation - Add/Update a Domain</h3></center>
    </fieldset>
    <spring:url value="/config/domain/saveupdate" var="formUrl"/>
    <form:form id="domainForm"
        action="${fn:escapeXml(formUrl)}" cssClass="cleanform"
        commandName="domainForm" method="POST">
        <div class=error">
            <form:errors path="*" cssClass="error" />
        </div>
        <c:if test='${not empty msg && not empty msg["msg"]}'>
            <div class="error">
                <fmt:message key='${msg["msg"]}' />
            </div>
        </c:if>
        <form:hidden path="id"/>
        <form:hidden path="postmasterEmailAddressId"/>  
        <table>
            <tr>
                <td>
	                 <form:label path="domainName" >Domain Name: 
                        <form:errors path="domainName" cssClass="error" />
                    </form:label>
                </td>
                <td> 
                    <form:input path="domainName" /> 
                </td>
            </tr>
        <c:choose>
            <c:when test='${empty action || action == "Add" }'>
            <tr>
                <td>
		            <form:label path="postmasterEmail">Postmaster E-Mail Address:
		                <form:errors path="postmasterEmail" cssClass="error" />
		            </form:label>
		        </td>
		        <td>
	               <form:input path="postmasterEmail" /> 
	            </td>
	        </tr>
            </c:when>
            <c:otherwise>
            </c:otherwise>
        </c:choose>
	        <tr>
	           <td>
	            <form:label path="status">Status: 
	                <form:errors path="status" cssClass="error" />
	            </form:label>
	           </td>
	           <td>
	            <form:select path="status">
	                <form:options items="${statusList}"/>
	            </form:select>
	           </td>
	        </tr>
        </table>
        <p>
        <c:choose>
            <c:when test='${empty action || action == "Add" }'>
                <button name="submitType" id="submitType" type="submit" value="add">Add</button>
            </c:when>
            <c:otherwise>
                <button name="submitType" id="submitType" type="submit" value="update">Update</button>
            </c:otherwise>
        </c:choose>
        <button name="submitType" id="submitType" type="submit" value="cancel">Cancel</button>
        </p>
    </form:form>
    </div>
        
 	<c:if test="${not empty addressesResults}">
	<div id="dynamicaddresses">
        
        <fieldset style="width:90%;" title="Address">
		<spring:url value="/config/domain/addaddress" var="formUrladdaddress"/>
	   <form:form modelAttribute="addressForm" action="${fn:escapeXml(formUrladdaddress)}" cssClass="cleanform" method="POST" >
		   	<form:hidden path="id"/>
		   	<table cellpadding="1px" cellspacing="1px" id="addressTable">
		   	<tr>
		   		<th>
		        <form:label path="displayName">Display name:
		            <form:errors path="displayName" cssClass="error" />
		        </form:label>
		        </th>
		        <th>
		        <form:input path="displayName" />
		        </th>
			</tr>
		   	<tr>
		   		<th>
		        <form:label path="emailAddress">E-Mail Address:
		            <form:errors path="emailAddress" cssClass="error" />
		        </form:label>
		        </th>
		        <th>
		        <form:input path="emailAddress" />
		        </th>
			</tr>		        
		   	<tr>
		   		<th>
	            <form:label path="aStatus">Status: 
	                <form:errors path="aStatus" cssClass="error" />
	            </form:label>
	            </th>
	            <th>
	            <form:select path="aStatus">
	                <form:options items="${statusList}"/>
	            </form:select>
		        </th>
			</tr>		        
		   	<tr>
		   		<th>
		        <form:label path="type">Type:
		            <form:errors path="type" cssClass="error" />
		        </form:label>
		        </th>
		        <th>
		        <form:input path="type" />
		        </th>
			</tr>		        
		    </table>
			<button name="submitType" id="submitType" type="submit" value="newaddress">Add Address</button>
		</form:form>
		</fieldset>
		<fieldset style="width:90%;" title="Addresses">
	   <spring:url value="/config/domain/removeaddresses" var="formUrlremove"/>
	   <form:form modelAttribute="simpleForm" action="${fn:escapeXml(formUrlremove)}" cssClass="cleanform" method="POST" >
	   	<form:hidden path="id"/>
        <table cellpadding="1px" cellspacing="1px" id="addressTable">
            <thead>
                <tr>
                    <th width="30%">Email Address</th>
                    <th width="25%">Display Name</th>
                    <th width="15%">Type</th>
                    <th width="15%">Status</th>
                    <th width="15%">Sel</th>
                </tr>
            </thead>
            <tbody>             
                <!--  Put the data from the searchResults attribute here -->
                <c:forEach var="address" items="${addressesResults}" varStatus="rowCounter">
                <c:choose>
                    <c:when test="${rowCounter.count % 2 == 0}">
                    <tr class="evenRow">
                    </c:when>
                    <c:otherwise>
                    <tr class="oddRow">
                    </c:otherwise>
                </c:choose>
                    <td width="30%"><a href='../address?id=<c:out value="${address.id}"/>'>'${address.emailAddress}'</a></td>  
                    <td width="25%"><c:out value="${address.displayName}"/></td>
                    <td width="15%"><c:out value="${address.type}"/></td>
                    <td width="15%"><c:out value="${address.status}"/></td>
                    <td width="15%"><form:checkbox path="remove" value="${address.id}" /></td>
                </tr>
                </c:forEach>    
            </tbody>
            <tfoot>
                <tr>
                    <th width="30%"></th>
                    <th width="25%"></th>
                    <th width="15%"></th>
                    <th width="15%"></th>
                    <th width="15%"></th>
                </tr>
            </tfoot>
        </table>
            <!-- Wire this up to jQuery to add an input row to the table.  
                 Don't submit it all until the final submit is done -->
            <button name="submitType" id="submitType" type="submit" value="delete">Remove Selected</button>
            </form:form>
        </fieldset>
	</div>
	</c:if>
</body>
</html>