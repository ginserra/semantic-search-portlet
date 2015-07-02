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
<%@page import="it.infn.ct.SemanticQuery"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<jsp:useBean id="arrayLanguageSubject" class="java.util.ArrayList" scope="request" />


<portlet:defineObjects />
<%//
  // GATE 6.0.0 Submission Form
  //
  // The form has 3 input textareas respectively for:
  //    * Macro file
  //    * Material DB
  //    * ROOT Analysis C file
  // Beside each text area a upolad button takes as input the 
  // file name related to one of the above fields.
  // The forth submission buttons is related to the file 'phsp.root' file
  // A default phsp.root file will be used if no files will be uploaded by the user.
  // The ohter three buttons of the form are used for:
  //    o Demo:          Used to fill with demo values the text areas
  //    o SUBMIT:        Used to execute the job on the eInfrastructure
  //    o Reset values:  Used to reset input fields
  //
  
  // Gets the current timestamp
  java.util.Date date = new java.util.Date();
%>

<%
// Below the descriptive area of the GATE web form 
%>

<jsp:useBean id="arrayCodesLanguage" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="language" class="java.lang.String" scope="request" />
<html>
    <head>
      


    </head>
    <body>
        <div id="divContainer"> 
            <center>
                 <div class="menu">

                    <div class="root">

                     <!--   <div class="selected">Select a language:<%=language%>&nbsp; <b id="language"> &nbsp;</b>   <img  src="<%=renderRequest.getContextPath()%>/images/down.gif" border="1"/></div>

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

                                <input hidden="true" type="text" id="selLanguageId" name="selLanguage"value="<%=language%>"/>
                            </form>
                        </div>-->
                    </div>

                </div>


                    <div id="divSearchBar"> 
                        <form id="search_form" action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_SEMANTIC_SEARCH_ALL_LANGUAGE"/></portlet:actionURL>" method="post">         
                            <table  >
                                <tr>
                                    <td align="center" style=" padding: 5px;" >
                                        <img href="http://klios.ct.infn.it" src="<%=renderRequest.getContextPath()%>/images/logo_klios.png" />
                                    </td>

                                    <td align="center" style=" padding: 10px;">

                                        <input class="rounded" id="id_search_word"  name="search_word" type="text" style="width:600px;height: 20px;font-size: 12px"/>
                                        <input hidden="true" type="text" name="nameLanguage" value="<%=language%>"/>


                                    </td>
                                    <td align="center" style=" padding: 10px;">
                                        <input hidden="true" id="id_graph"  name="graph" type="text" value="http://CHAIN-Reds_Test"/>
                                        <input id="buttonSearchImg "  type="button" onclick="submitSearch(); " style="text-align: right;font-size: 12px;" value="Search"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td align="center" style=" padding-top:0px; padding-bottom: 14px">Enter a keyword or select a language and then choose a subject</td>
                                    <td></td>
                                </tr>



                            </table>

                        </form>
                    </div>
            </center>
         <div id="divResultSearchSubject">
              <div id="divLeft"> 
                  <div><h4 id="numSubject"></h4></div>
              <table>
                  
            <%
              
            //ArrayList arrayLanguageSubject=new ArrayList();
              // arrayLanguageSubject=SemanticQuery.getSubjectFromCodeLanguage(arrayCodesLanguage);
               int countTotale=(Integer)arrayLanguageSubject.get((arrayLanguageSubject.size()-1));
               System.out.println("COUNTMIO: "+countTotale);
            int counter=0;
            if(arrayLanguageSubject.size()>0){
                for(int i=0; i<arrayLanguageSubject.size()-1; i++){
                   // System.out.println("sono nella jsp language");
                String element=arrayLanguageSubject.get(i).toString();
                String nameSubject= element.split("#")[0].toString();
                String countSubject= element.split("#")[1].toString();
                //System.out.println("Subject size "+nameSubject.length());
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
                  
              </div>
                            
                                
                                
        </div>
            </div>

              
    <div id="dialog2" title="Information" hidden="true" >
            <center>
            <p>Searching...</p>
            <p>This may take some time</p>
            </center>
        </div> 


    </body>
    <script language="javascript">
        
        document.getElementById("language").innerHTML=<%=language%>;
        document.getElementById("numSubject").innerHTML="<%=language%> Subjects (<%=countTotale%>) ";
        
        function cursor_wait(){
            document.body.style.cursor = "wait";
        }    
            
            
        function actionSubmit(id){
            
            //alert("ciao "+x+"id "+id);
             document.body.style.cursor = "wait";
            var x= document.getElementById("nameSubjectId"+id).value;
            
            document.forms["search_form"+id].submit();
           //  showDialog();
             
        }
        
      function submitLanguage(id)
      {
          cursor_wait();
          var s=document.getElementById("idLanguage"+id).value;
          var e=document.getElementById("selLanguageId").value=s;
          
          //document.getElementById("language").innerHTML=e;
          
         // alert("INPUT VALUE to submit--> "+s+" "+id+" "+e);
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
</html>    
