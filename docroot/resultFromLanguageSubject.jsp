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
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>


<%@page import="it.infn.ct.SemanticQueryMoreInfo"%>
<%@page import="it.infn.ct.SemanticQuery"%>


<jsp:useBean id="keyword" class="java.lang.String" scope="request"/>
<jsp:useBean id="keyword2" class="java.lang.String" scope="request"/>
<jsp:useBean id="textHidden" class="java.lang.String" scope="request"/>
<jsp:useBean id="textHidden2" class="java.lang.String" scope="request"/>
<jsp:useBean id="arrayVirtuosoResource" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="searched_word" class="java.lang.String" scope="request" />
<jsp:useBean id="arrayCodesLanguage" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="arrayResourceFromSubject" class="java.util.ArrayList" scope="request" />

<jsp:useBean id="searched_subject" class="java.lang.String" scope="request" />
<jsp:useBean id="language" class="java.lang.String" scope="request" />
<jsp:useBean id="arrayLanguageSubject" class="java.util.ArrayList" scope="request" />


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

        <link rel=stylesheet href="<%=request.getContextPath()%>/css/sezione.css" type="text/css">



        <%-- <script type="text/javascript" src="<%=request.getContextPath()%>/jsNew/jquery.min.js"></script>
          <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/jsNew/arbor.js" ></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/jsNew/graphics.js" ></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/jsNew/RenderOntology14.js" ></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/jsNew/arbor-tween.js" ></script> --%>




    </head> 



    <body>

        <br>
        <div id="divContainer">
            <center>
                <div class="menu">

                    <div class="root">

                       <!-- <div class="selected">Select a language:<%=language%>&nbsp; <b id="language">&nbsp;</b>   <img  src="<%=renderRequest.getContextPath()%>/images/down.gif" border="1"/></div>

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
                                    <img href="http://klios.ct.infn.it" src="<%=renderRequest.getContextPath()%>/images/logo_klios.png"  />
                                </td>

                                <td align="center" style=" padding: 10px;">

                                    <input class="rounded" id="id_search_word"  name="search_word" type="text" style="width:600px;height: 20px;font-size: 12px"/>



                                </td>
                                <td align="center" style=" padding: 10px;">

                                    <input id="buttonSearchImg "  type="button" onclick="submitSearch(); " style="text-align: right;font-size: 12px;" value="Search"/>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td align="center" style=" padding-top:0px; padding-bottom: 14px">Enter a keyword </td>
                                <td></td>
                            </tr>



                        </table>

                    </form>
                </div>
            </center>



            <div id="divResultSearchSubject">
                <div id="divLeft"> 
                    <div><h4 id="numSubject"></h4></div>
                    <table id="tableSearch" >

                        <%
              
                       // ArrayList arrayLanguageSubject=new ArrayList();
                       //    arrayLanguageSubject=SemanticQuery.getSubjectFromCodeLanguage(arrayCodesLanguage);
                        int counter=0;
                        int countTotale=(Integer)arrayLanguageSubject.get((arrayLanguageSubject.size()-1));
                        //System.out.println("COUNTMIOWITH RESULT: "+countTotale);
                        if(arrayLanguageSubject.size()>0){
                            for(int i=0; i<arrayLanguageSubject.size()-1; i++){
                                //System.out.println("sono nella jsp language");
                            String element=arrayLanguageSubject.get(i).toString();
                            String nameSubject= element.split("#")[0].toString();
                            String countSubject= element.split("#")[1].toString();
                           // System.out.println("Subject size "+nameSubject.length());
                            String first_char_sub="";
                            String subj="";
                            
                            
                            
                            if(nameSubject.length()>49){
                                                                                
                                    first_char_sub=nameSubject.substring(0,40).toString();
                                    subj=first_char_sub+" ... ";
                                     }
                                    else
                                                               { 
                                    subj=nameSubject;
               
                                                   }
                        %> 

                        <tr>
                            <td>
                                <form id="search_form<%=counter%>" action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_QUERY_FROM_LANGUAGE_SUBJECT"/></portlet:actionURL>" method="post">         
                                    <input hidden="true" id="nameSubjectId<%=counter%>" name="nameSubject" value="<%=nameSubject%>"/><u id="<%=counter%>" align="left" title="<%=nameSubject%>" style="cursor: pointer" onclick="actionSubmit(this.id);" ><%=subj%></u> (<%=countSubject%>) 

                                </form>
                            </td>
                        </tr>
                        <%
                        counter++;
                                   }
                                   }
                        else
                        {
                        %><h5 class="klios">No Results</h5> 
                        <%  }
                
                        %>
                    </table>
                </div>

                <div id="divRigth">
                    <div id="tabMenuResult" class="tabber">


                        <%
                         // if(arrayVirtuosoResource.size()>0){
                                      
                        %>
                        <div  class="tabbertab" title="Results " >
                            <h4>Results for: <%=searched_subject%></h4>
                            <hr class="endRecordSubject" noshade="noshade" >
                            <table>

                                <%    int countId=0; 
                                ArrayList arrayGlobal=new ArrayList();
                                    
                                           for(int i=0;i<arrayResourceFromSubject.size();i++){
                          
                                          ArrayList arraySigleResource= new ArrayList();
                                          String resource=arrayResourceFromSubject.get(i).toString();
                                          arraySigleResource.add(resource);
                                        //  System.out.println(" Sono dentro semantic search"+arrayResourceFromSubject.get(i).toString());
                                              
                      
                                          ArrayList arrayTitles=SemanticQuery.getListNotDuplicate(SemanticQuery.getTitle(resource));
                                              
                                          arraySigleResource.add(arrayTitles);
                                              
                                          ArrayList arrayIdentifiers=SemanticQuery.getListNotDuplicate(SemanticQuery.getIdentifiers(resource));
                                              
                                          arraySigleResource.add(arrayIdentifiers);
                                          ArrayList id_string=new ArrayList();
                                          ArrayList id_http=new ArrayList();
                      
                                          for(int idf=0; idf<arrayIdentifiers.size();idf++){
                                             if(arrayIdentifiers.get(idf).toString().length()>4 &&  arrayIdentifiers.get(idf).toString().substring(0,4).equals("http"))
                                                 id_http.add(arrayIdentifiers.get(idf).toString());
                                             else
                                                 id_string.add(arrayIdentifiers.get(idf).toString());
                                          }
                                   
      
                                %>

                                <tr>
                                    <td>   
                                        <table class=" resultSearchSubject ">


                                            <tr>

                                                <%
                                     
                                                    // System.out.println("title size "+arrayTitles.size());
                                     
                                                      if(arrayTitles.size()>0){
                                                %>
                                                <td>     
                                                    <h5 class="klios">Title</h5>


                                                    <ul class="Klios_ul">

                                                        <% 
                                      
                                                          for(int t=0; t<arrayTitles.size(); t++){
                                                            String title=arrayTitles.get(t).toString();
                                                           // System.out.println("title ["+t+"]= "+title);
                                                            if(id_http.size()>0){
                                                                String link= id_http.get(0).toString();
                                            
                                                        %>
                                                        <li><a href="<%= link %>" target="_blank" title="<%= link%>"><%= title %> </a></li> 
                                                        <input id="titleResourceVirtuoso<%=countId%>" name="titleResourceVirtuoso" value="<%= title %>" hidden="true" />



                                                        <%
                                                        }else{%>
                                                        <li> <input id="titleResourceVirtuoso<%=countId%>" name="titleResourceVirtuoso" value="<%= title %>" hidden="true" /> <i> <%= title %></i></li>
                                                            <%
                                                                }
                                                                }
                                                                }

                                                            %>
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

                                                    <input id="authorResourceVirtuoso<%=countId%>" name="authorResourceVirtuoso" value="<%= author %>" hidden="true" /> <i> <%= author %></i>



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
                                                //System.out.println("description size "+arrayDescriptions.size());
                                                          if(arrayDescriptions.size()>0){
                                                %>
                                                <td>
                                                    <h5 class="klios">Description</h5>


                                                    <%
                                                        // for(int d=0; d<arrayDescriptions.size(); d++){
                                     
                                                             String description=arrayDescriptions.get(0).toString();
                                                              String preview_desc="";
                                                               // System.out.println("description ["+0+"]= "+description);
                                                               // System.out.println("description ["+0+"]= "+description.length());
                                       
                                                                if(description.length()>299)
                                                                                
                                                                 preview_desc=description.substring(0,300).toString()+"...";
                                                                else
                                                                 preview_desc=description;   
                                                              //  String preview_desc2=description.substring(((description.length())/2)+1,description.length()).toString();
                                        
                                            
                                                               // System.out.println("DESCRIPTION JSP meta "+preview_desc);
                                        
                                                    %>

                                                    <input id="descResourceVirtuoso<%=countId%>" name="descResourceVirtuoso" value="<%= description %>" hidden="true" /><%= preview_desc%>


                                                    <%    
                                                        //}
                                                       }                                                                                                     
                                                    %>


                                                </td>
                                            </tr>
                                            <tr>

                                                <%
                                              // SemanticQueryMoreInfo moreInfo = new SemanticQueryMoreInfo();
                                               ArrayList arrayRepository=SemanticQuery.getListNotDuplicate(SemanticQuery.getRepository(resource));
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
                                                                 if(arrayRepository.get(4).toString().length()>4 && arrayRepository.get(4).toString().substring(0,4).equals("http"))
                                                                     urlRep=arrayRepository.get(4).toString();
                                                                 else
                                                                     urlRep="http://"+arrayRepository.get(4).toString();
                                                            
                                                                // System.out.println("URL REP "+urlRep);
                                                             
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
                                                                
                                             // System.out.println("sources size "+arraySource.size());
                                                      if(arraySource.size()>0){
                   
                                                   }                                                                                                     
                                            %>




                                            <tr> 
                                                <td> 
                                                    <form id="searchDetail" action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_GET_MORE_INFO"/></portlet:actionURL>" method="post">
                                                        <input id="idResource" name="idResource" value="<%= resource %>" hidden="true" />
                                                        <p id="counterResoure_<%=resource%>" style="cursor: pointer;color: red;" onclick="GoDetails(this.id)">More Info</p>    
                                                    </form>
                                                </td>

                                            </tr>


                                            <tr><td> <hr class="endRecordSubject" noshade="noshade" ></td></tr>

                                        </table>
                                    </td>
                                </tr>





                                <%
                                    countId++;
                                    arrayGlobal.add(arraySigleResource);
                                    
                                      }
                                        
                                   // System.out.println("DIMENSIONE ARRAY-GLOBAL-> "+arrayGlobal.size());
                                                                                                                                 
                                %>

                            </table>
                        </div>






                        <div  class="tabbertab" title="Graphs " >        


                            <br>

                            <fieldset>
                                <legend>Filter to view a struct of Resource (max 10 Resource)</legend>
                                <div>
                                    <p>Select one or more Resources to view</p>
                                    <div class="multiselect">

                                        <%for(int k=0;k<arrayGlobal.size();k++)
                                    {
                                       ArrayList result=(ArrayList)arrayGlobal.get(k);
                                        String resource=(String)result.get(0);
                                       //String resource="ciao";
                                        ArrayList titles=(ArrayList)result.get(1);
                                        ArrayList authors=(ArrayList)result.get(3);
                                        ArrayList sources=(ArrayList)result.get(5);
                        
                            
                                        %>
                                        <label><input type="checkbox" name="option[]" value="<%=k%>" /><b style="color: red;">[R<%=(k+1)%>]</b>&nbsp;<%=titles.get(0).toString()%></label>
                                            <% }
                    
                                            %>


                                    </div>

                                    <div>
                                        <p><b id="counterResource">0</b> Resources Selected</p>
                                        <p>Select a Filter for visualization:</p>
                                        <select id="FilterArbor" NAME="comboPaper" >

                                            <option value="Authors" selected>Authors</option>
                                            <option value="Subjects">Subjects</option> 
                                            <option value="Publishers">Publishers</option>

                                        </select>



                                        <input style="display: inline-block;" type="button" value="View" onclick="viewGraph()" >
                                        <input  type="button" value="Clear" onclick="clearCheck()" >
                                        <p> <font size="1">(To clear the graph wait until the particles are firmly)</font></p>
                                    </div>
                                </div>

                            </fieldset>        
                            <canvas id="viewport" width="630" height="600" ></canvas>


                            <script type="text/javascript">
                    
                                var $= jQuery.noConflict(true);                   
                                ArrayResource=new Array();
                                ArrayTitle=new Array();
                                ArrayAuthor=new Array();
                                ArrayDescription=new Array();
                                ArraySubject=new Array();
                                ArrayPublisher=new Array();
                                ArraySource=new Array();
                                <% 
                               //  HandlingOpenDOAR doar=new HandlingOpenDOAR();
                                for(int i=0;i<arrayGlobal.size();i++)
                                {
                                    ArrayList result=(ArrayList)arrayGlobal.get(i);
                                    String resource=(String)result.get(0);
                                    //ArrayList titles=(ArrayList)result.get(1);
                                    ArrayList authors=(ArrayList)result.get(3);
                                
                                    ArrayList subjects=(ArrayList)result.get(6);
                                    ArrayList publishers=(ArrayList)result.get(7);
                                %>
                                
                                    ArrayResource["<%=i%>"]="<%=resource%>";<%
                                
     
                                    String myAuthors="";
                                
                                   for (int z=0;z<authors.size();z++)
                                   { String elemAuthor=authors.get(z).toString();
                                
                                    String [] list_Authors=elemAuthor.split(";");
                                    for(int j=0;j<list_Authors.length;j++)
                                    {
                            
                                        String author= list_Authors[j].toString();
                                        myAuthors=myAuthors+"##"+author;
                                    }
                                %> ArrayAuthor["<%=i%>"]="<%=myAuthors%>"; <% }

                                    String mySubjects="";
                            for(int j=0;j<subjects.size();j++)
                            {
                            
                                String subject= subjects.get(j).toString();
                                mySubjects=mySubjects+"##"+subject;
                            }
                                %> ArraySubject["<%=i%>"]="<%=mySubjects%>";  <% 
                            
                                String myPublishers="";
                            for(int j=0;j<publishers.size();j++)
                            {
                            
                                String publisher= publishers.get(j).toString();
                                myPublishers=myPublishers+"##"+publisher;
                            }
                                %> ArrayPublisher["<%=i%>"]="<%=myPublishers%>";  <%
                    
                    
                                
                                }//chiudo il for principale
                                %>
                    
                                    var counter=0;
                                    arrayIdResourceSelected = new Array(); 
                                    var counterInpuText=document.getElementById("counterResource");
                                            
                                    var CLR = {
                                        resource:"red",
                                        dc_resource:"#FF6666",
                                        title:"green",
                                        description:"#9ACD32",
                                        subject:"#FF9900",
                                        subjectValue:"#FFE4C4",
                                        author:"#969696",
                                        authorValue:"#D3D3D3",
                                        publisherValue:"#ADD8E6",
                                        publisher:"#008B8B",
                                        source:"#FFB6C1",
                                        black:"black"
                                    }                        
                    
                        
                    
                                    jQuery.fn.multiselect = function() {
                                        $(this).each(function() {
                            
                          
                                            //var counterInpuText=document.getElementById("counterResource");
                                            var checkboxes = $(this).find("input:checkbox");
                                            checkboxes.each(function() {
                                                var checkbox = jQuery(this);
                                                // Highlight pre-selected checkboxes
                                                if (checkbox.attr("checked"))
                                                {
                                    
                                                    checkbox.parent().addClass("multiselect-on");
                                                }
                                                // Highlight checkboxes that the user selects
                                                checkbox.click(function() {
                                                    if (checkbox.attr("checked"))
                                                    {      
                                                        if(counter<10) { 
                                                            //alert("ID CHECKBOX: "+checkbox.val());
                                                            arrayIdResourceSelected.push(checkbox.val());
                                                            checkbox.parent().addClass("multiselect-on");       
                                                            counter=counter+1;
                                                            counterInpuText.innerHTML=counter;
                                                        }
                                                        else
                                                        {
                                                            checkbox.removeAttr('checked');
                                                            checkbox.parent().removeClass("multiselect-on");
                                                            //alert("Select max 10 records");
                                                            $( "#dialogMaxResource" ).dialog({
                                
                                                                width: 300, 
                                                                height:150,
                                                                title:"ATTENTION",
                                                                position: "center",
                                                                buttons: [
                                                                    {
                                                                        text: "Ok",
                                                                        click: function() {
                                                                            $(this).dialog("close");
                                                                        }
                                                                    }
                                                                ],
                                                                hide: { effect: 'drop', direction: "down" },
                                                                resizable: false
                                

                                                            });
                                                            $( "#dialogMaxResource" ).text("Limite raggiunto");
                                                        }
                                        
                                                    }
                                                    else
                                                    {
                                   
                                                        counter=counter-1;
                                                        checkbox.parent().removeClass("multiselect-on");
                                                        counterInpuText.innerHTML=counter;
                                                        //arrayIdResourceSelected.removeEl(checkbox.val());
                                                        // alert("CHECK DA ELIMINARE: "+checkbox.val())
                                                        controlElemArray(arrayIdResourceSelected,checkbox.val());
                                    
                                                    }
                                                });
                                            });
                    
                    
                                        });
                        
                                    };
                    
                                    jQuery(".multiselect").multiselect();
                    
                                    function viewGraph()
                                    {
                                        var filterSel = document.getElementById('FilterArbor').value;  
                                        //alert("OK VIEW");
                                        if(filterSel=="Authors")
                                        {
                                
                                            loadResourceAuthor(arrayIdResourceSelected);
                                        }
                                        if(filterSel=="Subjects")
                                        {
                                            loadResourceSubject(arrayIdResourceSelected);
   
                                        }
                            
                                   
                                        if(filterSel=="Publishers")
                                        {
                                            loadResourcePublisher(arrayIdResourceSelected);
   
                                        }
                                   
   
                        
                                    }
                    
                                    function controlElemArray(myArray,val)
                                    {
                                        for (var i=0;i<myArray.length;i++)
                                        {
                                            var valueArray=myArray[i];
                                            if(val==valueArray)
                                                myArray.splice(i,1);
                                 
                                        }
                                    }
                    
                    
                                    function clearCheck()
                                    {
                        
                                        arrayIdResourceSelected.length=0;
                                        //clearCanvas(context, canvas);
                            
                                        jQuery('.multiselect').each(function() {
  
                                            $(this).each(function () {
                                                var checkboxes = $(this).find("input:checkbox");
                                                checkboxes.each(function() {
                                                    var checkbox = jQuery(this);
                                                    // Highlight pre-selected checkboxes
                                                    if (checkbox.attr("checked"))
                                                    {
                                    
                                                        checkbox.parent().removeClass("multiselect-on");
                                                        checkbox.removeAttr('checked');
                                                        counter=0;
                                                        counterInpuText.innerHTML=counter;
                                                    }
                                                });
                                            });
                                        });
                            
                                        clearCanvas();                 
                                    }
                    
                                    function clearCanvas() {
                                        var canvas = document.getElementById('viewport');
                                        var context = canvas.getContext('2d');
                                        context.clearRect(0, 0, canvas.width, canvas.height); 
                                    }
 
                                    function loadResourceAuthor(arrayIdSelected)
                                    {
    
    
                                        //var canvas = document.getElementById('viewport');
                                        //var context = canvas.getContext('2d');
                                        clearCanvas();
                                        //context.clearRect(0, 0, canvas.width, canvas.height);                      
                            
                                        var sys = arbor.ParticleSystem();
                                        sys.parameters({stiffness:900, repulsion:2000, gravity:true, dt:0.015});
            
                                        sys.renderer = Renderer("#viewport");
            
                                        // alert("NUM SELECT: "+arrayIdSelected.length);        
                                        for(var j=0;j<arrayIdSelected.length;j++)
                                        {
                                            var indexToView=arrayIdSelected[j];
                                            var indexToViewInInteger=parseInt(indexToView);
                                            var resourceNode = sys.addNode("RESOURCEAuthor"+indexToView,{color:CLR.resource,shape:"dot",alpha:1,label:"[R"+(indexToViewInInteger+1)+"]"});
                        
                                            var authors=ArrayAuthor[indexToView];
                       
                                            var listAuthors=authors.split("##");
                                            // alert ("AUTHOR :"+listAuthors.length);
                                            if (listAuthors.length > 1) {
                        
                                                var authorNode=sys.addNode("AUTHOR"+indexToView,{color:CLR.author,alpha:1,label:"Author"+(indexToViewInInteger+1)+" (num"+(listAuthors.length-1)+")"});
                                                authorNode.data.typeDescription=false;
                                                var edgeResourceAuthor=sys.addEdge(resourceNode,authorNode,{'name':'Onto:hasAuthor'});
                                                edgeResourceAuthor.data.connectionclass=true;
                                                edgeResourceAuthor.data.directed=true;
                
                                                for(var i=1;i<listAuthors.length; i++){
                                                    // alert ("AUTHOR_"+i+" :"+listAuthors[i]);
                                                    var author=listAuthors[i];
                                                    var authorNodeValue=sys.addNode(author,{color:CLR.authorValue,alpha:0,label:author});
                                                    authorNodeValue.data.typeDescription=false;
                                                    var edgeAuthorName=sys.addEdge(authorNode,authorNodeValue,{'name':''});
                                                    edgeAuthorName.data.directed=true;
                                                    edgeAuthorName.data.color=CLR.author;
                           

                                                }   
                     
                                            }
                    
                                        }                                   
                                    }

                                    function loadResourceSubject(arrayIdSelected)
                                    {
    
    
                                        //var canvas = document.getElementById('viewport');
                                        //var context = canvas.getContext('2d');
                                        clearCanvas();
                                        //context.clearRect(0, 0, canvas.width, canvas.height);                      
                            
                                        var sys = arbor.ParticleSystem();
                                        sys.parameters({stiffness:900, repulsion:2000, gravity:true, dt:0.015});
            
                                        sys.renderer = Renderer("#viewport");
            
                                        // alert("NUM SELECT: "+arrayIdSelected.length);        
                                        for(var j=0;j<arrayIdSelected.length;j++)
                                        {
                                            var indexToView=arrayIdSelected[j];
                                            var indexToViewInInteger=parseInt(indexToView);
                                            var resourceNode = sys.addNode("RESOURCESubject"+indexToView,{color:CLR.resource,shape:"dot",alpha:1,label:"[R"+(indexToViewInInteger+1)+"]"});
                        
                                            var subjects=ArraySubject[indexToView];
                       
                                            var listSubjects=subjects.split("##");
                                            // alert ("AUTHOR :"+listAuthors.length);
                                            if (listSubjects.length > 1) {
                                                var subjectNode=sys.addNode("SUBJECT"+indexToView,{color:CLR.subject,alpha:1,label:"Subject"+(indexToViewInInteger+1)+" (num"+(listSubjects.length-1)+")"});
                                                subjectNode.data.typeDescription=false;
                                                var edgeResourceSubject=sys.addEdge(resourceNode,subjectNode,{'name':'dc:subject'});
                                                edgeResourceSubject.data.connectionclass=true;
                                                edgeResourceSubject.data.directed=true;
                                   
                
                                                for(var i=1;i<listSubjects.length; i++){
                                                    // alert ("AUTHOR_"+i+" :"+listAuthors[i]);
                                                    var subject=listSubjects[i];
                                                    var subjectNodeValue=sys.addNode(subject,{color:CLR.subjectValue,alpha:0,label:subject});
                                                    subjectNodeValue.data.typeDescription=false;
                                                    var edgeSubjectValue=sys.addEdge(subjectNode,subjectNodeValue,{'name':''});
                                                    edgeSubjectValue.data.directed=true;
                                                    edgeSubjectValue.data.color=CLR.black;
                           

                                                }   
                     
                                            }
                    
                                        }                                   
                                    }  
                        
                                
                        
                                
                                    function loadResourcePublisher(arrayIdSelected)
                                    {
    
    
                                        //var canvas = document.getElementById('viewport');
                                        //var context = canvas.getContext('2d');
                                        clearCanvas();
                                        //context.clearRect(0, 0, canvas.width, canvas.height);                      
                            
                                        var sys = arbor.ParticleSystem();
                                        sys.parameters({stiffness:900, repulsion:2000, gravity:true, dt:0.015});
            
                                        sys.renderer = Renderer("#viewport");
            
                                        // alert("NUM SELECT: "+arrayIdSelected.length);        
                                        for(var j=0;j<arrayIdSelected.length;j++)
                                        {
                                            var indexToView=arrayIdSelected[j];
                                            var indexToViewInInteger=parseInt(indexToView);
                                            var resourceNode = sys.addNode("RESOURCEPublisher"+indexToView,{color:CLR.resource,shape:"dot",alpha:1,label:"[R"+(indexToViewInInteger+1)+"]"});
                        
                                            var publishers=ArrayPublisher[indexToView];
                       
                                            var listPublihers=publishers.split("##");
                                            // alert ("AUTHOR :"+listAuthors.length);
                                            if (listPublihers.length > 1) {
                                                var publisherNode=sys.addNode("PUBLISHER"+indexToView,{color:CLR.publisher,alpha:1,label:"Publisher"+(indexToViewInInteger+1)+" (num"+(listPublihers.length-1)+")"});
                                                publisherNode.data.typeDescription=false;
                                                var edgeResourcePublisher=sys.addEdge(resourceNode,publisherNode,{'name':'dc:publisher'});
                                                edgeResourcePublisher.data.connectionclass=true;
                                                edgeResourcePublisher.data.directed=true;
                                   
                
                                                for(var i=1;i<listPublihers.length; i++){
                                                    // alert ("AUTHOR_"+i+" :"+listAuthors[i]);
                                                    var publisher=listPublihers[i];
                                                    var publisherNodeValue=sys.addNode(publisher,{color:CLR.publisherValue,alpha:0,label:publisher});
                                                    publisherNodeValue.data.typeDescription=false;
                                                    var edgePublisherValue=sys.addEdge(publisherNode,publisherNodeValue,{'name':''});
                                                    edgePublisherValue.data.directed=true;
                                                    edgePublisherValue.data.color=CLR.black;
                           

                                                }   
                     
                                            }
                    
                                        }                                   
                                    }
                        
                               
                    
                            </script>                        

                        </div>         

                    </div>  

                </div><!--div rigth-->
            </div><!--  divResult search-->


        </div><!--div container-->

        <div id="dialog2" title="Information" hidden="true" >
            <center>
            <p>Searching...</p>
            <p>This may take some time</p>
            </center>
        </div> 
    </body>

</html>
<script>
    $(document).ready(function () {
     
        
        clearCheck();
        $('.prova').each(function(index) {
  
            $(this).click(function () {
                $(this).find('div').slideToggle("slow")
            });
        });

        $('.prova2').each(function(index) {
  
            $(this).click(function () {
                $(this).find('div').slideToggle("slow")
            });
        });
        
        $('.prova3').each(function(index) {
  
            $(this).click(function () {
                $(this).find('div').slideToggle("slow")
            });
        });
        
        
        
        var numTabOpenAire=$('.tabOpenAire');
        for(var i=1; i<numTabOpenAire.length; i++) {
            if(i>9)
            {
                $(numTabOpenAire[i]).hide();
            }
           
        }
            
        /* var numPageOpenAire=$('.CountPage');
            for(var i=0; i<numPageOpenAire.length; i++) {
                
                    $(numPageOpenAire[i]).click(function(){
                        alert("PAGE: "+i);
                    });

            }*/
        
       
        
   
         
        $("#tabs").tabs();   
        
        
        
         
    });


    document.getElementById("numSubject").innerHTML="<%=language%> Subjects (<%=countTotale%>) ";  

   
    function tabSwitch(new_tab, new_content) {  
  
        document.getElementById('content_1').style.display = 'none';  
        document.getElementById('content_2').style.display = 'none';  
        document.getElementById('content_3').style.display = 'none';  
        document.getElementById('content_4').style.display = 'none'; 
        document.getElementById('content_5').style.display = 'none'; 
        document.getElementById('content_6').style.display = 'none';
        document.getElementById('content_7').style.display = 'none'; 
        document.getElementById(new_content).style.display = 'block';     
  
        document.getElementById('tab_1').className = '';  
        document.getElementById('tab_2').className = '';  
        document.getElementById('tab_3').className = '';  
        document.getElementById('tab_4').className = '';
        document.getElementById('tab_5').className = '';
        document.getElementById('tab_6').className = '';
        document.getElementById('tab_7').className = '';
        document.getElementById(new_tab).className = 'active';        
  
    }  
    
    function setHiddenValueSearch(){
        
        document.getElementById('textHidden2').value="normal";
        document.body.style.cursor = "wait";
        document.document.getElementById('keyword');
    }
    
    function setHiddenValueSearchFull(){
        
        document.getElementById('textHidden2').value="full";
        document.body.style.cursor = "wait";
    }
    
    function getKeyword(){
        return document.getElementById('keyword2').value;
    }
     
    
    function GoDetails(x)
    {
        //var
        //var resource=document.getElementById(x).innerHTML;
        //var title=document.getElementById('idTitleResource').value;
        cursor_wait();
        var resource=x.toString().split("counterResoure_")[1];
         
               
        document.getElementById('idResource').value=resource;
        document.forms["searchDetail"].submit();
                 
        
                
        
        
       
    }  
    
    
    function cursor_wait(){
        document.body.style.cursor = "wait";
    }

    function actionSubmit(id){
        document.body.style.cursor = "wait";
        var x= document.getElementById("nameSubjectId"+id).value;
           
        document.forms["search_form"+id].submit();
        showDialog();    
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
        
    function submitSearch()
    {
        document.body.style.cursor = "wait";
            
        document.forms["search_form"].submit();
      
        showDialog();
    }  
            

            
    function submitAllLanguage(){
            
        document.forms["form_all_language"].submit();
        document.body.style.cursor = "wait";
    }    
        
    $( "#dialog2" ).dialog({ autoOpen: false });
   
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
    
        $("#id_search_word").bind('keypress', function(e)
        {   
        if(e.which == 13) 
        {
           submitSearch();
        }
        });

      
</script>