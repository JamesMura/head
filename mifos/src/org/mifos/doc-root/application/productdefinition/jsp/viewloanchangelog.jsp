<!-- 

/**

 * viewloanchangelog.jsp    version: 1.0

 

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

<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/tags/mifos-html" prefix="mifos"%>
<%@taglib uri="http://struts.apache.org/tags-html-el" prefix="html-el"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="/mifos/customtags" prefix="mifoscustom" %>
<%@ taglib uri="/userlocaledate" prefix="userdatefn"%>

<tiles:insert definition=".view">
 <tiles:put name="body" type="string">

	<script>
			function fnSearch(form) {
				form.method.value="search";
				form.action="loanprdaction.do";
				form.submit();
			}
			function fnGet() {
				loanprdactionform.method.value="get";
				loanprdactionform.action="loanprdaction.do";
				loanprdactionform.submit();
			}
			function fnCancel() {
				loanprdactionform.method.value="cancel";
				loanprdactionform.input.value="admin";
				loanprdactionform.action="loanprdaction.do";
				loanprdactionform.submit();
			}
		</script>
		<html-el:form action="/loanprdaction">

<table width="95%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="bluetablehead05"><span class="fontnormal8pt"> <html-el:link
						href="javascript:fnCancel()">
						<mifos:mifoslabel name="product.admin"
							bundle="ProductDefUIResources" />
					</html-el:link> / <html-el:link
						href="javascript:fnSearch(loanprdactionform)">
						<mifos:mifoslabel name="product.savingsview" bundle="ProductDefUIResources" />
					<mifos:mifoslabel name="${ConfigurationConstants.LOAN}" bundle="ProductDefUIResources" />
					<mifos:mifoslabel name="product.products" bundle="ProductDefUIResources" />
					</html-el:link> / <html-el:link href="javascript:fnGet()">
						<c:out value="${requestScope.Context.valueObject.prdOfferingName}" />
					</html-el:link></span></td>
				</tr>
			</table>
      <table width="95%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="70%" height="24" align="left" valign="top" class="paddingL15T15"><table width="96%" border="0" cellpadding="3" cellspacing="0">
              <tr>
                <td class="headingorange"><span class="heading">
<c:out value="${requestScope.Context.valueObject.prdOfferingName}" />
                    - </span>
<mifos:mifoslabel name="client.changelog" bundle="ClientUIResources"/>
                </td>
              </tr>
              <tr>
                <td class="fontnormal"><br>
<mifos:mifoslabel name="client.reccredate" bundle="ClientUIResources"/>: 
<c:out value="${userdatefn:getUserLocaleDate(sessionScope.UserContext.pereferedLocale,requestScope.Context.valueObject.createdDate)}" />
</td>
              </tr>
            </table>
            <br>            
<mifoscustom:mifostabletag moduleName="customer/client" scope="request" source="LoanChangeLogList" xmlFileName="ClientChangeLog.xml" passLocale="true"/>
<html-el:hidden property="method" value="preview" /> 
<html-el:hidden property="input" value="details" />
<html-el:hidden property="prdOfferingId" value="${requestScope.Context.valueObject.prdOfferingId}" />
<html-el:hidden property="searchNode(search_name)" value="LoanProducts" />
            <table width="96%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td align="center">
                 <html-el:button property="cancel"
				 	styleClass="buttn" style="width:140px;"
					onclick="javascript:fnGet()">
				<mifos:mifoslabel name="product.back" bundle="ProductDefUIResources"/>
                </html-el:button>
                </td>
              </tr>
            </table></td>
        </tr>
      </table>  
		</html-el:form>
	</tiles:put>
</tiles:insert>
