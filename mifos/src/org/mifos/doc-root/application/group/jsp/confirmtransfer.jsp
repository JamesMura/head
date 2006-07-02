<!-- /**
 
 * confirmtransfer.jsp    version: 1.0
 
 
 
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
 
 */-->
<%@ taglib uri="http://struts.apache.org/tags-html-el" prefix="html-el"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/tags/mifos-html" prefix = "mifos"%>


<tiles:insert definition=".clientsacclayoutsearchmenu">
<tiles:put name="body" type="string">
<SCRIPT SRC="pages/application/group/js/groupcommon.js"></SCRIPT>
<script language="javascript">

  function goToCancelPage(){
	groupActionForm.action="GroupAction.do?method=cancel";
	groupActionForm.submit();
  }
</script>
 <SCRIPT SRC="pages/framework/js/CommonUtilities.js"></SCRIPT>
<html-el:form action="/GroupAction.do?method=updateBranch"  onsubmit="func_disableSubmitBtn('submitBtn')">

  <table width="95%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td class="bluetablehead05">
             <span class="fontnormal8pt">
            <a href="CustomerSearchAction.do?method=getOfficeHomePage&officeId=<c:out value="${sessionScope.linkValues.customerOfficeId}"/>&officeName=<c:out value="${sessionScope.linkValues.customerOfficeName}"/>&loanOfficerId=<c:out value="${requestScope.Context.userContext.id}"/>">
	           <c:out value="${sessionScope.linkValues.customerOfficeName}"/>            	
           </a> /
           	<c:if test="${!empty sessionScope.linkValues.customerParentName}">
               	<a href="centerAction.do?method=get&globalCustNum=<c:out value="${sessionScope.linkValues.customerParentGCNum}"/>">
			       	<c:out value="${sessionScope.linkValues.customerParentName}"/>
		       	</a> /  
		    </c:if>
          <a href="GroupAction.do?method=get&globalCustNum=<c:out value="${sessionScope.linkValues.globalCustNum}"/>">
          	<c:out value="${sessionScope.linkValues.customerName}"/>
           </a>
            </span>
          </td>
        </tr>
      </table>
      <table width="95%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td align="left" valign="top" class="paddingL15T15" >
            <table width="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="83%" class="headingorange">
                	<span class="heading">
                		<c:out value="${sessionScope.groupTransferInput.groupName}"/>  
	                -</span> 
	                <mifos:mifoslabel name="Group.editOfficeMembership" bundle="GroupUIResources"/>
	                <mifos:mifoslabel name="Group.confirm" bundle="GroupUIResources"></mifos:mifoslabel>
	                
                </td>
              </tr>
             <tr>
   				<td>
   				<font class="fontnormalRedBold"><html-el:errors bundle="GroupUIResources"/></font>
				</td>
			</tr>
              
            </table>
            <br>
            <table width="95%" border="0" cellpadding="3" cellspacing="0">
              <tr class="fontnormal">
                 <td width="94%"><span class="fontnormal">
                 	<mifos:mifoslabel name="Group.sureToTransfer" bundle="GroupUIResources"/>
    		            <mifos:mifoslabel name="${ConfigurationConstants.GROUP}" />
    		            <mifos:mifoslabel name="Group.to" bundle="GroupUIResources"/> &quot;
	    		           <c:out value="${sessionScope.groupTransferInput.officeName}"/>
            		    &quot; ?<br>
    		                <br>
        		            <mifos:mifoslabel name="Group.transferbranchMsg3" bundle="GroupUIResources"></mifos:mifoslabel>
        		            <mifos:mifoslabel name="Group.transferbranchMsg2" bundle="GroupUIResources"></mifos:mifoslabel>
        		             <mifos:mifoslabel name="${ConfigurationConstants.GROUP}"></mifos:mifoslabel>
		                  <mifos:mifoslabel name="Group.transferbranchMsg2_1" bundle="GroupUIResources"></mifos:mifoslabel>
        		          <mifos:mifoslabel name="Group.transferbranchMsg2_2" bundle="GroupUIResources"></mifos:mifoslabel>
        		             <br>
                		</span>
                 </td>
              </tr>
            </table>
            <table width="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td align="center" class="blueline">&nbsp;</td>
              </tr>
            </table>
            <br>
            <table width="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td align="center">
	                <html-el:submit property="submitBtn" styleClass="buttn" style="width:70px;" >
		                <mifos:mifoslabel name="button.submit" bundle="GroupUIResources"></mifos:mifoslabel>
	                </html-el:submit>
        	        	&nbsp; &nbsp;
    	            <html-el:button property="cancelBtn"  styleClass="cancelbuttn" style="width:70px" onclick="goToCancelPage()">
	                    <mifos:mifoslabel name="button.cancel" bundle="GroupUIResources"></mifos:mifoslabel>
                    </html-el:button>
                </td></tr>
            </table>
            <br>
          </td>
        </tr>
      </table>
 <html-el:hidden property="input" value="confirmParentTransfer"/> 
</html-el:form>
</tiles:put>
</tiles:insert>

