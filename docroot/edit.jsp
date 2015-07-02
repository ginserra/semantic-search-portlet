<%
/**
 * Copyright (c) 2000-2011 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
%>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<%//
  // Application peference Form
  //
  // This form defines values for the GirdEngine interaction
  // These parameters are:
  //	o 	bdiiHost - Hostname of the VO' top BDII
  //	o	pxServerHost - Hostname of the Proxy Robot server
  // 	o	pxRobotId - Proxy Robot Identifier
  //	o	RobotVO - Proxy Robot Virtual Organization
  // 	o	pxRobotRole - Proxy Robot Role
  //	o	pxUserProxy - A complete path to an user proxy
  //	o	pxRobotRenewalFlag - Proxy Robot renewal flag;
  //	 	(When specified it overrides the use of robot proxy) 
%>

<jsp:useBean id="prefURL" class="java.lang.String" scope="request"/>
<jsp:useBean id="pref_logLevel" class="java.lang.String" scope="request"/>
<jsp:useBean id="pref_bdiiHost" class="java.lang.String" scope="request"/>
<jsp:useBean id="pref_wmsHost" class="java.lang.String" scope="request"/>
<jsp:useBean id="pref_pxServerHost" class="java.lang.String" scope="request"/>
<jsp:useBean id="pref_pxServerPort" class="java.lang.String" scope="request"/>
<jsp:useBean id="pref_pxServerSecure" class="java.lang.String" scope="request"/>
<jsp:useBean id="pref_pxRobotId" class="java.lang.String" scope="request"/>
<jsp:useBean id="pref_pxRobotVO" class="java.lang.String" scope="request"/>
<jsp:useBean id="pref_pxRobotRole" class="java.lang.String" scope="request"/>
<jsp:useBean id="pref_pxRobotRenewalFlag" class="java.lang.String" scope="request"/>	
<jsp:useBean id="pref_pxUserProxy" class="java.lang.String" scope="request"/>
<jsp:useBean id="pref_sciGwyAppId" class="java.lang.String" scope="request"/>
<jsp:useBean id="pref_jobRequirements" class="java.lang.String" scope="request"/>
<jsp:useBean id="pref_pilotScript" class="java.lang.String" scope="request"/>

<portlet:defineObjects />

<table>
<tr>
<td align="left" valign="top">
<img align="left" style="padding:10px 10px;" src="<%=renderRequest.getContextPath()%>/images/AppLogo.png" width="80%"/>
</td>
<td>
<p><h4>${CLASS_NAME} preferences</h4>
Please fill the following form to setup portlet configurations then press <b>'Confirm'</b> button to setup specified values.<br>
Requested inputs are:
<ul>
  <li><b>Log Level</b> - Set the favorite log level: (trace,debug,info,warn,error,fatal)</li>
  <li><b>BDII Host</b> - Hostname of the VO' top BDII</li>
  <li><b>Proxy Server</b> - Hostname of the Proxy Robot server</li>
  <li><b>Proxy Server port</b> - Port of the Proxy Robot server</li>
  <li><b>Proxy Secure connection</b> - Set 'true' for a secure connection</li>
  <li><b>RobotId</b> - Proxy Robot Identifier</li>
  <li><b>RobotVO</b> - Proxy Robot Virtual Organization</li>
  <li><b>RobotRole</b> - Proxy Robot Role</li>
  <li><b>UserProxy</b> - A complete path to an user proxy</li>
  <li><b>RobotRenewal</b> - Proxy Robot renewal flag<br>(When specified it overrides the use of robot proxy)</li>
</ul>
Pressing the <b>'Cancel'</b> No changes will be done on current preference<br>
Pressing the <b>'Reset'</b> Button all input fields will be initialized.
<br>
</td>
<tr>
</table>
<%
// Below the edit submission web form 
%>
<table>
<form id="<portlet:namespace />Preferences" action="<%=prefURL %>" method="post"> 
<tr>
  <td><b>Log Level</b></td>
  <td><input type="text" style="width: 320px; padding: 2px" name="pref_logLevel" id="logLevel" value="<%=pref_logLevel %>"></td>
</tr>
<tr>
  <td><b>BDII Host </b></td>
  <td><input type="text" style="width: 320px; padding: 2px" name="pref_bdiiHost" id="bdiiHost" value="<%=pref_bdiiHost %>"></td>
</tr>
<tr>
  <td><b>WMS Host </b></td>
  <td><input type="text" style="width: 320px; padding: 2px" name="pref_wmsHost" id="wmsHost" value="<%=pref_wmsHost %>"></td>
</tr>
<tr>
  <td><b>Proxy Robot host server </b></td>
  <td><input type="text" style="width: 320px; padding: 2px" name="pref_pxServerHost" id="pxServerHost" value="<%=pref_pxServerHost %>"></td>
</tr>
<tr>
  <td><b>Proxy Robot host port </b></td>
  <td><input type="text" style="width: 320px; padding: 2px" name="pref_pxServerPort" id="pxServerPort" value="<%=pref_pxServerPort %>"></td>
</tr>
<tr>
  <td><b>Proxy Robot secure connection </b></td>
  <td><input type="text" style="width: 320px; padding: 2px" name="pref_pxServerSecure" id="pxServerSecure" value="<%=pref_pxServerSecure %>"></td>
</tr>

<tr>
  <td><b>Proxy Robot Identifier </b></td>
  <td><input type="text" style="width: 320px; padding: 2px" name="pref_pxRobotId" id="pxRobotId" value="<%=pref_pxRobotId %>"></td>
</tr>
<tr>
  <td><b>Proxy Robot Virtual Organization </b></td>
  <td><input type="text" style="width: 320px; padding: 2px" name="pref_pxRobotVO" id="pxRobotVO" value="<%=pref_pxRobotVO %>"></td>
</tr>
<tr>
  <td><b>Proxy Robot VO Role </b></td>
  <td><input type="text" style="width: 320px; padding: 2px" name="pref_pxRobotRole" id="pxRobotRole" value="<%=pref_pxRobotRole %>"></td>
</tr>
<tr>
  <td><b>Proxy Robot Renewal Flag </b></td>
  <td><input type="text" style="width: 320px; padding: 2px" name="pref_pxRobotRenewalFlag" id="pxRobotRenewalFlag" value="<%=pref_pxRobotRenewalFlag %>"></td>
</tr>
<tr>
  <td>Use the Local Proxy </td>
  <td><input type="text" style="width: 320px; padding: 2px" name="pref_pxUserProxy" id="pxUserProxy" value="<%=pref_pxUserProxy %>"></td>
</tr>
<tr>
  <td>User TrackingDB Application id </td>
  <td><input type="text" style="width: 320px; padding: 2px" name="pref_sciGwyAppId" id="sciGwyAppId" value="<%=pref_sciGwyAppId %>"></td>
</tr>
<tr>
  <td>Application job requirements </td>
  <td><textarea style="width: 320px; padding: 2px" rows="4" cols="80%" name="pref_jobRequirements" id="jobRequirements" ><%=pref_jobRequirements %></textarea></td>
</tr>
<tr>
  <td>Application pilot job </td>
  <td><textarea style="width: 320px; padding: 2px" rows="10" cols="80%" name="pref_pilotScript" id="jobPilotScript" ><%=pref_pilotScript %></textarea></td>
</tr>
<tr>
  <td><form id="<portlet:namespace />Preferences" action="<%=prefURL %>" method="post">
      <input type="submit" id="setPreferences" value="Set preferences">
  	  </form>	
  </td>
  <td><form action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_INPUT"/></portlet:actionURL>" method="post">
      <input type="submit" value="Cancel">
      </form>
  </td>
  <td><input type="reset" value="Reset" onClick="resetForm()"></td>
</tr>
</form>        
</table>

<%
// Below the javascript functions used by the edit web form 
%>
<script language="javascript">
// This function is responsible to enable all textareas
// when the user press the 'reset' form button
function resetForm() {
	// Get components
        var logLevel=document.getElementById('logLevel');
	var bdiiHost=document.getElementById('bdiiHost');
	var wmsHost=document.getElementById('wmsHost');
	var pxServerHost=document.getElementById('pxServerHost');
        var pxServerPort=document.getElementById('pxServerPort');
        var pxServerSecure=document.getElementById('pxServerSecure');
	var pxRobotId=document.getElementById('pxRobotId');
	var pxRobotVO=document.getElementById('pxRobotVO');
	var pref_pxRobotRole=document.getElementById('pxRobotRole');
	var pxRobotRenewalFlag=document.getElementById('pxRobotRenewalFlag');
	var pxUserProxy=document.getElementById('pxUserProxy');
        var sciGwyAppId=document.getElementById('sciGwyAppId');
        var jobRequirements=document.getElementById('jobRequirements');
        var jobPilotScript=document.getElementById('jobPilotScript');
	                
	// Assign last preference values
        logLevel.value="<%=pref_logLevel%>";
	bdiiHost.value="<%=pref_bdiiHost%>";
	wmsHost.value="<%=pref_wmsHost%>";
	pxServerHost.value="<%=pref_pxServerHost%>";
        pxServerPort.value="<%=pref_pxServerPort%>";
        pxServerSecure.value="<%=pref_pxServerSecure%>";
	pxRobotId.value="<%=pref_pxRobotId%>";
	pxRobotVO.value="<%=pref_pxRobotVO%>";
	pref_pxRobotRole.value="<%=pref_pxRobotRole%>";
	pxRobotRenewalFlag.value="<%=pref_pxRobotRenewalFlag%>";
	pxUserProxy.value="<%=pref_pxUserProxy%>";
        sciGwyAppId.value="<%=pref_sciGwyAppId%>";
        jobRequirements.value="<%=pref_jobRequirements%>";
}       jobPilotScript.value="<%=pref_pilotScript%>";
</script>

		
