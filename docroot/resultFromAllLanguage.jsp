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
<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.Math"%>
<%@page import="it.infn.ct.ApiVirtuosoForGraph"%>




<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Arrays"%>


<%@page import="it.infn.ct.SemanticQueryMoreInfo"%>
<%@page import="it.infn.ct.SemanticQuery"%>


<jsp:useBean id="keyword" class="java.lang.String" scope="request"/>
<jsp:useBean id="keyword2" class="java.lang.String" scope="request"/>
<jsp:useBean id="textHidden" class="java.lang.String" scope="request"/>
<jsp:useBean id="textHidden2" class="java.lang.String" scope="request"/>





<%@page contentType="text/html" pageEncoding="UTF-8"%>



<portlet:defineObjects />
<%//
  // Application Submission page
  //
  //
  // The portlet code assigns the jobIdentifier as input parameter for this jsp file
  //
%>


<%
// Below the submission web form
//
// It only have a button that will show the input form again for a new job submission
%>



<html>
    <head>




         <style>

            #nav, #nav ul {
                padding: 0;
                margin: 0;
                list-style: none;

            }

            #nav a {
                display: block;
                width: 10em;
            }

            #nav li {
                float: left;
                width: 10em;
                cursor: pointer;
            }

            #nav li ul {
                position: absolute;
                width: 10em;
                left: -999em;
            }

            #nav li:hover ul {
                left: auto;

            }
            #nav li a:hover{
                left:inherit;
                background-color:#EEE;
                display:block;

            }
            #examplebutton{
                cursor: pointer;
            }
        </style>

    </head> 



    <body>

        <%
        
        
        
        String searched_word = renderRequest.getParameter("searched_word");
        String selected_page = renderRequest.getParameter("selected_page");
        String moreInfo = renderRequest.getParameter("moreInfo");
        System.out.println("MORE INFO RESULT-->"+moreInfo+ "SELECTED-PAGE-->"+selected_page);
        //String records= renderRequest.getParameter("numRecords");
       // System.out.println("JSP--->cercata "+searched_word+" con "+records+" pagina selezionata "+selected_page);
      //  int numRecords=Integer.parseInt(records);
        //System.out.println("1-->");
        
        
        
       String []sArray=(String[])request.getParameterValues("arrayVirtuosoResource");
        //System.out.println("2-->");
        ArrayList arrayVirtuosoResource =new ArrayList(Arrays.asList(sArray)); 
        //Collections.addAll(arrayVirtuosoResource, sArray); 
        System.out.println("SIZE-->"+arrayVirtuosoResource.size());
        %>

        <br>
        <div id="divContainer">
            <center>
                <div class="menu">

                    <div class="root">

                       <!-- <div class="selected">Select a language:&nbsp; <b id="language"> All&nbsp;</b>   <img  src="<%=renderRequest.getContextPath()%>/images/down.gif" border="1"/></div>

                        <div class="sub">

                            <ul>
                                <form id="form_all_language" action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_INPUT"/></portlet:actionURL>" method="post">
                                    <li><center><input id="idLanguageAll" type="text" hidden="true" name="nameLanguage" value="All"><a id="All" onclick="submitAllLanguage();">ALL</a></center></li>    
                                </form>                            
                            </ul>

                            <form id="form_choose_language" action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_SELECT_LANGUAGE"/></portlet:actionURL>" method="post">
                                <ul>
                                    <li><input id="idLanguageBashkir" type="text" hidden="true" name="nameLanguage" value="Bashkir"><a id="Bashkir" onclick="submitLanguage(this.id);">Bashkir</a></li>
                                    <li><input id="idLanguageBasque" type="text" hidden="true" name="nameLanguage" value="Basque"><a id="Basque" onclick="submitLanguage(this.id);">Basque</a></li>
                                    <li><input id="idLanguageCatalan" type="text" hidden="true" name="nameLanguage" value="Catalan"><a id="Catalan"  onclick="submitLanguage(this.id);">Catalan</a></li>
                                    <li><input id="idLanguageChinese" type="text" hidden="true" name="nameLanguage" value="Chinese"><a  id="Chinese" onclick="submitLanguage(this.id);">Chinese</a></li>
                                    <li><input id="idLanguageCzech" type="text" hidden="true" name="nameLanguage" value="Czech"><a  id="Czech" onclick="submitLanguage(this.id);">Czech</a></li>

                                </ul>
                                <ul>
                                    <li><input id="idLanguageDanish" type="text" hidden="true" name="nameLanguage" value="Danish"><a id="Danish" onclick="submitLanguage(this.id);">Danish</a></li>
                                    <li><input id="idLanguageDutch" type="text" hidden="true" name="nameLanguage" value="Dutch"><a id="Dutch" onclick="submitLanguage(this.id);">Dutch</a></li>
                                    <li><input id="idLanguageEnglish" type="text" hidden="true" name="nameLanguage" value="English"><a id="English"  onclick="submitLanguage(this.id);">English</a></li>
                                    <li><input id="idLanguageFinnish" type="text" hidden="true" name="nameLanguage" value="Finnish"><a  id="Finnish" onclick="submitLanguage(this.id);">Finnish</a></li>
                                    <li><input id="idLanguageFrench" type="text" hidden="true" name="nameLanguage" value="French"><a  id="French" onclick="submitLanguage(this.id);">French</a></li>
                                </ul>

                                <ul>
                                    <li><input id="idLanguageGerman" type="text" hidden="true" name="nameLanguage" value="German"><a id="German" onclick="submitLanguage(this.id);">German</a></li>
                                    <li><input id="idLanguageGreek" type="text" hidden="true" name="nameLanguage" value="Greek"><a id="Greek" onclick="submitLanguage(this.id);">Greek</a></li>
                                    <li><input id="idLanguageHungarian" type="text" hidden="true" name="nameLanguage" value="Hungarian"><a id="Hungarian"  onclick="submitLanguage(this.id);">Hungarian</a></li>
                                    <li><input id="idLanguageIndonesian" type="text" hidden="true" name="nameLanguage" value="Indonesian"><a  id="Indonesian" onclick="submitLanguage(this.id);">Indonesian</a></li>
                                    <li><input id="idLanguageIrish" type="text" hidden="true" name="nameLanguage" value="Irish"><a  id="Irish" onclick="submitLanguage(this.id);">Irish</a></li>


                                </ul>
                                <ul>
                                    <li><input id="idLanguageItalian" type="text" hidden="true" name="nameLanguage" value="Italian"><a  id="Italian" onclick="submitLanguage(this.id);">Italian</a></li>
                                    <li><input id="idLanguageJapanese" type="text" hidden="true" name="nameLanguage" value="Japanese"><a id="Japanese" onclick="submitLanguage(this.id);">Japanese</a></li>
                                    <li><input id="idLanguageLatin" type="text" hidden="true" name="nameLanguage" value="Latin"><a id="Latin" onclick="submitLanguage(this.id);">Latin</a></li>
                                    <li><input id="idLanguageNorwegian" type="text" hidden="true" name="nameLanguage" value="Norwegian"><a id="Norwegian"  onclick="submitLanguage(this.id);">Norwegian</a></li>
                                    <li><input id="idLanguagePortuguese" type="text" hidden="true" name="nameLanguage" value="Portuguese"><a  id="Portuguese" onclick="submitLanguage(this.id);">Portuguese</a></li>

                                </ul>
                                <ul>
                                    <li><input id="idLanguageRussian" type="text" hidden="true" name="nameLanguage" value="Russian"><a  id="Russian" onclick="submitLanguage(this.id);">Russian</a></li>
                                    <li><input id="idLanguageSerbo-Croatian" type="text" hidden="true" name="nameLanguage" value="Serbo-Croatian"><a id="Serbo-Croatian" onclick="submitLanguage(this.id);">Serbo-Croatian</a></li>
                                    <li><input id="idLanguageSlovenian" type="text" hidden="true" name="nameLanguage" value="Slovenian"><a id="Slovenian" onclick="submitLanguage(this.id);">Slovenian</a></li>
                                    <li><input id="idLanguageSpanish" type="text" hidden="true" name="nameLanguage" value="Spanish"><a id="Spanish" onclick="submitLanguage(this.id);">Spanish</a></li>
                                    <li><input id="idLanguageSwedish" type="text" hidden="true" name="nameLanguage" value="Swedish"><a id="Swedish"  onclick="submitLanguage(this.id);">Swedish</a></li>

                                </ul>

                                <input hidden="true" type="text" id="selLanguageId" name="selLanguage"/>
                            </form>
                        </div>-->
                    </div>

                </div>
                <div id="divSearchBar"> 
                    <form id="search_form" action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_SEMANTIC_SEARCH_ALL_LANGUAGE"/></portlet:actionURL>" method="post">         
                        <table>
                            <tr>
                                <td align="center" style=" padding: 5px;" >
                                    <img href="http://klios.ct.infn.it" src="<%=renderRequest.getContextPath()%>/images/logo_klios.png" />
                                </td>
                                <td>
                                    <input id="examplebutton" class="rounded" type="button" value="Examples" style="text-align: right;font-size: 12px;"  />
                                  
                                </td>
                                <!-- <td align="right" style="padding-right: 10px; width: 80px;">
                                    <ul id="nav" class="rounded">
                                        <li style="width: 80px;"><input id="examplebutton" class="rounded" type="button" value="Examples" style="text-align: right;font-size: 12px;" />
                                            <ul id="provaId" class="rounded" style="border: solid; border-color: grey;  background:white; text-align: left; padding-left: 5px;margin-left:10px; ">
                                               <font  align="left" style="font-color:grey;font-size: 12px;"> SEARCH EXAMPLES</font>
                                               <hr align="left" style="padding-left:0px;">
                                                <li  style="padding-top:10px;" ><input id="idExampleAuthor" type="text" hidden="true" name="example" value="author:Thomas_Pete"><a id="Author" align="left" value="author:Thomas_Pete" onclick="getExampleValue(this.id);">author:Thomas_Pete</a></li>
                                                <li  style="padding-top:10px; "><input  id="idExampleSubject" type="text" hidden="true" name="example" value="subject:policy"><a id="Subject" align="left" value="subject:policy" onclick="getExampleValue(this.id);">subject:policy</a></li>
                                                <li  style="padding-top:10px; "><input  id="idExampleType" type="text" hidden="true" name="example" value="type:thesis"><a id="Type" align="left" value="type:thesis" onclick="getExampleValue(this.id);">type:thesis</a></li>
                                                <li  style="padding-top:10px; "><input id="idExampleFormat" type="text" hidden="true" name="example" value="format:image/jpeg"><a id="Format" align="left" value="format:image/jpeg" onclick="getExampleValue(this.id);">format:image/jpeg</a></li>
                                                <li  style="padding-top:10px; padding-bottom: 10px;"><input id="idExamplePublisher" type="text" hidden="true" name="example" value="publisher:elsevier"><a id="Publisher" align="left" value="publisher:elsevier" onclick="getExampleValue(this.id);">publisher:elsevier</a></li>  
                                                
                                                                                                                                                                                                        
                                            </ul>
                                        </li>




                                    </ul>
                                </td>-->

                                <td align="center" style=" padding: 10px;">

                                    <input class="rounded" id="id_search_word"  name="search_word" type="text" style="width:600px;height: 20px;font-size: 12px" value="<%=searched_word%>" />



                                </td>
                                <td align="center" style=" padding: 10px;">
                                    <!-- <input hidden="true" id="id_graph"  name="graph" type="text" value="http://RepositoryOntology_v2"/>-->

                                    <input id="buttonSearchImg "  type="button" onclick="submitSearch(); " style="text-align: right;font-size: 12px;" value="Search"/>
                                </td>
                            </tr>
                            <tr>

                                <td colspan="4" align="center" style=" padding-top:0px; padding-bottom: 14px">Enter a keyword </td>

                            </tr>

                        </table>

                        <div id="dialogExamples" title="Examples" hidden="true" >


                            <table id="tableExample">
                                <tr>
                                    <th style="width: 40px;">
                                        ENGLISH
                                    </th>
                                    <th>
                                        ARABIC
                                    </th>
                                    <th>
                                        CHINESE
                                    </th>
                                    <th>
                                        RUSSIAN
                                    </th>
                                </tr>
                                <tr>
                                    <td id="firstColumn">
                                        <input id="idExampleAuthor" type="text" hidden="true" name="example" value="author:Smith G."><a id="Author"  value="author:Smith G." onclick="getExampleValue(this.id);" >author:Smith G.</a>
                                    </td>
                                    <td>
                                       <input  id="idExampleAuthorA" type="text" hidden="true" name="example" value="author:الحامد"><a id="AuthorA"  value="author:الحامد" onclick="getExampleValue(this.id);">author:الحامد</a>
                                    </td>
                                    <td>
                                         <input  id="idExampleAuthorC" type="text" hidden="true" name="example" value="author:邓祥征"><a id="AuthorC"  value="author:邓祥征" onclick="getExampleValue(this.id);">author:邓祥征</a>
                                        
                                    </td>
                                    <td>
                                        <input  id="idExampleAuthorR" type="text" hidden="true" name="example" value="author:ИвановичСкупский"><a id="AuthorR"  value="author:ИвановичСкупский" onclick="getExampleValue(this.id);">author:ИвановичСкупский</a>
                                    </td>


                                </tr>
                                <tr>
                                    <td id="firstColumn">
                                        <input id="idExampleSubject" type="text" hidden="true" name="example" value="subject:policy"><a id="Subject"  value="subject:policy" onclick="getExampleValue(this.id);" >subject:policy</a>
                                    </td>
                                    <td>
                                        <input  id="idExampleSubjectA" type="text" hidden="true" name="example" value="subject:الإدارة التربوية"><a id=SubjectA"  value="subject:الإدارة التربوية" onclick="getExampleValue(this.id);">subject:الإدارة التربوية</a> <!--educativo-->
                                    </td>


                                    <td>
                                        <input  id="idExampleSubjectC" type="text" hidden="true" name="example" value="subject:沙堆鄉"><a id="SubjectC"  value="subject:沙堆鄉" onclick="getExampleValue(this.id);">subject:台灣文學</a> <!--Letteratura di Taiwan-->
                                    </td>
                                    <td>
                                        <input  id="idExampleSubjectR" type="text" hidden="true" name="example" value="subject:Христианство"><a id="SubjectR"  value="subject:Христианство" onclick="getExampleValue(this.id);">subject:Христианство</a> <!--cristianesimo-->
                                    </td>
                                </tr>
                                <tr>
                                    <td id="firstColumn">
                                        <input id="idExampleType" type="text" hidden="true" name="example" value="type:thesis"><a id="Type"  value="type:thesis" onclick="getExampleValue(this.id);" >type:thesis</a>
                                    </td>
                                    <td>
                                        <input  id="idExampleTypeA" type="text" hidden="true" name="example" value="type:مصادر ومراجع"><a id="TypeA"  value="type:مصادر ومراجع" onclick="getExampleValue(this.id);">type:مصادر ومراجع</a> <!--Fonti e riferimenti-->
                                    </td>


                                    <td>
                                        <input  id="idExampleTypeC" type="text" hidden="true" name="example" value="type:期刊论文"><a id="TypeC"  value="type:期刊论文" onclick="getExampleValue(this.id);">type:期刊论文</a> <!--documenti-->
                                    </td>
                                    <td>
                                        <input  id="idExampleTypeR" type="text" hidden="true" name="example" value="type:Монография"><a id="TypeR"  value="type:Монография" onclick="getExampleValue(this.id);">type:Монография</a> <!--Мonografia-->
                                    </td>
                                </tr>
                                <tr>
                                    <td id="firstColumn">
                                     
                                       <input id="idExampleFormat" type="text" hidden="true" name="example" value="format:image/jpeg"><a id="Format" align="left" value="format:image/jpeg" onclick="getExampleValue(this.id);">format:image/jpeg</a>
                                    </td>
                                    <td>
                                           <input id="idExamplePublisherA" type="text" hidden="true" name="example" value="publisher:مجلة جامعة الملك سعود"><a id="PublisherA" align="left" value="publisher:مجلة جامعة الملك سعود" onclick="getExampleValue(this.id);">publisher:مجلة جامعة الملك سعود</a></li>  <!--King Saud University Journal-->  
                                       <!-- <input id="idExampleFormatA" type="text" hidden="true" name="example" value="format:image/jpeg"><a id="FormatA" align="left" value="format:image/jpeg" onclick="getExampleValue(this.id);">format:image/jpeg</a>-->
                                    </td>

                                    <td>
                                         <input id="idExamplePublisherC" type="text" hidden="true" name="example" value="publisher:信州大学人文学部"><a id="PublisherC" align="left" value="publisher:信州大学人文学部" onclick="getExampleValue(this.id);">publisher:信州大学人文学部</a></li>  <!--Facoltà di lettere e filosofia-->
                                        <!--<input id="idExampleFormatC" type="text" hidden="true" name="example" value="format:image/jpeg"><a id="FormatC" align="left" value="format:image/jpeg" onclick="getExampleValue(this.id);">format:image/jpeg</a>-->
                                    </td>
                                    <td>
                                        <input id="idExampleFormatR" type="text" hidden="true" name="example" value="format:электронная копия"><a id="FormatR" align="left" value="format:электронная копия" onclick="getExampleValue(this.id);">format:электронная копия</a></li> <!--Copia elettronica-->
                                    </td>


                                </tr>
                                <tr>
                                    <td id="firstColumn">
                                        <input id="idExamplePublisher" type="text" hidden="true" name="example" value="publisher:elsevier"><a id="Publisher" align="left" value="publisher:elsevier" onclick="getExampleValue(this.id);">publisher:elsevier</a></li>  
                                    </td>
                                    <td>
                                       <!-- <input id="idExamplePublisherA" type="text" hidden="true" name="example" value="publisher:مجلة جامعة الملك سعود"><a id="PublisherA" align="left" value="publisher:مجلة جامعة الملك سعود" onclick="getExampleValue(this.id);">publisher:مجلة جامعة الملك سعود</a></li>  King Saud University Journal-->
                                    </td>
                                    <td>
                                       <!-- <input id="idExamplePublisherC" type="text" hidden="true" name="example" value="publisher:信州大学人文学部"><a id="PublisherC" align="left" value="publisher:信州大学人文学部" onclick="getExampleValue(this.id);">publisher:信州大学人文学部</a></li>  Facoltà di lettere e filosofia-->
                                    </td>
                                    <td>
                                        <input id="idExamplePublisherR" type="text" hidden="true" name="example" value="publisher:Тбилиси"><a id="PublisherR" align="left" value="publisher:Тбилиси" onclick="getExampleValue(this.id);">publisher:Тбилиси</a></li>  <!--Tbilisi-->
                                    </td>

                                </tr>
                            </table>

                        </div>
                        <input  hidden="true" name="numberOfPage" id="numberOfPage" value="<%=selected_page%>"/>
                        <input  hidden="true" name="moreInfo" id="idMoreInfo" value="<%=moreInfo%>" />

                    </form>
                </div>
            </center>

            <div id="divResultSearch" >


                <div id="tabMenuResult" class="tabber">


                    <%
                     // if(arrayVirtuosoResource.size()>0){
                                      
                    %>


                    <div  class="tabbertab" title="Results" >

                        <%  
                         //APRIAMO LA CONNESSIONE
                          //conn= SemanticQuery.ConnectionToVirtuoso();
                          //int numRecords=SemanticQuery.getNumRecords(searched_word);
                          /*double numPage=Math.ceil((double)numRecords/20.0);
                          int numPageInt=(int) numPage;
                          int selPage= Integer.parseInt(selected_page);
                          int limitMaxPage=0;
                          int limitMinPage=0;
                          int fromPage=0;
                          int toPage=0;*/
                        %>

                        <div class="showpageArea">
                            <%  if(arrayVirtuosoResource.size()>0)
                              {%>

                            <span>Records found. Displaying  1 to <%=arrayVirtuosoResource.size()%></span>
                            <%} else { %>
                            <span>Records not found for "<%=searched_word%>".</span>
                            <%}%>

                        </div>




                        <table>

                            <%    int countId=0;
                            ArrayList arrayGlobal=new ArrayList();
                            
                            
                            if(arrayVirtuosoResource.size()>0)
                              {
                                       for(int i=0;i<arrayVirtuosoResource.size();i++){
                                          

                                      ArrayList arraySigleResource= new ArrayList();
                                      String resource=arrayVirtuosoResource.get(i).toString();
                                      arraySigleResource.add(resource);
                                     System.out.println(" Sono dentro semantic search la risorsa e"+resource);


                                      ArrayList arrayTitles=SemanticQuery.getListNotDuplicate(SemanticQuery.getTitle(resource));

                                      arraySigleResource.add(arrayTitles);

                                      ArrayList arrayIdentifiers=SemanticQuery.getListNotDuplicate(SemanticQuery.getIdentifiers(resource));

                                      arraySigleResource.add(arrayIdentifiers);
                                      ArrayList id_string=new ArrayList();
                                      ArrayList id_http=new ArrayList();

                                      for(int idf=0; idf<arrayIdentifiers.size();idf++){
                                         if(arrayIdentifiers.get(idf).toString().length()>4 && arrayIdentifiers.get(idf).toString().substring(0,4).equals("http"))
                                             id_http.add(arrayIdentifiers.get(idf).toString());
                                         else
                                             id_string.add(arrayIdentifiers.get(idf).toString());
                                      }


                            %>

                            <tr>
                                <td>
                                    <table class=" resultSearch ">



                                        <tr>
                                            <% if(arrayTitles.size()>0){ %>

                                            <td>

                                                <h5 id="countResource_<%=i%>" class=" klios">Title</h5>



                                                <ul class="klios_list">
                                                    <form id="checkCitations" action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_GET_CITATIONS_GSCHOLAR"/></portlet:actionURL>" method="post">
                                                        <input id="title_GS" name="title_GS" value="" hidden="true" />
                                                        <%
                                             
                                                          for(int t=0; t<arrayTitles.size(); t++){
                                                           String title=arrayTitles.get(t).toString();
                                                        
                                                            //System.out.println("title ["+t+"]= "+title);
                                                            if(id_http.size()>0){
                                                                String link= id_http.get(0).toString(); 

                                                        %>
                                                        <li><a href="<%= link %>" class="title" target="_blank" title="<%= link%>"><%= title %> </a> 
                                                           <!-- <img id="counterResoureGS_<%=countId%>" style="cursor: pointer;width:20px;height: 20px;" src="<%=renderRequest.getContextPath()%>/images/gscholar_icon.png" onclick="CheckCitationsImage(<%=countId%>,<%=t%>)" />
                                                            
                                                            <a href="http://localhost:8080/testlodlive/?<%=resource%>" target="_blank"><img id="<%=resource%>" style="cursor: pointer;width:80px;height: 25px;" src="<%=renderRequest.getContextPath()%>/images/lodliveLogo200px.jpg" /></a></li>-->
                                                            [<a id="counterResoureGS_<%=countId%>" href="#" style="cursor: pointer;"  onclick="CheckCitationsImage(<%=countId%>,<%=t%>)">Citations</a>]
                                                            
                                                            [<a href="http://www.chain-project.eu/LodLiveGraph/?<%=resource%>" target="_blank" id="<%=resource%>" style="cursor: pointer;">Linked Data</a>]</li>
                                                        <input id="titleResourceVirtuoso<%=countId+"--"+t%>" name="titleResourceVirtuoso" value="<%= title %>" hidden="true" />



                                                        <%
                                                        }else{%>
                                                        <li> <input id="titleResourceVirtuoso<%=countId+"--"+t%>" name="titleResourceVirtuoso" value="<%= title %>" hidden="true" /><i> <%= title %></i> 
                                                            [<a id="counterResoureGS_<%=countId%>" href="#" style="cursor: pointer;" onclick="CheckCitationsImage(<%=countId%>,<%=t%>)">Citations</a>]
                                                            
                                                             [<a href="http://www.chain-project.eu/LodLiveGraph/?<%=resource%>" target="_blank" id="<%=resource%>" style="cursor: pointer;">Linked Data</a>]</li>
                                                            <!--<img id="counterResoureGS_<%=countId%>" style="cursor: pointer; width:20px;height: 20px;" src="<%=renderRequest.getContextPath()%>/images/gscholar_icon.png" onclick="CheckCitationsImage(<%=countId%>,<%=t%>)" />
                                                             <a href="http://localhost:8080/testlodlive/?<%=resource%>" target="_blank"> <img id="<%=resource%>" style="cursor: pointer;width:80px;height: 25px;" src="<%=renderRequest.getContextPath()%>/images/lodliveLogo200px.jpg" /></a></li>-->
                                                            <%
                                                                }
                                                                }
                                                                }

                                                            %>

                                                    </form>    
                                                </ul>
                                            </td>
                                        </tr>
                                        <tr>

                                            <%
                                             ArrayList arrayAuthors=SemanticQuery.getListNotDuplicate(SemanticQuery.getAuthors(resource));

                                             arraySigleResource.add(arrayAuthors);
                                            // System.out.println("author size "+arrayAuthors.size());
                                                  if(arrayAuthors.size()>0){
                                            %>
                                            <td>
                                                <h5 class="klios">Author</h5>

                                                <%

                                                for(int a=0; a<arrayAuthors.size(); a++){
                                                    String author=arrayAuthors.get(a).toString();
                                                  //  System.out.println("author ["+a+"]= "+author);

                                                %>

                                                <input id="authorResourceVirtuoso<%=countId%>" name="authorResourceVirtuoso" value="<%= author %>" hidden="true" /><i> <%= author %></i>



                                                <%
                                                  }
                                                  }

                                                %>

                                            </td>
                                        </tr>
                                        <tr>

                                            <%
                                            ArrayList arrayDescriptions=SemanticQuery.getListNotDuplicate(SemanticQuery.getDescription(resource));
                                            arraySigleResource.add(arrayDescriptions);
                                           // System.out.println("description size "+arrayDescriptions.size());
                                                      if(arrayDescriptions.size()>0){
                                            %>
                                            <td>
                                                <h5 class="klios">Description</h5>


                                                <%
                                                    // for(int d=0; d<arrayDescriptions.size(); d++){

                                                         String description=arrayDescriptions.get(0).toString();
                                                         
                                                         
                                                         
                                                         
                                                        String preview_desc=""; 
                                                         
                                                         if(description.contains("<table")){
                                                             
                                                            // System.out.println("OKKKKKKKKKKKK");
                                                             preview_desc=description.substring(0,32).toString()+"...";
                                                             
                                                             //System.out.println("OKKKKKKKKKKKK--->"+preview_desc);
                                                             
                                                         }
                                                         else{
                                                           // System.out.println("description ["+0+"]= "+description);
                                                               System.out.println("ELSE");
                                                             if(description.length()>299)
                                                                             
                                                               preview_desc=description.substring(0,300).toString()+"...";
                                                                           
                                                                            
                                                                else
                                                                  preview_desc=description;

                                                            }                          
                                                                       
                                                          //  String preview_desc2=description.substring(((description.length())/2)+1,description.length()).toString();


                                                           // System.out.println("DESCRIPTION JSP meta "+preview_desc);

                                                %>

                                                <input id="descResourceVirtuoso<%=countId%>" name="descResourceVirtuoso" value="" hidden="true" /><%= preview_desc%>


                                                <%
                                                    //}
                                                   }
                                                %>


                                            </td>
                                        </tr>

                                      <!--  <tr>
                                            <td>
                                                <form id="checkCitations" action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_GET_CITATIONS_GSCHOLAR"/></portlet:actionURL>" method="post">
                                                    <br>

                                                    <input id="title_GS" name="title_GS" value="" hidden="true" />


                                                    <p id="counterResoureGS_<%=countId%>" style="cursor: pointer;color: green;" onclick="CheckCitations(this.id)">Check citations on Google Scholar</p>    
                                                </form>
                                            </td> 

                                        </tr>  -->

                                        <tr>

                                            <%
                                           // SemanticQueryMoreInfo moreInfo = new SemanticQueryMoreInfo();
                                            ArrayList arrayRepository=SemanticQuery.getRepository(resource);
                                            //arraySigleResource.add(arrayRepository);
                                           // System.out.println("repository size "+arrayRepository.size());
                                                      if(arrayRepository.size()>0){
                                            %>
                                            <td>
                                                <h5 class="klios">Repository</h5>


                                                <%
                                                    // for(int d=0; d<arrayDescriptions.size(); d++){

                                                         String nameRep=arrayRepository.get(0).toString();
                                                         String urlRep="";
                                                         if(arrayRepository.get(4).toString()!=""){
                                                            // urlRep=arrayRepository.get(4).toString();
                                                             if( arrayRepository.get(4).toString().length()>4 && arrayRepository.get(4).toString().substring(0,4).equals("http"))
                                                                 urlRep=arrayRepository.get(4).toString();
                                                             else
                                                                 urlRep="http://"+arrayRepository.get(4).toString();
                                                            
                                                           //  System.out.println("URL REP "+urlRep);
                                                             
                                                %>

                                                <a href="<%= urlRep %>" target="_blank" title="<%= urlRep%>"><u> <%= nameRep %></u> </a>

                                                <input id="nameRepository<%=countId%>" name="nameRepository" value="<%= nameRep %>" hidden="true" />
                                                <%}
                                                            
                                                  else{

                                                %>

                                                <input id="nameRepository<%=countId%>" name="nameRepository" value="<%= nameRep %>" hidden="true" /><%= nameRep%>


                                                <%
                                                    }
                                                   }
                                                %>


                                            </td>
                                        </tr>


                                        <%
                                        ArrayList arraySource=SemanticQuery.getListNotDuplicate(SemanticQuery.getSources(resource));
                                        arraySigleResource.add(arraySource);

                                        ArrayList arraySubject=SemanticQuery.getListNotDuplicate(SemanticQuery.getSubject(resource));
                                        arraySigleResource.add(arraySubject);
                                                        
                                        ArrayList arrayPublisher=SemanticQuery.getListNotDuplicate(SemanticQuery.getPublisher(resource));
                                        arraySigleResource.add(arrayPublisher);
                                      //  System.out.println("sources size "+arraySource.size());
                                           
                                            
                                        %>





                                        <tr>
                                            <td>
                                                <form id="searchDetail" action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_GET_MORE_INFO"/></portlet:actionURL>" method="post">
                                                    <input id="idResource" name="idResource" value="<%= resource %>" hidden="true" />
                                                    <input id="search_word" name="search_word" value="<%= searched_word %>" hidden="true" />
                                                    <input id="title_GS2" name="title_GS" value="" hidden="true" />


                                                    <p id="counterResoure_<%=resource%>" style="cursor: pointer;color: red;" onclick="GoDetails(this.id,<%=countId%>)">More Info</p>    
                                                </form>
                                            </td>

                                        </tr>


                                        <tr><td> <hr class="endRecordAll" noshade="noshade"></td></tr>

                                    </table>
                                </td>
                            </tr>





                            <%
                                countId++;
                                arrayGlobal.add(arraySigleResource);

                                  }
                                                                                             }
                            else
                            {
                            %>





                            <%}

                              //  System.out.println("DIMENSIONE ARRAY-GLOBAL-> "+arrayGlobal.size());

                            %>

                        </table>

                        <%  
                           int limitMax=Integer.parseInt(selected_page)*20;
                             
                        if(arrayVirtuosoResource.size()>0)
                         {%>
                        <div class="showpageArea">


                            <span  >Records found. Displaying  1 to <%=arrayVirtuosoResource.size()%>

                                <% if(arrayVirtuosoResource.size()==limitMax) {%>

                                <center><span class="showMoreResurces" id="idMoreResources"  onclick="moreResources();" >----More Resources---</span>
                                </center>
                                <%}%>
                            </span>



                        </div>
                        <% }%>





                    </div>




                    <%
                         
                    %>        




                            
                      
                            
                    <!--div menu-->
                </div>

            </div>


            <div id="dialog2" title="Information" hidden="true" >
                <center>
                    <p>Searching...</p>
                    <p>This may take some time</p>
                </center>
            </div> 


            <script>
                                
                function moreResources()
                {
                                  
                    var nvalue=parseInt(document.getElementById("numberOfPage").value);
                    document.getElementById("numberOfPage").value=nvalue+1;
                    document.getElementById("idMoreInfo").value="NO";
                                    
                    // alert("VALUE MORE----> "+document.getElementById("numberOfPage").value);
                    document.forms["search_form"].submit();
                    document.body.style.cursor = "wait";
                    showDialog();
                                    
                }
                                
                                   
                                
                                
                <% if(!selected_page.equals("1") )
                                                       {
                                    
                    System.out.println("PAGINA SELEZIONATA: "+selected_page);
                                    
                                    
                    int counter=(Integer.parseInt(selected_page) *20)-21;
                                    
                    System.out.println("COUNTER "+counter);
                                    
                                  
                %>
                    
                    var x=$("#countResource_"+<%=counter%>).position();
                                    
                                   
                                    
                                  
                    window.scrollTo(x.left,x.top);
                                    
                                  
                                
                <%  }%>
                                
                                
                    $( "#dialog2" ).dialog({ autoOpen: false });
                    $( "#dialogExamples" ).dialog({ autoOpen: false });
                    
                                
                                
                                
                                
                                
                                
                                
                                
                                
                    function showDialog()
                    {
        
                        // alert("SHOW DIALOG");
                        $("#dialog2").dialog('open');          
                         
       
                        $( "#dialog2" ).dialog({
                            dialogClass: "no-close",
                            width: 300, 
                            height:150,
                                
                            
                            resizable: false

                        });
       
            
                    }     
    
                    function GoDetails(x,countResource)
                    {
                        cursor_wait();
                        var resource=x.toString().split("counterResoure_")[1];
                        //var countResource= document.getElementById("counterResoureMoreInfoGS").value;
                    
                        //alert ("COUNT RESOURCE: "+countResource);
                        document.getElementById('idResource').value=resource;
                    
                        var myTitle=document.getElementById("titleResourceVirtuoso"+countResource+"--0").value;
                   
                        document.getElementById('title_GS2').value=myTitle;
                        //alert("OK---->"+myTitle);
                        document.forms["searchDetail"].submit();
                    } 
                
                
                    function CheckCitations(x)
                    {
                    
                        var countResource=x.toString().split("counterResoureGS_")[1];
                        //cursor_wait();
                        // var resource=x.toString().split("counterResoureGS_")[1];
                        // document.getElementById('idResource').value=resource;
                        // document.forms["searchDetail"].submit();
                        var myTitle=document.getElementById("titleResourceVirtuoso"+countResource+"--0").value;
                        //document.getElementById("control_GS").value="true";
                        document.getElementById('title_GS').value=myTitle;
                   
                        //alert("OK---->"+myTitle);
                        document.forms["checkCitations"].submit();
                    }
                
                    function CheckCitationsImage(countId,j)
                    {
                    
                    
                        var myTitle=document.getElementById("titleResourceVirtuoso"+countId+"--"+j).value; 
                    
                        // alert("OK---->"+myTitle); 
                        document.getElementById('title_GS').value=myTitle;
                   
                        document.forms["checkCitations"].submit();
                    }
    
    
                    function cursor_wait(){
                        document.body.style.cursor = "wait";
                    }

        
                    function submitLanguage(id)
                    {
                        cursor_wait();
                        var s=document.getElementById("idLanguage"+id).value;
                        var e=document.getElementById("selLanguageId").value=s;
                        document.getElementById("language").innerHTML=e;
           
                        document.forms["form_choose_language"].submit();
                        showDialog();
          
                    }
                    function submitAllLanguage(){
                        document.body.style.cursor = "wait";
            
                        document.forms["form_all_language"].submit();
      
                        //  showDialog();
   
                    } 
    
                    function submitSearch()
                    {
                        document.body.style.cursor = "wait";
         
                        // alert("PRIMA-->"+document.getElementById("numberOfPage").value);
         
                        document.getElementById("numberOfPage").value="";
                        document.getElementById("idMoreInfo").value="NO";
                        // alert("DOPO-->"+document.getElementById("numberOfPage").value);
                        document.forms["search_form"].submit();
      
                        showDialog();
                    }    


                    function clickPage(id)
    
                    {
                        var page=document.getElementById(id).innerHTML;
                        document.body.style.cursor = "wait";
      
                        document.forms["page_form"+page].submit();
                    }
                    function clickFirstPage()
                    {
                        document.body.style.cursor = "wait";
                        document.forms["firstpage_form"].submit(); 
                    }
                    function clickPreviousPage(p)
                    {
                        document.body.style.cursor = "wait";
                        document.forms["page_form"+p].submit(); 
                    }
    
                    function clickLastPage(npage)
                    {
                        // alert("n page: "+npage); 
                        document.body.style.cursor = "wait";
                        document.forms["lastpage_form"].submit(); 
                    }
                    function clickNextPage(p)
                    {
                        document.body.style.cursor = "wait";
                        document.forms["page_form"+p].submit(); 
                    }
    
                    $("#id_search_word").bind('keypress', function(e)
                    {   
                        if(e.which == 13) 
                        {
                            submitSearch();
                        }
                    });  
                    function getExampleValue(id)
                    {
          
                        var s=document.getElementById("idExample"+id).value;
                        var e=document.getElementById("id_search_word").value=s;
          
                        //submitSearch();
            
                        $( "#dialogExamples" ).dialog( "close" );
                        
        
       
                        //submitSearch();
            
                    } 
                    $( "#examplebutton" ).click(function() {
                        $( "#dialogExamples" ).dialog( "open" );
                        showDialogExamples();
                    });
 
                    function showDialogExamples()
                    {
        
       
                        document.getElementById("examplebutton").disabled;
       
        
       
                        $("#dialogExamples").dialog({
                            dialogClass: "no-close",
                            resizable: false,
                            modal: true,
                            width: 'auto',
                            height: 'auto',
                            position:['center','center'],
                            autoOpen: false,
                            overlay: { backgroundColor: "#000", opacity: 0.5 },
                            buttons: [ { text: "close", click: function() { $( this ).dialog( "close" ); } } ]

    
              

                        });
        
        
       
            
                    }  
                    
                    
                  function  ViewGraphTab(id){
                       alert("sono qua" +id);
                  
                <% //ApiVirtuosoForGraph.getRecordVirtuoso();
                    
               // System.out.println("ouuuuuuuuu");
                 %>
                  
                        
                        
                    
                    }
                            
            </script>                     




        </div> 



    </body>

</html>

