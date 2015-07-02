/**
 * ************************************************************************
 * Copyright (c) 2011: Istituto Nazionale di Fisica Nucleare (INFN), Italy
 * Consorzio COMETA (COMETA), Italy
 *
 * See http://www.infn.it and and http://www.consorzio-cometa.it for details on
 * the copyright holders.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 *
 * @author <a href="mailto:riccardo.bruno@ct.infn.it">Riccardo Bruno</a>(COMETA)
 * **************************************************************************
 */
package it.infn.ct;

// Import generic java libraries
import java.io.*;
import java.util.Iterator;
import java.util.List;
import java.util.Calendar;
import java.text.SimpleDateFormat;

// Importing portlet libraries
import javax.portlet.*;

// Importing liferay libraries
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.model.User;

// Importing Apache libraries
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.portlet.PortletFileUpload;

// Importing GridEngine Job libraries 
//import it.infn.ct.GridEngine.Job.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.openrdf.query.MalformedQueryException;
import org.openrdf.query.QueryEvaluationException;
import org.openrdf.repository.RepositoryConnection;
import org.openrdf.repository.RepositoryException;

//
// This is the class that overrides the GenericPortlet class methods
// You can create your own portlet just customizing the code skeleton
// available below. It provides mainly a working example on:
//    1) How to manage combination of Actions/Views
//    2) How to manage portlet preferences and help
//    3) How to show information using the Log object
//    4) How to execute a distributed application with GridEngine
//
public class SemanticSearch_portlet extends GenericPortlet {

    // AppLogger class (No customizations needed)
    // Although developers can use System.out.println to watch their own console outputs
    // the use of Java logs is highly recommended.
    // Java Log object offers different output levels to show information:
    //    trace
    //    debug
    //    info
    //    warn
    //    error
    //    fatal
    // All of them accept a String as parameter containing the proper message to show.
    // AppLogger class uses  LogLevel eunerated type to express the log level verbosity
    // the setLogLevel method allows the portlet to print-out all logs types equal
    // or below the given log level accordingly to the priority:
    //       trace,debug,info,warn,erro,fatal
    private enum LogLevels {

        trace,
        debug,
        info,
        warn,
        error,
        fatal
    }
    // The AppLogger class wraps the apache.common Log object allowing the user to
    // enable/disable log accordingly to a given loglevel; the higher is the level 
    // more verbose will be the produced output

    private class AppLogger {
        // Values associated 

        private static final int TRACE_LEVEL = 6;
        private static final int DEBUG_LEVEL = 5;
        private static final int INFO_LEVEL = 4;
        private static final int WARN_LEVEL = 3;
        private static final int ERROR_LEVEL = 2;
        private static final int FATAL_LEVEL = 1;
        private static final int UNKNOWN_LEVEL = 0;
        private Log _log;
        private int logLevel = AppLogger.INFO_LEVEL;

        public void setLogLevel(String level) {
            switch (LogLevels.valueOf(level)) {
                case trace:
                    logLevel = AppLogger.TRACE_LEVEL;
                    break;
                case debug:
                    logLevel = AppLogger.DEBUG_LEVEL;
                    break;
                case info:
                    logLevel = AppLogger.INFO_LEVEL;
                    break;
                case warn:
                    logLevel = AppLogger.WARN_LEVEL;
                    break;
                case error:
                    logLevel = AppLogger.ERROR_LEVEL;
                    break;
                case fatal:
                    logLevel = AppLogger.FATAL_LEVEL;
                    break;
                default:
                    logLevel = AppLogger.UNKNOWN_LEVEL;
            }
        }

        public AppLogger(Class cname) {
            _log = LogFactory.getLog(cname);
        }

        public void trace(String s) {
            if (_log.isTraceEnabled()
                    && logLevel >= AppLogger.TRACE_LEVEL) {
                _log.trace(s);
            }
        }

        public void debug(String s) {
            if (_log.isDebugEnabled()
                    && logLevel >= AppLogger.DEBUG_LEVEL) {
                _log.trace(s);
            }
        }

        public void info(String s) {
            if (_log.isInfoEnabled()
                    && logLevel >= AppLogger.INFO_LEVEL) {
                _log.info(s);
            }
        }

        public void warn(String s) {
            if (_log.isWarnEnabled()
                    && logLevel >= AppLogger.WARN_LEVEL) {
                _log.warn(s);
            }
        }

        public void error(String s) {
            if (_log.isErrorEnabled()
                    && logLevel >= AppLogger.ERROR_LEVEL) {
                _log.error(s);
            }
        }

        public void fatal(String s) {
            if (_log.isFatalEnabled()
                    && logLevel >= AppLogger.FATAL_LEVEL) {
                _log.fatal(s);
            }
        }
    } // AppLogger
    // Instantiate the logger object
    public AppLogger _log = new AppLogger(SemanticSearch_portlet.class);

    // This portlet uses Aciont/Views enumerations in order to 
    // manage the different portlet modes and the corresponding 
    // view to display
    // You may override the current values with your own business
    // logic best identifiers and manage them through: jsp and java code
    // The jsp parameter PortletStatus will be the responsible of
    // portlet mode switching. This parameter will be read by
    // the processAction method who will select the proper view mode
    // registering again into 'PortletStatus' renderResponse parameter
    // the next view mode.
    // The default prortlet mode by default is: ACTION_INPUT (see ProcessAction)
    private enum Actions {

        ACTION_INPUT // Called before to show the INPUT view
        //,ACTION_SUBMIT     // Called after the user press the submit button   
        , ACTION_SEMANTIC_SEARCH_ALL_LANGUAGE, ACTION_QUERY_FROM_LANGUAGE_SUBJECT, ACTION_GET_MORE_INFO, ACTION_SELECT_LANGUAGE, ACTION_NUMBER_OF_PAGE,
        ACTION_GET_CITATIONS_GSCHOLAR,ACTION_GRAPH_RESOURCE
    }

    private enum Views {

        VIEW_INPUT // View containing application input fields
        // ,VIEW_SUBMIT     // View reporting the job submission     
        , VIEW_SEMANTIC_SEARCH_ALL_LANGUAGE, VIEW_QUERY_FROM_LANGUAGE_SUBJECT,
        VIEW_GET_MORE_INFO, VIEW_SELECT_LANGUAGE, VIEW_CITATIONS_GSCHOLAR
    }

    // The init values will be read form portlet.xml from <init-param> xml tag
    // This tag will be useful to setup defaults values for your own portlet
    class App_Init {

        String portletVersion;
        String logLevel;
        String bdiiHost;
        String wmsHost;
        String pxServerHost;
        String pxServerPort;
        String pxServerSecure;
        String pxRobotId;
        String pxRobotVO;
        String pxRobotRole;
        String pxUserProxy;
        String pxRobotRenewalFlag;
        String sciGwyAppId;
        String sciGwyUserTrackingDB_Hostname;
        String sciGwyUserTrackingDB_Username;
        String sciGwyUserTrackingDB_Password;
        String sciGwyUserTrackingDB_Database;
        String jobRequirements;
        String pilotScript;

        public App_Init() {
            portletVersion = logLevel = bdiiHost = wmsHost = pxServerHost = pxServerPort = pxServerSecure = pxRobotId = pxRobotVO = pxRobotRole = pxUserProxy = pxRobotRenewalFlag = sciGwyAppId = sciGwyUserTrackingDB_Hostname = sciGwyUserTrackingDB_Username = sciGwyUserTrackingDB_Password = sciGwyUserTrackingDB_Database = jobRequirements = pilotScript = "";
        }
    } // App_Init
    // Instanciate the App_Init object
    public App_Init appInit = new App_Init();

    // This object is used to store the values of portlet preferences
    // The init method will initialize their values with corresponding init_*
    // variables when the portlet first starts (see init_Preferences var).
    // Please notice that not all init_* variables have a corresponding pref_* value
    class App_Preferences {

        String logLevel;
        String bdiiHost;
        String wmsHost;
        String pxServerHost;
        String pxServerPort;
        String pxServerSecure;
        String pxRobotId;
        String pxRobotVO;
        String pxRobotRole;
        String pxUserProxy;
        String pxRobotRenewalFlag;
        String sciGwyAppId;
        String jobRequirements;
        String pilotScript;

        public App_Preferences() {
            logLevel = bdiiHost = wmsHost = pxServerHost = pxServerPort = pxServerSecure = pxRobotId = pxRobotVO = pxRobotRole = pxUserProxy = pxRobotRenewalFlag = sciGwyAppId = jobRequirements = pilotScript = "";
        }
    } // App_Preferences
    // Instanciate the App_Preferences object
    public App_Preferences appPreferences = new App_Preferences();

    //
    // Application input values
    //
    // Job submission values are collected inside a single object
    class App_Input {

        String search_word;
        String selected_language;
        String jobIdentifier;
        String nameSubject;
        String idResouce;
        String numberPage;
        String numRecordsForPage;
        String title_GS;
        String moreInfo;
       
        // Some user level information
        // must be stored as well
        String username;
        String timestamp;

        public App_Input() {
            search_word = selected_language = nameSubject = idResouce = numberPage = numRecordsForPage =
                    jobIdentifier = username = timestamp = title_GS = moreInfo="";
            // numberPage=0;
        }
    } // App_Input
    public String searched_word;
    public String searched_subject;
    public String language;
    // public String selected_page;
    public String selected_graph;
    
    public String selected_page = "";
    
    //public int numRecords;
    public int numTotRecords;
    public ArrayList arrayLanguageSubject;
    public ArrayList arrayCodesLanguage = new ArrayList();
    boolean firstAction = true;
    ArrayList virtuosoResourceList;
    String[] sArray;
    // Liferay user data
    // Classes below are used by this portlet code to get information
    // about the current user
    public ThemeDisplay themeDisplay;  // Liferay' ThemeDisplay variable
    public User user;                  // From ThemeDisplay get User data
    public String username;            // From User data the username        
    // Liferay portlet data        
    PortletSession portletSession;  // PorteltSession
    PortletContext portletContext;  // PortletContext
    public static String appServerPath;   // This variable stores the absolute path of the Web applications
    // Other misc valuse
    // (!) Pay attention that altough the use of the LS variable
    //     the replaceAll("\n","") has to be used 
    public String LS = System.getProperty("line.separator");
    // Users must have separated inputSandbox files
    // these file will be generated into /tmp directory
    // and prefixed with the format <timestamp>_<user>_*
    // The timestamp format is:
    public static final String tsFormat = "yyyyMMddHHmmss";

    //
    // Portlet Methods
    // 
    //
    // init
    //
    // The init method will be called when installing the portlet for the first time 
    // This is the right time to get default values from WEBINF/portlet.xml file
    // Those values will be assigned into parameters the first time the processAction
    // will be called thanks to the appPreferences object
    //
    @Override
    public void init()
            throws PortletException {
        // Load default values from portlet.xml              
        appInit.portletVersion = "" + getInitParameter("portletVersion");
        appInit.logLevel = "" + getInitParameter("logLevel");
        appInit.bdiiHost = "" + getInitParameter("bdiiHost");
        appInit.wmsHost = "" + getInitParameter("wmsHost");
        appInit.pxServerHost = "" + getInitParameter("pxServerHost");
        appInit.pxServerPort = "" + getInitParameter("pxServerPort");
        appInit.pxServerSecure = "" + getInitParameter("pxServerSecure");
        appInit.pxRobotId = "" + getInitParameter("pxRobotId");
        appInit.pxRobotVO = "" + getInitParameter("pxRobotVO");
        appInit.pxRobotRole = "" + getInitParameter("pxRobotRole");
        appInit.pxUserProxy = "" + getInitParameter("pxUserProxy");
        appInit.pxRobotRenewalFlag = "" + getInitParameter("pxRobotRenewalFlag");
        appInit.sciGwyAppId = "" + getInitParameter("sciGwyAppId");
        appInit.sciGwyUserTrackingDB_Hostname = "" + getInitParameter("sciGwyUserTrackingDB_Hostname");
        appInit.sciGwyUserTrackingDB_Username = "" + getInitParameter("sciGwyUserTrackingDB_Username");
        appInit.sciGwyUserTrackingDB_Password = "" + getInitParameter("sciGwyUserTrackingDB_Password");
        appInit.sciGwyUserTrackingDB_Database = "" + getInitParameter("sciGwyUserTrackingDB_Database");
        appInit.jobRequirements = "" + getInitParameter("jobRequirements");
        // WARNING: Although the pilot script field is considered here it is not
        // Possible to specify a bash script code inside thie init_pilotScript
        // xml field. The content of pilot script must be inserted manually upon
        // the portlet installation through its configuration pane.        
        appInit.pilotScript = "" + getInitParameter("pilotScript");
        appInit.pilotScript = appInit.pilotScript.replaceAll("\r", "");

        // Assigns the log level      
        _log.setLogLevel(appInit.logLevel);

        // Show loaded values into log
        _log.info(
                LS + "Loading default values "
                + LS + "-----------------------"
                + LS + "init_portletVersion               : '" + appInit.portletVersion + "'"
                + LS + "init_logLevel                     : '" + appInit.logLevel + "'"
                + LS + "init_bdiiHost                     : '" + appInit.bdiiHost + "'"
                + LS + "init_wmsHost                      : '" + appInit.wmsHost + "'"
                + LS + "init_pxServerHost                 : '" + appInit.pxServerHost + "'"
                + LS + "init_pxServerPort                 : '" + appInit.pxServerPort + "'"
                + LS + "init_pxServerSecure               : '" + appInit.pxServerSecure + "'"
                + LS + "init_pxRobotId                    : '" + appInit.pxRobotId + "'"
                + LS + "init_pxRobotVO                    : '" + appInit.pxRobotVO + "'"
                + LS + "init_pxRobotRole                  : '" + appInit.pxRobotRole + "'"
                + LS + "init_pxUserProxy                  : '" + appInit.pxUserProxy + "'"
                + LS + "init_pxRobotRenewalFlag           : '" + appInit.pxRobotRenewalFlag + "'"
                + LS + "init_sciGwyAppId                  : '" + appInit.sciGwyAppId + "'"
                + LS + "init_sciGwyUserTrackingDB_Hostname: '" + appInit.sciGwyUserTrackingDB_Hostname + "'"
                + LS + "init_sciGwyUserTrackingDB_Username: '" + appInit.sciGwyUserTrackingDB_Username + "'"
                + LS + "init_sciGwyUserTrackingDB_Password: '" + appInit.sciGwyUserTrackingDB_Password + "'"
                + LS + "init_sciGwyUserTrackingDB_Database: '" + appInit.sciGwyUserTrackingDB_Database + "'"
                + LS + "init_jobRequirements              : '" + appInit.jobRequirements + "'"
                + LS + "init_pilotScript                  : '" + appInit.pilotScript + "'"
                + LS
                + LS + "!WARNING: Although the pilot script field is considered into the portlet.xml"
                + LS + "it is not possible to specify a bash script code inside the init_pilotScript"
                + LS + "xml' field. The content of the pilot script must be inserted manually upon"
                + LS + "the portlet installation through its configuration pane."
                + LS);
    } // init

    //
    // processAction
    //
    // This method allows the portlet to process an action request; this method is normally
    // called upon each user interaction (a submit button inside a jsp' <form statement)
    //
    @Override
    public void processAction(ActionRequest request, ActionResponse response)
            throws PortletException, IOException {
        _log.info("calling processAction ...");

        // Determine the username
        themeDisplay = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY);
        user = themeDisplay.getUser();
        username = user.getScreenName();
        _log.info("User: '" + user + "'");


        // int numRecords = 0;
        //   String[] sArray=null;
        

        // Determine the application pathname                
        portletSession = request.getPortletSession();
        portletContext = portletSession.getPortletContext();
        appServerPath = portletContext.getRealPath("/");
        _log.info("Web Application path: '" + appServerPath + "'");

        // Determine the current portlet mode and forward this state to the response
        // Accordingly to JSRs168/286 the standard portlet modes are:
        // VIEW, EDIT, HELP
        PortletMode mode = request.getPortletMode();
        response.setPortletMode(request.getPortletMode());

        // Switch among different portlet modes: VIEW, EDIT, HELP
        // Custom modes are not covered by this template
        if (mode.equals(PortletMode.VIEW)) {
            try {
                // The VIEW mode is the normal portlet mode where normal portlet
                // content will be shown to the user
                _log.info("Portlet mode: VIEW");

                // The actionStatus value will be taken from the calling jsp file
                // through the 'PortletStatus' parameter; the corresponding
                // VIEW mode will be stored registering the portlet status
                // as render parameter. See the call to setRenderParameter
                // If the actionStatus parameter is null or empty the default
                // action will be the ACTION_INPUT (input form)
                // This happens the first time the portlet is shown
                // The PortletStatus variable is managed by jsp and this java code
                String actionStatus = request.getParameter("PortletStatus");
                // Assigns the default ACTION
                if (null == actionStatus
                        || actionStatus.equals("")) {
                    actionStatus = "" + Actions.ACTION_INPUT;
                }

                // Different actions will be performed accordingly to the
                // different possible statuses
                switch (Actions.valueOf(actionStatus)) {
                    case ACTION_INPUT:
                        _log.info("Got action: 'ACTION_INPUT'");

                        // Create the appInput object
                        App_Input appInput = new App_Input();
                        //SemanticQuery.stopQuery=true;
                        // SemanticQuery.getNumRecords("");






                        //SemanticQuery.stopQuery();

                        // Assign the correct view
                        response.setRenderParameter("PortletStatus", "" + Views.VIEW_INPUT);
                        break;





                    case ACTION_SEMANTIC_SEARCH_ALL_LANGUAGE:
                        _log.info("Got action: 'ACTION_SEMANTIC_SEARCH_ALL_LANGUAGE'");

                        // Get current preference values
                        getPreferences(request, null);

                        // Create the appInput object
                        appInput = new App_Input();

                        // Stores the user submitting the job
                        appInput.username = username;
                        //SemanticQuery.stopQuery=false;
                        // Determine the submissionTimeStamp                    
                        SimpleDateFormat dateFormat = new SimpleDateFormat(tsFormat);
                        String timestamp = dateFormat.format(Calendar.getInstance().getTime());
                        appInput.timestamp = timestamp;


                        // Process input fields and files to upload
                        getInputForm(request, appInput);

                        
                        if (appInput.moreInfo == null) {
                                appInput.moreInfo = "NO";
                        }
                        
                
                        //  searched_word=appInput.search_word;

                        // numRecords=SemanticQuery.getNumRecords(searched_word);

                        //  numRecords=SemanticQuery.getNumRecords( appInput.search_word);
                        //numTotRecords = SemanticQuery.getNumTotalRecords();

                        // sArray = (String[]) SemanticQuery.queryVirtuosoResource(appInput.search_word,selected_page).toArray(new String[SemanticQuery.arrayVirtuosoResource.size()]);;

                        
                        System.out.println("MOREINFO ACTION: "+appInput.moreInfo);
                        
                        if (!appInput.moreInfo.equals("OK")){


                        if (appInput.numberPage == null || appInput.numberPage == "") {
                            selected_page = "1";


                            virtuosoResourceList = SemanticQuery.queryVirtuosoResource(appInput.search_word, selected_page);



                            sArray = (String[]) virtuosoResourceList.toArray(new String[SemanticQuery.arrayVirtuosoResource.size()]);
                        } else {
                            selected_page = appInput.numberPage;
                            //selected_page="2";


                            ArrayList newArray = SemanticQuery.queryVirtuosoResource(appInput.search_word, selected_page);


                            System.out.println("SIZE NUOVO ARRAY: " + newArray.size());

                            for (int i = 0; i < newArray.size(); i++) {
                                virtuosoResourceList.add(newArray.get(i));
                            }


                            System.out.println("SIZE ARRAY DOPPI: " + virtuosoResourceList.size());


                            // virtuosoResourceList=SemanticQuery.queryVirtuosoResource(appInput.search_word, selected_page);
                            sArray = (String[]) virtuosoResourceList.toArray(new String[SemanticQuery.arrayVirtuosoResource.size()]);
                        }
                        
                        }
                        else
                            System.out.println("NON FACCIO LA QUERY ci sono elementi --->"+sArray.length);
                        
                        
                        response.setRenderParameter("PortletStatus", "" + Views.VIEW_SEMANTIC_SEARCH_ALL_LANGUAGE);
                        response.setRenderParameter("searched_word", appInput.search_word);
                        response.setRenderParameter("selected_page", selected_page);
                        response.setRenderParameter("moreInfo", appInput.moreInfo);

                        // response.setRenderParameter("numRecords", String.valueOf(numRecords));
                        // String[] sArray = (String[])SemanticQuery.queryVirtuosoResource(appInput.search_word,selected_page).toArray(new String[SemanticQuery.arrayVirtuosoResource.size()]);
                        response.setRenderParameter("arrayVirtuosoResource", sArray);


                        break;
                    case ACTION_QUERY_FROM_LANGUAGE_SUBJECT:
                        _log.info("Got action: 'ACTION_QUERY_FROM_LANGUAGE_SUBJECT'");

                        // Get current preference values
                        getPreferences(request, null);

                        // Create the appInput object
                        appInput = new App_Input();

                        // Stores the user submitting the job
                        appInput.username = username;
                        appInput.selected_language = language;

                        arrayCodesLanguage = SemanticQuery.getCodesLanguage(language);
                        // Process input fields and files to upload
                        getInputForm(request, appInput);

                        searched_subject = appInput.nameSubject;





                        SemanticQuery.getResourceFromSubject(appInput.nameSubject, arrayCodesLanguage);




                        // Send the jobIdentifier and assign the correct view                    
                        response.setRenderParameter("PortletStatus", "" + Views.VIEW_QUERY_FROM_LANGUAGE_SUBJECT);

                        break;

//                    case ACTION_NUMBER_OF_PAGE:
//                        _log.info("Got action: 'ACTION_NUMBER_OF_PAGE'");
//
//                        // Get current preference values
//                        getPreferences(request, null);
//
//                        // Create the appInput object
//                        appInput = new App_Input();
//
//                        // Stores the user submitting the job
//                        appInput.username = username;
//
//
//                        // Process input fields and files to upload
//                        getInputForm(request, appInput);
//
//
//
//
//                        if (appInput.numberPage == null) {
//                            selected_page = "1";
//                            SemanticQuery.queryVirtuosoResource(appInput.search_word, selected_page);
//                        } else {
//                            selected_page = appInput.numberPage;
//                            SemanticQuery.queryVirtuosoResource(appInput.search_word, selected_page);
//                        }
//
//                        response.setRenderParameter("searched_word", appInput.search_word);
//                        response.setRenderParameter("selected_page", selected_page);
//                        response.setRenderParameter("numRecords", String.valueOf(appInput.numRecordsForPage));
//                        sArray = (String[]) SemanticQuery.arrayVirtuosoResource.toArray(new String[SemanticQuery.arrayVirtuosoResource.size()]);
//                        response.setRenderParameter("arrayVirtuosoResource", sArray);
//
//                        response.setRenderParameter("PortletStatus", "" + Views.VIEW_SEMANTIC_SEARCH_ALL_LANGUAGE);
//
//                        break;
                    case ACTION_GET_MORE_INFO:
                        _log.info("Got action: 'ACTION_GET_MORE_INFO'");

                        // Get current preference values
                        getPreferences(request, null);

                        // Create the appInput object
                        appInput = new App_Input();

                        // Stores the user submitting the job
                        appInput.username = username;

                        // Process input fields and files to upload
                        getInputForm(request, appInput);

                        response.setRenderParameter("idResource", appInput.idResouce);


                        response.setRenderParameter("title_GS", appInput.title_GS);
                        _log.info("Got action: 'ACTION_GET_MORE_INFO TITLEEEEEEEEEEEEE'" + appInput.title_GS);

                        String[] info_GS = executeCommand(appInput.title_GS);


                        response.setRenderParameter("info_GS", info_GS);
                        response.setRenderParameter("searched_word", appInput.search_word);

                        // Send the jobIdentifier and assign the correct view                    
                        response.setRenderParameter("PortletStatus", "" + Views.VIEW_GET_MORE_INFO);

                        break;

                    case ACTION_GET_CITATIONS_GSCHOLAR:
                        // Get current preference values
                        _log.info("Got action: 'ACTION_CITATIONS_GS'");
                        // Create the appInput object
                        appInput = new App_Input();

                        // Stores the user submitting the job
                        appInput.username = username;

                        // Process input fields and files to upload
                        getInputForm(request, appInput);

                        _log.info("Got action: 'ACTION_CITATIONS_GS'");

                        // response.setRenderParameter("title_GS", appInput.title_GS);
                        response.setRenderParameter("title_GS", appInput.title_GS);
                        info_GS = executeCommand(appInput.title_GS);


                        response.setRenderParameter("info_GS", info_GS);
                        response.setRenderParameter("PortletStatus", "" + Views.VIEW_CITATIONS_GSCHOLAR);




                        break;

                    case ACTION_SELECT_LANGUAGE:
                        _log.info("Got action: 'ACTION_SELECT_LANGUAGE'");

                        // Get current preference values
                        getPreferences(request, null);

                        // Create the appInput object
                        appInput = new App_Input();

                        // Stores the user submitting the job
                        appInput.username = username;

                        // Process input fields and files to upload
                        getInputForm(request, appInput);

                        arrayCodesLanguage = SemanticQuery.getCodesLanguage(appInput.selected_language);


                        language = appInput.selected_language;

                        arrayLanguageSubject = SemanticQuery.getSubjectFromCodeLanguage(arrayCodesLanguage);

                        // Send the jobIdentifier and assign the correct view                    
                        response.setRenderParameter("PortletStatus", "" + Views.VIEW_SELECT_LANGUAGE);
                        break;
                        
                        case ACTION_GRAPH_RESOURCE:
                        _log.info("Got action: 'ACTION_GRAPH_RESOURCE'");

                        // Get current preference values
                        getPreferences(request, null);

                        // Create the appInput object
                        appInput = new App_Input();

                        // Stores the user submitting the job
                        appInput.username = username;

                        // Process input fields and files to upload
                        getInputForm(request, appInput);

                       
                        response.setRenderParameter("PortletStatus", "" + Views.VIEW_SELECT_LANGUAGE);
                        break;
                    default:
                        _log.info("Unhandled action: '" + actionStatus + "'");
                        response.setRenderParameter("PortletStatus", "" + Views.VIEW_INPUT);
                }
            } catch (QueryEvaluationException ex) {
                Logger.getLogger(SemanticSearch_portlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (RepositoryException ex) {
                Logger.getLogger(SemanticSearch_portlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (MalformedQueryException ex) {
                Logger.getLogger(SemanticSearch_portlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (mode.equals(PortletMode.HELP)) {
            // The HELP mode used to give portlet usage HELP to the user
            // This code will be called after the call to doHelp method                         
            _log.info("Portlet mode: HELP");
        } else if (mode.equals(PortletMode.EDIT)) {
            // The EDIT mode is used to view/setup portlet preferences
            // This code will be called after the user sends the actionURL 
            // generated by the doEdit method 
            // The code below just stores new preference values
            _log.info("Portlet mode: EDIT");

//            // new preferences will takem from edit.jsp
//            String newpref_logLevel = "" + request.getParameter("pref_logLevel");
//            String newpref_bdiiHost = "" + request.getParameter("pref_bdiiHost");
//            String newpref_wmsHost = "" + request.getParameter("pref_wmsHost");
//            String newpref_pxServerHost = "" + request.getParameter("pref_pxServerHost");
//            String newpref_pxServerPort = "" + request.getParameter("pref_pxServerPort");
//            String newpref_pxServerSecure = "" + request.getParameter("pref_pxServerSecure");
//            String newpref_pxRobotId = "" + request.getParameter("pref_pxRobotId");
//            String newpref_pxRobotVO = "" + request.getParameter("pref_pxRobotVO");
//            String newpref_pxRobotRole = "" + request.getParameter("pref_pxRobotRole");
//            String newpref_pxRobotRenewalFlag = "" + request.getParameter("pref_pxRobotRenewalFlag");
//            String newpref_pxUserProxy = "" + request.getParameter("pref_pxUserProxy");
//            String newpref_sciGwyAppId = "" + request.getParameter("pref_sciGwyAppId");
//            String newpref_jobRequirements = "" + request.getParameter("pref_jobRequirements");
//            String newpref_pilotScript = "" + request.getParameter("pref_pilotScript");
//            newpref_pilotScript = newpref_pilotScript.replaceAll("\r", "");
//
//            // Show preference values changes
//            _log.info(
//                    LS + "variable name          : 'Old Value' -> 'New value'"
//                    + LS + "---------------------------------------------------"
//                    + LS + "pref_logLevel          : '" + appPreferences.logLevel + "' -> '" + newpref_logLevel + "'"
//                    + LS + "pref_bdiiHost          : '" + appPreferences.bdiiHost + "' -> '" + newpref_bdiiHost + "'"
//                    + LS + "pref_wmsHost           : '" + appPreferences.wmsHost + "' -> '" + newpref_wmsHost + "'"
//                    + LS + "pref_pxServerHost      : '" + appPreferences.pxServerHost + "' -> '" + newpref_pxServerHost + "'"
//                    + LS + "pref_pxServerPort      : '" + appPreferences.pxServerPort + "' -> '" + newpref_pxServerPort + "'"
//                    + LS + "pref_pxServerSecure    : '" + appPreferences.pxServerSecure + "' -> '" + newpref_pxServerSecure + "'"
//                    + LS + "pref_pxRobotId         : '" + appPreferences.pxRobotId + "' -> '" + newpref_pxRobotId + "'"
//                    + LS + "pref_pxRobotVO         : '" + appPreferences.pxRobotVO + "' -> '" + newpref_pxRobotVO + "'"
//                    + LS + "pref_pxRobotRole       : '" + appPreferences.pxRobotRole + "' -> '" + newpref_pxRobotRole + "'"
//                    + LS + "pref_pxRobotRenewalFlag: '" + appPreferences.pxRobotRenewalFlag + "' -> '" + newpref_pxRobotRenewalFlag + "'"
//                    + LS + "pref_pxUserProxy       : '" + appPreferences.pxUserProxy + "' -> '" + newpref_pxUserProxy + "'"
//                    + LS + "pref_SciGwyAppId       : '" + appPreferences.sciGwyAppId + "' -> '" + newpref_sciGwyAppId + "'"
//                    + LS + "pref_jobRequirements   : '" + appPreferences.jobRequirements + "' -> '" + newpref_jobRequirements + "'"
//                    + LS + "pref_pilotScript       : '" + appPreferences.pilotScript + "' -> '" + newpref_pilotScript + "'"
//                    + LS);
//
//            // The code below stores the portlet preference values
//            PortletPreferences prefs = request.getPreferences();
//            prefs.setValue("pref_logLevel", newpref_logLevel);
//            prefs.setValue("pref_bdiiHost", newpref_bdiiHost);
//            prefs.setValue("pref_wmsHost", newpref_wmsHost);
//            prefs.setValue("pref_pxServerHost", newpref_pxServerHost);
//            prefs.setValue("pref_pxServerPort", newpref_pxServerPort);
//            prefs.setValue("pref_pxServerSecure", newpref_pxServerSecure);
//            prefs.setValue("pref_pxRobotId", newpref_pxRobotId);
//            prefs.setValue("pref_pxRobotVO", newpref_pxRobotVO);
//            prefs.setValue("pref_pxRobotRole", newpref_pxRobotRole);
//            prefs.setValue("pref_pxRobotRenewalFlag", newpref_pxRobotRenewalFlag);
//            prefs.setValue("pref_pxUserProxy", newpref_pxUserProxy);
//            prefs.setValue("pref_sciGwyAppId", newpref_sciGwyAppId);
//            prefs.setValue("pref_jobRequirements", newpref_jobRequirements);
//            prefs.setValue("pref_pilotScript", newpref_pilotScript);
//            prefs.store();
//
//            // The pilot script file have to be updated
//            storeString(appServerPath + "/WEB-INF/job/pilot_script.sh", newpref_pilotScript);
//
//            // Determine the next view mode (return to the input pane)
//            response.setPortletMode(PortletMode.VIEW);
        } else {
            // Unsupported portlet modes come here
            _log.warn("Custom portlet mode: '" + mode.toString() + "'");
        }
    } // processAction

    //
    // Method responsible to show portlet content to the user accordingly to the current view mode
    //
    @Override
    protected void doView(RenderRequest request, RenderResponse response)
            throws PortletException, IOException {
        _log.info("calling doView ...");
        response.setContentType("text/html");

        // Determine the application pathname                
        portletSession = request.getPortletSession();

        portletContext = portletSession.getPortletContext();
        appServerPath = portletContext.getRealPath("/");
        _log.info("Web Application path: '" + appServerPath + "'");

        // Switch among supported views; the currentView is determined by the
        // portlet render parameter value stored into PortletStatus identifier
        // this value has been assigned by the actionStatus or it will be 
        // null in case the doView method will be called without a
        // previous processAction call; in such a case the default VIEW_INPIUT
        // will be selected.
        //The PortletStatus variable is managed by jsp and this java code
        String currentView = request.getParameter("PortletStatus");
        if (null == currentView
                || currentView.equals("")) {
            currentView = "" + Views.VIEW_INPUT;
        }

        // Different actions will be performed accordingly to the
        // different possible view modes
        switch (Views.valueOf(currentView)) {
            // The following code is responsible to call the proper jsp file
            // that will provide the correct portlet interface
            case VIEW_INPUT: {
                _log.info("VIEW_INPUT Selected ...");
                PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/input.jsp");
                dispatcher.include(request, response);
            }
            break;





            case VIEW_SEMANTIC_SEARCH_ALL_LANGUAGE: {

                _log.info("VIEW_SEMANTIC_SEARCH_ALL_LANGUAGE Selected ...");


                // request.setAttribute("searched_word", searched_word);
                //request.setAttribute("selected_page",selected_page);
                //request.setAttribute("numRecords",numRecords);
                //  request.setAttribute("numTotRecords", numTotRecords);
                // request.setAttribute("arrayVirtuosoResource",sArray);


                // request.setAttribute("arrayVirtuosoResource", SemanticQuery.arrayVirtuosoResource);

                //   request.setAttribute("arrayVirtuosoResource", virtuosoResourceList);

                PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/resultFromAllLanguage.jsp");
                dispatcher.include(request, response);

                //  firstAction = false;




            }
            break;
            case VIEW_GET_MORE_INFO: {
                _log.info("VIEW_GET_MORE_INFO Selected ...");
                String idResource = request.getParameter("idResource");
                request.setAttribute("idResource", idResource);
                
                 String searched_word = request.getParameter("search_word");
                request.setAttribute("search_word", searched_word);
                
                PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/viewDetailsResource.jsp");
                dispatcher.include(request, response);
            }
            break;
            case VIEW_QUERY_FROM_LANGUAGE_SUBJECT: {
                _log.info("VIEW_QUERY_FROM_LANGUAGE_SUBJECT Selected ...");
                request.setAttribute("searched_subject", searched_subject);
                request.setAttribute("language", language);
                request.setAttribute("arrayCodesLanguage", arrayCodesLanguage);
                request.setAttribute("arrayResourceFromSubject", SemanticQuery.arrayResourceFromSubject);
                request.setAttribute("arrayLanguageSubject", arrayLanguageSubject);

                PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/resultFromLanguageSubject.jsp");
                dispatcher.include(request, response);
            }
            break;
            case VIEW_SELECT_LANGUAGE: {
                _log.info("VIEW_SELECT_LANGUAGE Selected ...");


                request.setAttribute("language", language);
                request.setAttribute("arrayCodesLanguage", arrayCodesLanguage);
                request.setAttribute("arrayLanguageSubject", arrayLanguageSubject);

                PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/selectLanguage.jsp");
                dispatcher.include(request, response);
            }
            break;
            case VIEW_CITATIONS_GSCHOLAR: {
                _log.info("VIEW_CITATIONS_GSCHOLAR Selected ...");


                PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/viewCitationsGS.jsp");
                dispatcher.include(request, response);
            }
            break;




            default:
                _log.info("Unknown view mode: " + currentView.toString());
        } // switch            
    } // doView

    //
    // doEdit
    //
    // This methods prepares an actionURL that will be used by edit.jsp file into a <input ...> form
    // As soon the user press the action button the processAction will be called and the portlet mode
    // will be set as EDIT.
//    @Override
//    public void doEdit(RenderRequest request, RenderResponse response)
//            throws PortletException, IOException {
//        response.setContentType("text/html");
//
//        // Get current preference values
//        getPreferences(null, request);
//
//        // ActionURL and the current preference value will be passed to the edit.jsp
//        PortletURL prefURL = response.createActionURL();
//        request.setAttribute("prefURL", prefURL.toString());
//        request.setAttribute("pref_logLevel", appPreferences.logLevel);
//        request.setAttribute("pref_bdiiHost", appPreferences.bdiiHost);
//        request.setAttribute("pref_wmsHost", appPreferences.wmsHost);
//        request.setAttribute("pref_pxServerHost", appPreferences.pxServerHost);
//        request.setAttribute("pref_pxServerPort", appPreferences.pxServerPort);
//        request.setAttribute("pref_pxServerSecure", appPreferences.pxServerSecure);
//        request.setAttribute("pref_pxRobotId", appPreferences.pxRobotId);
//        request.setAttribute("pref_pxRobotVO", appPreferences.pxRobotVO);
//        request.setAttribute("pref_pxRobotRole", appPreferences.pxRobotRole);
//        request.setAttribute("pref_pxRobotRenewalFlag", appPreferences.pxRobotRenewalFlag);
//        request.setAttribute("pref_pxUserProxy", appPreferences.pxUserProxy);
//        request.setAttribute("pref_sciGwyAppId", appPreferences.sciGwyAppId);
//        request.setAttribute("pref_jobRequirements", appPreferences.jobRequirements);
//        request.setAttribute("pref_pilotScript", appPreferences.pilotScript);
//
//        // The edit.jsp will be the responsible to show/edit the current preference values
//        PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/edit.jsp");
//        dispatcher.include(request, response);
//    } // doEdit

    //
    // doHelp
    //
    // This method just calls the jsp responsible to show the portlet information
    @Override
    public void doHelp(RenderRequest request, RenderResponse response)
            throws PortletException, IOException {
        response.setContentType("text/html");
        request.setAttribute("portletVersion", appInit.portletVersion);
        PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/help.jsp");
        dispatcher.include(request, response);
    } // doHelp

    //
    // updateString
    //
    // This method takes as input a filename and will transfer its
    // content inside a String variable
    private String updateString(String file) throws IOException {
        String line = null;
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader reader = new BufferedReader(new FileReader(file));
        while ((line = reader.readLine()) != null) {
            stringBuilder.append(line);
            stringBuilder.append(LS);
        }
        return stringBuilder.toString();
    }

    //
    // storeString
    //
    // This method will transfer the content of a given String into
    // a given filename
    private void storeString(String fileName, String fileContent) throws IOException {
        BufferedWriter writer = new BufferedWriter(new FileWriter(fileName));
        writer.write(fileContent);
        writer.close();
    }

    //
    // getInputForm
    //
    // The use of upload file controls needs the use of "multipart/form-data"
    // form type. With this kind of input form it is necessary to process 
    // each item of the action request manually
    //
    // All form' input items are identified by the 'name' input property
    // inside the jsp file
    private enum inputControlsIds {

        file_inputFile // Input file textarea 
        , inputFile // Input file input file
        , JobIdentifier     // User defined Job identifier
    };
    //
    // getInputForm (method)
    //

    public void getInputForm(ActionRequest request, App_Input appInput) {
        if (PortletFileUpload.isMultipartContent(request)) {
            try {
                FileItemFactory factory = new DiskFileItemFactory();
                PortletFileUpload upload = new PortletFileUpload(factory);
                List items = upload.parseRequest(request);
                File repositoryPath = new File("/tmp");
                DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
                diskFileItemFactory.setRepository(repositoryPath);
                Iterator iter = items.iterator();
                String logstring = "";
                
                while (iter.hasNext()) {
                    FileItem item = (FileItem) iter.next();
                    String fieldName = item.getFieldName();
                    String fileName = item.getName();
                    String contentType = item.getContentType();
                    boolean isInMemory = item.isInMemory();
                    long sizeInBytes = item.getSize();
                    // Prepare a log string with field list
                    logstring += LS + "field name: '" + fieldName + "' - '" + item.getString() + "'";
                    switch (inputControlsIds.valueOf(fieldName)) {

                        case JobIdentifier:
                            appInput.jobIdentifier = item.getString();
                            break;
                        default:
                            _log.warn("Unhandled input field: '" + fieldName + "' - '" + item.getString() + "'");
                    } // switch fieldName                                                   
                } // while iter.hasNext()   
                _log.info(
                        LS + "Reporting"
                        + LS + "---------"
                        + LS + logstring
                        + LS);
            } // try
            catch (Exception e) {
                _log.info("Caught exception while processing files to upload: '" + e.toString() + "'");
            }
        } // The input form do not use the "multipart/form-data" 
        else {
            // Retrieve from the input form the given application values
            appInput.search_word = (String) request.getParameter("search_word");
            appInput.jobIdentifier = (String) request.getParameter("JobIdentifier");
            appInput.nameSubject = (String) request.getParameter("nameSubject");

            appInput.idResouce = (String) request.getParameter("idResource");
            appInput.selected_language = (String) request.getParameter("selLanguage");
            appInput.numberPage = (String) request.getParameter("numberOfPage");
            appInput.numRecordsForPage = (String) request.getParameter("numberOfRecords");
            appInput.title_GS = (String) request.getParameter("title_GS");
            appInput.moreInfo = (String) request.getParameter("moreInfo");
            if (appInput.selected_language == null) {
                appInput.selected_language = (String) request.getParameter("nameLanguageDefault");
            }
        } // ! isMultipartContent

        // Show into the log the taken inputs
        _log.info(
                LS + "Taken input parameters:"
                + LS + "-----------------------"
                + LS + "Search Word: '" + appInput.search_word + "'"
                + LS + "jobIdentifier: '" + appInput.jobIdentifier + "'"
                + LS + "subject: '" + appInput.nameSubject + "'"
                + LS + "idResource: '" + appInput.idResouce + "'"
                + LS + "language selected: '" + appInput.selected_language + "'"
                + LS + "number page selected: '" + appInput.numberPage + "'"
                + LS + "number record for page: '" + appInput.numRecordsForPage + "'"
                + LS + "moreInfo: '" + appInput.moreInfo + "'"
                + LS);
    } // getInputForm 

    //
    // processInputFile
    //
    // This method is called when the user specifies a input file to upload
    // the file will be saved first into /tmp directory and then its content
    // stored into the corresponding String variable
    // Before to submit the job the String value will be stored in the 
    // proper job inputSandbox file
    //
    // getPreferences
    //
    // This method retrieves current portlet preference values and it can
    // be called by both processAction or doView methods
    private void getPreferences(ActionRequest actionRequest, RenderRequest renderRequest) {
        PortletPreferences prefs = null;
        if (null != actionRequest) {
            prefs = actionRequest.getPreferences();
        } else if (null != renderRequest) {
            prefs = renderRequest.getPreferences();
        } else {
            _log.warn("Both render request and action request are null");
        }

        if (null != prefs) {
            appPreferences.logLevel = "" + prefs.getValue("pref_logLevel", appInit.logLevel);
            appPreferences.bdiiHost = "" + prefs.getValue("pref_bdiiHost", appInit.bdiiHost);
            appPreferences.wmsHost = "" + prefs.getValue("pref_wmsHost", appInit.wmsHost);
            appPreferences.pxServerHost = "" + prefs.getValue("pref_pxServerHost", appInit.pxServerHost);
            appPreferences.pxServerPort = "" + prefs.getValue("pref_pxServerPort", appInit.pxServerPort);
            appPreferences.pxServerSecure = "" + prefs.getValue("pref_pxServerSecure", appInit.pxServerSecure);
            appPreferences.pxRobotId = "" + prefs.getValue("pref_pxRobotId", appInit.pxRobotId);
            appPreferences.pxRobotVO = "" + prefs.getValue("pref_pxRobotVO", appInit.pxRobotVO);
            appPreferences.pxRobotRole = "" + prefs.getValue("pref_pxRobotRole", appInit.pxRobotRole);
            appPreferences.pxRobotRenewalFlag = "" + prefs.getValue("pref_pxRobotRenewalFlag", appInit.pxRobotRenewalFlag);
            appPreferences.pxUserProxy = "" + prefs.getValue("pref_pxUserProxy", appInit.pxUserProxy);
            appPreferences.sciGwyAppId = "" + prefs.getValue("pref_sciGwyAppId", appInit.sciGwyAppId);
            appPreferences.jobRequirements = "" + prefs.getValue("pref_jobRequirements", appInit.jobRequirements);
            appPreferences.pilotScript = "" + prefs.getValue("pref_pilotScript", appInit.pilotScript);

            // Assigns the log level      
            _log.setLogLevel(appPreferences.logLevel);

            // Show preference values into log
            _log.info(
                    LS + "Preference values:"
                    + LS + "------------------"
                    + LS + "pref_logLevel          : '" + appPreferences.logLevel + "'"
                    + LS + "pref_bdiiHost          : '" + appPreferences.bdiiHost + "'"
                    + LS + "pref_wmsHost           : '" + appPreferences.wmsHost + "'"
                    + LS + "pref_pxServerHost      : '" + appPreferences.pxServerHost + "'"
                    + LS + "pref_pxServerPort      : '" + appPreferences.pxServerPort + "'"
                    + LS + "pref_pxServerSecure    : '" + appPreferences.pxServerSecure + "'"
                    + LS + "pref_pxRobotId         : '" + appPreferences.pxRobotId + "'"
                    + LS + "pref_pxRobotVO         : '" + appPreferences.pxRobotVO + "'"
                    + LS + "pref_pxRobotRole       : '" + appPreferences.pxRobotRole + "'"
                    + LS + "pref_pxUserProxy       : '" + appPreferences.pxUserProxy + "'"
                    + LS + "pref_pxRobotRenewalFlag: '" + appPreferences.pxRobotRenewalFlag + "'"
                    + LS + "pref_sciGwyAppId       : '" + appPreferences.sciGwyAppId + "'"
                    + LS + "pref_jobRequirements   : '" + appPreferences.jobRequirements + "'"
                    + LS + "pref_pilotScript       : '" + appPreferences.pilotScript + "'"
                    + LS); // _log.info; show loaded preference values
        } // if
    } // getPreferences

    private String[] executeCommand(String title) {


        System.out.println("TITLE ANALIZE: " + title);

        String[] command = new String[]{"python", appServerPath + "/WEB-INF/job/scholar.py", "-c 1", "--phrase", title};

        /*
         * System.out.println("COMMAND: "); for (int j=0;j<command.length;j++)
         * System.out.print(command[j]);
         */

        String[] info_GS = new String[6];
        String url = "";
        String versions = "";
        String versions_list = "";
        String citations = "";
        String citations_list = "";
        String year = "";




        Process p;
        boolean control = false;
        try {
            p = Runtime.getRuntime().exec(command);

            p.waitFor();
            BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
            System.out.println("READER: " +reader); 
            String line = "";
            condition:
            while ((line = reader.readLine()) != null) {

                
                System.out.println("ECCO: "+line.split(" ")[0]);
                control = true;
                System.out.println("LINE: "+ line);


                if (line.contains("Title")) {
                    String title_GS = line.split("Title ")[1];
                    System.out.println("Title_GS: " + title_GS);


                    String newTitle_GS = title_GS.toUpperCase().replace(" ", "").replace("'", "").replace("?", "").replace(".", "");

//                    char c1 = '%u2019';
//                    for (int i = 0; i < title.length(); i++) {
//                        char l = title.charAt(i);
//                        System.out.println("CHAR: " + l);
//                        if (l == c1) {
//                            System.out.println("BECCATO APICE");
//                        }
//
//                    }
                    String tt1=new String(title.getBytes("ISO-8859-1"), "UTF-8");
                     System.out.println("******TTTTTT UTF8: "+tt1);

                    String newTitle_CHAIN = tt1.toUpperCase().replace(" ", "").replace("'", "").replace("?", "").replace(".", "");
                    System.out.println("Title_GS: " + newTitle_GS + "\nTITLE_CH: " + newTitle_CHAIN);

                    if (!newTitle_GS.equals(newTitle_CHAIN)) {

                        System.out.println("*******TITOLO NOT FOUND IN GOOGLE SCHOLAR********");

                        control = false;
                        break condition;

                    }
                }
                
                 System.out.println("VALORE del control "+control);
                if (line.contains("URL")) {
                    url = line.split("URL ")[1];
                    System.out.println("URL: " + url);
                    info_GS[0] = url;
                }

                if (line.contains("Versions") && !line.contains("Versions list")) {
                    versions = line.split("Versions ")[1];
                     System.out.println("Versions: " + versions);
                    info_GS[1] = versions;
                }

                if (line.contains("Versions list")) {
                    versions_list = line.split("Versions list ")[1];
                    System.out.println("Versions_list: " + versions_list);
                    info_GS[2] = versions_list;
                }

                if (line.contains("Citations") && !line.contains("Citations list")) {

                    citations = line.split("Citations ")[1];
                    System.out.println("NUM CIT: " + citations);
                    info_GS[3] = citations;

                }

                if (line.contains("Citations list")) {

                    citations_list = line.split("Citations list ")[1];
                    System.out.println("URL CIT: " + citations_list);
                    info_GS[4] = citations_list;

                }

                if (line.contains("Year")) {

                    year = line.split("Year ")[1];
                    System.out.println("Year: " + year);
                    info_GS[5] = year;

                }


            }
            if (!control) {

                System.out.println("VALORE del control dentro !control"+control);
                for (int i = 0; i < info_GS.length; i++) {
                    info_GS[i] = "No Information available for this resource";
                }
            }



        } catch (Exception e) {

            System.out.println("EXCEPTION IN GOOGLE SCHOLAR: " + e.getMessage());
            for (int i = 0; i < info_GS.length; i++) {
                info_GS[i] = "No Available Service";
            }
        }

        return info_GS;
        //return output.toString();

    }
} // SemanticSearch_portlet 
