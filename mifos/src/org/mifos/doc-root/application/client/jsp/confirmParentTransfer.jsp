<!--
/**

* previewEditClientPersonalInfo.jsp    version: 1.0



* Copyright (c) 2005-2006 Grameen Foundation USA

* 1029 Vermont Avenue, NW, Suite 400, Washington DC 20005

* All rights reserved.



* Apache License
* Copyright (c) 2005-2006 Grameen Foundation USA
*

* Licensed under the Apache License, Version 2.0 (the "License"); you may
* not use this file except in compliance with the License. You may obtain
* a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
*

* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and limitations under the

* License.
*
* See also http://www.apache.org/licenses/LICENSE-2.0.html for an explanation of the license

* and how it is applied.

*

*/
 -->
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/tags/mifos-html" prefix="mifos"%>
<%@taglib uri="http://struts.apache.org/tags-html-el" prefix="html-el"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="/mifos/customtags" prefix="mifoscustom"%>

<tiles:insert definition=".detailsCustomer">
	<tiles:put name="body" type="string">

		<SCRIPT SRC="pages/framework/js/CommonUtilities.js"></SCRIPT>
		<script language="javascript">
  
   function goToCancelPage(){
	clientTransferActionForm.action="clientTransferAction.do?method=cancel";
	clientTransferActionForm.submit();
  }
</script>
		<html-el:form action="clientTransferAction.do?method=update"
			onsubmit="func_disableSubmitBtn('submitButton');">


			<table width="95%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="bluetablehead05"><span class="fontnormal8pt"> <a
						href="CustomerSearchAction.do?method=getOfficeHomePage&officeId=<c:out value="${sessionScope.linkValues.customerOfficeId}"/>&officeName=<c:out value="${sessionScope.linkValues.customerOfficeName}"/>&loanOfficerId=<c:out value="${requestScope.Context.userContext.id}"/>">
					<c:out value="${sessionScope.linkValues.customerOfficeName}" /></a>
					/ </span> <c:if
						test="${!empty sessionScope.linkValues.customerCenterName}">
						<span class="fontnormal8pt"> <a
							href="centerAction.do?method=get&globalCustNum=<c:out value="${sessionScope.linkValues.customerCenterGCNum}"/>">
						<c:out value="${sessionScope.linkValues.customerCenterName}" /> </a>
						/ </span>
					</c:if> <c:if
						test="${!empty sessionScope.linkValues.customerParentName}">
						<span class="fontnormal8pt"> <a
							href="GroupAction.do?method=get&globalCustNum=<c:out value="${sessionScope.linkValues.customerParentGCNum}"/>">
						<c:out value="${sessionScope.linkValues.customerParentName}" /> </a>
						/ </span>
					</c:if> <!-- Name of the client --> <span class="fontnormal8pt"> <a
						href="clientCreationAction.do?method=get&globalCustNum=<c:out value="${sessionScope.linkValues.globalCustNum}"/>">
					<c:out value="${sessionScope.linkValues.customerName}" /> </a> </span>
					</td>
				</tr>
			</table>
			<table width="95%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td align="left" valign="top" class="paddingL15T15">
					<table width="95%" border="0" cellpadding="3" cellspacing="0">
						<tr>
							<td class="headingorange"><span class="heading"> <c:out
								value="${sessionScope.linkValues.customerName}" /> - </span> <mifos:mifoslabel
								name="client.EditLink" bundle="ClientUIResources"></mifos:mifoslabel>
							<mifos:mifoslabel name="${ConfigurationConstants.GROUP}"></mifos:mifoslabel>
							<mifos:mifoslabel name="client.MembershipLink"
								bundle="ClientUIResources"></mifos:mifoslabel> <span></span></td>
							<td></td>
						</tr>
						<tr>
							<td class="fontnormal"><mifos:mifoslabel
								name="client.EditGroupInstructions1" bundle="ClientUIResources"></mifos:mifoslabel>
							<mifos:mifoslabel name="${ConfigurationConstants.GROUP}"></mifos:mifoslabel>
							<mifos:mifoslabel name="client.EditGroupInstructions2"
								bundle="ClientUIResources"></mifos:mifoslabel> <mifos:mifoslabel
								name="${ConfigurationConstants.CLIENT}"></mifos:mifoslabel> <mifos:mifoslabel
								name="client.EditGroupInstructions3" bundle="ClientUIResources"></mifos:mifoslabel>
							<mifos:mifoslabel name="${ConfigurationConstants.GROUP}"></mifos:mifoslabel>

							</td>

						</tr>
					</table>

					<font class="fontnormalRedBold"><html-el:errors
						bundle="ClientUIResources" /></font>
					<table width="96%" border="0" cellpadding="3" cellspacing="0">
						<tr>
							<td class="fontnormalbold"><span class="fontnormal"><br>
							</span>Change Group Membership: <span class="fontnormal"><c:out
								value="${requestScope.clientTransferVO.parentGroupName}" /> <br>
							</span></td>
						</tr>
					</table>

					<!-- Submit and cancel buttons -->
					<table width="93%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center" class="blueline">&nbsp;</td>
						</tr>
					</table>
					<br>
					<table width="93%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center">&nbsp; <html-el:submit property="submitButton"
								style="width:70px" styleClass="buttn">
								<mifos:mifoslabel name="button.submit"
									bundle="ClientUIResources"></mifos:mifoslabel>
							</html-el:submit> &nbsp; &nbsp; <html-el:button
								onclick="goToCancelPage();" property="cancelButton"
								styleClass="cancelbuttn" style="width:70px">
								<mifos:mifoslabel name="button.cancel"
									bundle="ClientUIResources"></mifos:mifoslabel>
							</html-el:button></td>
						</tr>
					</table>
					<!-- Submit and cancel buttons end --></td>
				</tr>
			</table>
			<br>
			<td></td>
			<tr></tr>
			<table></table>
		</html-el:form>

	</tiles:put>
</tiles:insert>

