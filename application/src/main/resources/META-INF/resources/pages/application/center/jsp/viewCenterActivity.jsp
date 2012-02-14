<%--
Copyright (c) 2005-2011 Grameen Foundation USA
All rights reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied. See the License for the specific language governing
permissions and limitations under the License.

See also http://www.apache.org/licenses/LICENSE-2.0.html for an
explanation of the license and how it is applied.
--%>

<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/tags/mifos-html" prefix="mifos"%>
<%@taglib uri="http://struts.apache.org/tags-html-el" prefix="html-el"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="/mifos/customtags" prefix="mifoscustom" %>
<%@ taglib uri="/userlocaledate" prefix="userdatefn"%>
<%@taglib uri="/loan/loanfunctions" prefix="loanfn"%>
<%@ taglib uri="/mifos/custom-tags" prefix="customtags"%>
<%@ taglib uri="/sessionaccess" prefix="session"%>

<tiles:insert definition=".clientsacclayoutsearchmenu">
 <tiles:put name="body" type="string">
 <span id="page.id" title="viewCenterActivity"></span>
 

	<script>
		function fun_cancel(){
			customerAccountActionForm.action="customerAccountAction.do?method=load";
			customerAccountActionForm.submit();
		}
</script>
		<html-el:hidden property="currentFlowKey" value="${requestScope.currentFlowKey}" />
		<c:set value="${session:getFromSession(sessionScope.flowManager,requestScope.currentFlowKey,'BusinessKey')}"
			   var="BusinessKey" />
        <table width="95%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td class="bluetablehead05"><span class="fontnormal8pt"> 
			<c:url value="customerAccountAction.do" var="customerAccountActionLoadMethodUrl" >
				<c:param name="method" value="load" />
				<c:param name="randomNUm" value="${sessionScope.randomNUm}" />
			</c:url >
			<customtags:headerLink/>
				<html-el:link styleId="viewCenterActivity.link.viewCenterCharges" href="${customerAccountActionLoadMethodUrl}">
	          	  <mifos:mifoslabel name="${ConfigurationConstants.CENTER}"/>
	          		<mifos:mifoslabel name="Center.Charges" bundle="CenterUIResources"/>
	          	</html-el:link></span>
				</td>
			</tr>
		</table>
      <table width="95%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="70%" height="24" align="left" valign="top" class="paddingL15T15"><table width="96%" border="0" cellpadding="3" cellspacing="0">
              <font class="fontnormalRedBold"><span id="viewCenterActivity.error.message"><html-el:errors bundle="CenterUIResources" /></span></font>
              <tr>
	            <td width="70%" class="headingorange">
	            	<span class="heading">
	            	<mifos:mifoslabel name="${ConfigurationConstants.CENTER}"/>
	                 <mifos:mifoslabel name="Center.Charges" bundle="CenterUIResources"/>-
	                 </span>
	                 <mifos:mifoslabel name="Customer.Accountstatementasof" bundle="CustomerUIResources"/>
				     <c:out value="${loanfn:getCurrrentDate(sessionScope.UserContext.preferredLocale)}" />
                </td>
                </tr>
              <tr>
                <td align="right" class="headingorange"><img src="pages/framework/images/trans.gif" width="10" height="5"></td>
              </tr>
            </table>
            <c:if test="${param.statusId == 13}">
	           <table width="96%" border="0" cellpadding="0" cellspacing="0">
	              <tr>
	                <td bgcolor="#F0D4A5" style="padding-left:10px; padding-bottom:3px;">
	                	<span class="fontnormalbold">
	                	<mifos:mifoslabel name="Center.ApplyTransaction" bundle="CenterUIResources"/></span>
	                	&nbsp;&nbsp;&nbsp;&nbsp;
	                <c:url value="applyPaymentAction.do" var="applyPaymentActionLoadMethodUrl" >
	                	<c:param name="method" value="load" />
	                	<c:param name="searchInput" value="ClientChargesDetails" />
	                	<c:param name="statusId" value="${param.statusId}" />
	                	<c:param name="globalCustNum" value="${param.globalCustNum}" />
	                	<c:param name="prdOfferingName" value="${param.prdOfferingName}" />
	                	<c:param name="input" value="ViewCenterCharges" />
	                	<c:param name="globalAccountNum" value="${param.globalAccountNum}" />
	                	<c:param name="accountType" value="${param.accountType}" />
	                	<c:param name="accountId" value="${param.accountId}" />
	                	<c:param name="randomNUm" value="${sessionScope.randomNUm}" />
	                	<c:param name="currentFlowKey" value="${requestScope.currentFlowKey}" />
	                </c:url >
	                
	                	<html-el:link styleId="viewCenterActivity.link.applyPayment" href="${applyPaymentActionLoadMethodUrl}">
	                    	<mifos:mifoslabel name="accounts.apply_payment" />
	                    </html-el:link>
	                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                   <c:url value="custApplyAdjustment.do" var="custApplyAdjustmentLoadAdjustmentMethodUrl" >
	                    <c:param name="method" value="loadAdjustment" />
	                    <c:param name="statusId" value="${param.statusId}" />
	                    <c:param name="globalCustNum" value="${param.globalCustNum}" />
	                    <c:param name="prdOfferingName" value="${param.prdOfferingName}" />
	                    <c:param name="input" value="ViewCenterCharges" />
	                    <c:param name="globalAccountNum" value="${param.globalAccountNum}" />
	                    <c:param name="accountType" value="${param.accountType}" />
	                    <c:param name="accountId" value="${param.accountId}" />
	                    <c:param name="randomNUm" value="${sessionScope.randomNUm}" />
	                    <c:param name="currentFlowKey" value="${requestScope.currentFlowKey}" />
	                   </c:url >
	                   
	                    <html-el:link styleId="viewCenterActivity.link.applyAdjustment" href="${custApplyAdjustmentLoadAdjustmentMethodUrl}">
	                    	<mifos:mifoslabel name="Center.ApplyAdjustment" bundle="CenterUIResources"/>
	                    </html-el:link>
	                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                   <c:url value="applyChargeAction.do" var="applyChargeActionLoadMethodUrl" >
	                    <c:param name="method" value="load" />
	                    <c:param name="statusId" value="${param.statusId}" />
	                    <c:param name="globalCustNum" value="${param.globalCustNum}" />
	                    <c:param name="prdOfferingName" value="${param.prdOfferingName}" />
	                    <c:param name="input" value="ViewCenterCharges" />
	                    <c:param name="globalAccountNum" value="${param.globalAccountNum}" />
	                    <c:param name="accountType" value="${param.accountType}" />
	                    <c:param name="accountId" value="${param.accountId}" />
	                    <c:param name="randomNUm" value="${sessionScope.randomNUm}" />
	                    <c:param name="currentFlowKey" value="${requestScope.currentFlowKey}" />
	                   </c:url >
	                   
	                    <html-el:link styleId="viewCenterActivity.link.applyCharges" href="${applyChargeActionLoadMethodUrl}">
	                    	<mifos:mifoslabel name="Center.ApplyCharges" />
						</html-el:link>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	              </tr>
	            </table>
	            <br>
	         </c:if>
 			<mifoscustom:mifostabletag moduleName="org/mifos/customers/util/resources" scope="session" source="customerAccountActivityList" xmlFileName="CustomerRecentActivity.xml" passLocale="true"/>
            <br>
             <table width="95%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td align="center">
					   <html-el:button styleId="viewCenterActivity.button.cancel" property="returnToAccountDetailsbutton"
					       onclick="fun_cancel();"
						     styleClass="buttn">
						<mifos:mifoslabel name="label.backtodetailspage" bundle="CustomerUIResources"/>
						</html-el:button>
					</td>
				</tr>
    		</table>
        </tr>
      </table>
		<html:form action="customerAccountAction.do">
        	<html-el:hidden property="globalCustNum" value="${customerGlobalNum}" />
     	</html:form>
</tiles:put>
</tiles:insert>
