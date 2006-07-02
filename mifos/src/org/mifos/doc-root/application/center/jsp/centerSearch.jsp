<!--
/**

* centerSearch.jsp    version: 1.0



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

<%@taglib uri="/tags/mifos-html" prefix = "mifos"%>
<%@taglib uri="http://struts.apache.org/tags-html-el" prefix="html-el"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://struts.apache.org/tags-bean-el" prefix="bean-el"%>


<script language="javascript">
 
  function goToCancelPage(){
	centerActionForm.action="centerAction.do?method=cancel";
	centerActionForm.submit();
  }
  
</script>

<c:choose>
	<c:when test="${sessionScope.centerSearchInput.groupInput  eq 'CreateNewGroup'}">
		<tiles:insert definition=".withoutmenu">
			<tiles:put name="body" value="/pages/application/center/jsp/centerSearchCreateGroup.jsp"/>
		</tiles:insert>
	</c:when>
	<c:otherwise>
		<tiles:insert definition=".clientsacclayoutsearchmenu">
			<tiles:put name="body" value="/pages/application/center/jsp/centerSearchTransferGroup.jsp"/>
		</tiles:insert>
	</c:otherwise>
</c:choose> 
