<%@ taglib uri="http://struts.apache.org/tags-html-el" prefix="html-el"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/tags/mifos-html" prefix="mifos"%>
<%@ taglib uri="/mifos/customtags" prefix="mifoscustom"%>
<%@ taglib uri="/userlocaledate" prefix="userdatefn"%>
<%@ taglib uri="/mifos/custom-tags" prefix="customtags"%>

<tiles:insert definition=".clientsacclayoutsearchmenu">
	<tiles:put name="body" type="string">
		<script language="javascript">
			  function goToCancelPage(form){
				form.action="editCustomerStatusAction.do?method=cancel";
				form.submit();
			  }
			  function GoToEditPage(form){
				form.action="editCustomerStatusAction.do?method=previous";
				form.submit();
			  }
		</script>
		<html-el:form action="editCustomerStatusAction?method=update">
			<table width="95%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="bluetablehead05">
						<span class="fontnormal8pt">
							<customtags:headerLink/>
						</span>
					</td>
				</tr>
			</table> 
			<table width="95%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td align="left" valign="top" class="paddingL15T15">
					<table width="95%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="83%" class="headingorange"><span class="heading"> <c:out
								value="${sessionScope.editCustomerStatusActionForm.customerName}" />&nbsp;-</span>
							<mifos:mifoslabel name="Customer.ConfirmStatusChange"/></td>
						</tr>
						<tr>
							<td class="headingorange"><span class="fontnormalbold"> <mifos:mifoslabel
								name="Customer.NewStatus"></mifos:mifoslabel>:
							</span> <span class="fontnormal"> <mifoscustom:MifosImage
								id="${sessionScope.editCustomerStatusActionForm.newStatusId}"
								moduleName="customer" /><c:out
								value="${sessionScope.newStatusName}" /> <c:if
								test="${!empty sessionScope.flagName}">
                     	- <c:out value="${sessionScope.flagName}" />
							</c:if></span></td>
						</tr>
						<tr><logic:messagesPresent>
							<td><br><font class="fontnormalRedBold"><html-el:errors bundle="CustomerUIResources" /></font></td>
							</logic:messagesPresent>
						</tr>
						<tr>
							<td class="fontnormal"><br>
							<span class="fontnormalbold"> <c:out
								value="${sessionScope.editCustomerStatusActionForm.commentDate}" />
							</span> <span class="fontnormal"><br>
							<c:out value="${sessionScope.editCustomerStatusActionForm.notes}"/>&nbsp;-</span> 
							<em><c:out
								value="${sessionScope.UserContext.name}" /></em>
							</td>
						</tr>
						<c:if test="${!empty sessionScope.checklist}">
							<tr>
								<td class="blueline"><img src="pages/framework/images/trans.gif"
									width="10" height="12"></td>
							</tr>
							<tr>
								<td class="fontnormal">&nbsp;</td>
							</tr>
							<tr>
								<td class="fontnormal"><mifos:mifoslabel
									name="Customer.ChecklistMsg"></mifos:mifoslabel>
								<mifos:mifoslabel name="Customer.ClickSubmit" />
								<mifos:mifoslabel name="Customer.ClickCancel1" />
								<c:if test="${sessionScope.editCustomerStatusActionForm.levelId == '1'}">
									<mifos:mifoslabel name="${ConfigurationConstants.CLIENT}" />
								</c:if>
								<c:if test="${sessionScope.editCustomerStatusActionForm.levelId == '2'}">
									<mifos:mifoslabel name="${ConfigurationConstants.GROUP}" />
								</c:if>
								<c:if test="${sessionScope.editCustomerStatusActionForm.levelId == '3'}">
									<mifos:mifoslabel name="${ConfigurationConstants.CENTER}" />
								</c:if>
							<mifos:mifoslabel name="Customer.ClickCancel2"></mifos:mifoslabel>
								</td>
							</tr>
						</c:if>
					</table>
					<br>
					<%-- <c:if test="${!empty sessionScope.checklist}">
						<table width="95%" border="0" cellpadding="3" cellspacing="0">
							<bean:size collection="${sessionScope.checklist}" id="listSize" />
							<html-el:hidden property="chklistSize"
								value="${pageScope.listSize}" />
							<c:forEach var="chklist" items="${sessionScope.checklist}">
								<tr class="fontnormal">
									<html-el:multibox name="editCustomerStatusActionForm"
										property="selectedItems">
										<td width="2%" valign="top"><c:out
											value="${chklist.checklistId}" /></td>
									</html-el:multibox>
									<c:out value="${chklist.checklistName}" />
								</tr>
							</c:forEach>
						</table>
					</c:if> --%>
					 <c:if test="${!empty sessionScope.checklist}">
						<table width="95%" border="0" cellpadding="3" cellspacing="0">
							<c:forEach var="chklist" items="${sessionScope.checklist}">
								<c:forEach var="chklistDetail" items="${chklist.checklistDetailSet}"> 
									<bean:size collection="${chklist.checklistDetailSet}" id="listSize" />
									<html-el:hidden property="chklistSize"	value="${pageScope.listSize}" />
								<tr class="fontnormal">
									<html-el:multibox name="editCustomerStatusActionForm"
										property="selectedItems">
										<td width="2%" valign="top"><c:out
											value="${chklistDetail.detailId}" /></td>
									</html-el:multibox>
									<c:out value="${chklistDetail.detailText}" /> 
								</tr>
								</c:forEach>
							</c:forEach>
						</table>
					</c:if>  
					
					<table width="95%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td style="padding-top:5px;"><html-el:button property="editInfo"
								value="Edit Status" styleClass="insidebuttn" style="width:65px;"
								onclick="GoToEditPage(this.form)">
								<mifos:mifoslabel name="Customer.EditStatus"></mifos:mifoslabel>
							</html-el:button></td>
						</tr>
						<tr>
							<td align="center" class="blueline">&nbsp;</td>
						</tr>
					</table>
					<br>
					<table width="95%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center"><html-el:submit property="btn"
								styleClass="buttn" style="width:70px;">
								<mifos:mifoslabel name="Customer.submit"></mifos:mifoslabel>
							</html-el:submit> &nbsp;&nbsp; <html-el:button property="btn"
								styleClass="cancelbuttn" style="width:70px"
								onclick="goToCancelPage(this.form)">
								<mifos:mifoslabel name="Customer.cancel"></mifos:mifoslabel>
							</html-el:button></td>
						</tr>
					</table>
					<br>
					</td>
					
			</table>
			
		</html-el:form>
	</tiles:put>
</tiles:insert>
