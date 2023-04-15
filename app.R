# R Shiny app "MedPracDB_test1"
# Only the database file and the app.R file are needed to run
# Alex Bordanca and David Thiriot

library(ggplot2)
library(shiny)
library(RSQLite)
library(DBI)


# Reference for how to move from tab to tab on action button push
# is from Victorp posted 01Aug2016 at
# stackoverflow.com/questions/38706965/is-there-any-way-for-an-actionbutton-to-navigate-to-another-tab-within-a-r-shi

conn <- dbConnect(RSQLite::SQLite(), dbname = "MedPracDB_R.db")
#dbListTables(conn) 

ui <- fluidPage(
  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css",
              href = "https://bootswatch.com/4/darkly/bootstrap.min.css"),
    tags$style("
      body {
        background-color: #343a40;
        color: #f8f9fa;
      }
      .navbar-dark .navbar-brand {
        color: #f8f9fa;
      }
      .navbar-dark .navbar-nav .nav-link {
        color: rgba(255, 255, 255, 0.5);
      }
      /* Set the background color of the sidebar to a dark color */
.sidebar {
  background-color: #333333;
}

/* Set the text color of the sidebar links to a light color */
.sidebar a {
  color: #FFFFFF;
}

/* Set the background color of the active sidebar link to a lighter color */
.sidebar .active a {
  background-color: #555555;
}

/* Set the text color of the main panel to a light color */
.main-panel {
  color: #FFFFFF;
}

/* Set the background color of the main panel to a dark color */
.main-panel {
  background-color: #222222;
}

/* Set the color of the borders and separators to a light color */
.border, .separator {
  border-color: #555555;
}



/* Set the color of the buttons to a light color */
.btn-primary, .btn-success, .btn-info, .btn-warning, .btn-danger {
  background-color: #555555;
  border-color: #555555;
  color: #FFFFFF;
}

/* Set the color of the button text to a light color */
.btn-primary:hover, .btn-success:hover, .btn-info:hover, .btn-warning:hover, .btn-danger:hover {
  color: #FFFFFF;
}

    ")
  ), #darkTheme
    tabsetPanel(
    id = "tabs",   
        
    tabPanel(title = "View Patient Information",
    titlePanel(h1("Medical Practice Database", align="center")),
    
    textInput("SelectedPatient", "Enter the Patient ID number (or 0 to exit): "),
    
    textOutput("Table_Patient_ID"),
    tableOutput("Data_Patient_ID"),
    
    textOutput("Table_Patient_contact"),
    tableOutput("Data_Patient_contact"), 
    
    textOutput("Table_Patient_doctors"),
    tableOutput("Data_Patient_doctors"), 
    
    textOutput("Table_Patient_finance"),
    tableOutput("Data_Patient_finance"), 
    
    textOutput("Table_Patient_vitals"),
    tableOutput("Data_Patient_vitals"), 
    
    textOutput("Table_Patient_health"),
    tableOutput("Data_Patient_health"), 
    
 ), #tabPanel
  
   tabPanel("Update Health Information", 
            titlePanel(h1("Medical Practice Database", align="center")),
            textInput("Up_Health_SelectedPatient", "Enter the Patient ID number (or 0 to exit): "),
            textOutput("Up_HealthInfo_Table_Patient_ID"),
            tableOutput("Up_HealthInfo_Data_Patient_ID"),
            textOutput("Up_Health_Title_currentconditions"),
            tableOutput("Up_Health_Data_currentconditions"),
            
            selectInput("Up_Health_SI_smoking", label="Do you need to update current smoking status? ",
                        choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_Health_SI_smoking=='YES (Update)'",
                             selectInput("Up_Health_smoking", 
                                         "Enter new smoking status (0=NOT current smoker, 1=current smoker): ",
                                         choices=c(0,1))),
            selectInput("Up_Health_SI_condition1", label="Do you need to update whether the patient has Condition 1? ",
                        choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_Health_SI_condition1=='YES (Update)'",
                             selectInput("Up_Health_condition1", 
                                         "Enter Condition 1 status (0=does NOT have condition, 1=HAS condition): ",
                                         choices=c(0,1))),
            selectInput("Up_Health_SI_condition2", label="Do you need to update whether the patient has Condition 2? ",
                        choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_Health_SI_condition2=='YES (Update)'",
                             selectInput("Up_Health_condition2", 
                                         "Enter Condition 2 status (0=does NOT have condition, 1=HAS condition): ",
                                         choices=c(0,1))),
            selectInput("Up_Health_SI_condition3", label="Do you need to update whether the patient has Condition 3? ",
                        choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_Health_SI_condition3=='YES (Update)'",
                             selectInput("Up_Health_condition3", 
                                         "Enter Condition 3 status (0=does NOT have condition, 1=HAS condition): ",
                                         choices=c(0,1))),
            selectInput("Up_Health_SI_condition4", label="Do you need to update whether the patient has Condition 4? ",
                        choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_Health_SI_condition4=='YES (Update)'",
                             selectInput("Up_Health_condition4", 
                                         "Enter Condition 4 status (0=does NOT have condition, 1=HAS condition): ",
                                         choices=c(0,1))),
            selectInput("Up_Health_SI_condition5", label="Do you need to update whether the patient has Condition 5? ",
                        choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_Health_SI_condition5=='YES (Update)'",
                             selectInput("Up_Health_condition5", 
                                         "Enter Condition 5 status (0=does NOT have condition, 1=HAS condition): ",
                                         choices=c(0,1))),
            selectInput("Up_Health_SI_condition6", label="Do you need to update whether the patient has Condition 6? ",
                        choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_Health_SI_condition6=='YES (Update)'",
                             selectInput("Up_Health_condition6", 
                                         "Enter Condition 6 status (0=does NOT have condition, 1=HAS condition): ",
                                         choices=c(0,1))),
            selectInput("Up_Health_SI_condition7", label="Do you need to update whether the patient has Condition 7? ",
                        choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_Health_SI_condition7=='YES (Update)'",
                             selectInput("Up_Health_condition7", 
                                         "Enter Condition 7 status (0=does NOT have condition, 1=HAS condition): ",
                                         choices=c(0,1))),
            selectInput("Up_Health_SI_condition8", label="Do you need to update whether the patient has Condition 8? ",
                        choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_Health_SI_condition8=='YES (Update)'",
                             selectInput("Up_Health_condition8", 
                                         "Enter Condition 8 status (0=does NOT have condition, 1=HAS condition): ",
                                         choices=c(0,1))),
            selectInput("Up_Health_SI_condition9", label="Do you need to update whether the patient has Condition 9? ",
                        choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_Health_SI_condition9=='YES (Update)'",
                             selectInput("Up_Health_condition9", 
                                         "Enter Condition 9 status (0=does NOT have condition, 1=HAS condition): ",
                                         choices=c(0,1))),
            selectInput("Up_Health_SI_condition10", label="Do you need to update whether the patient has Condition 10? ",
                        choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_Health_SI_condition10=='YES (Update)'",
                             selectInput("Up_Health_condition10", 
                                         "Enter Condition 10 status (0=does NOT have condition, 1=HAS condition): ",
                                         choices=c(0,1))),
            actionButton("AB_Update_Health", label="Click Here to Update Patient Health info in Database")
            ),
 
 tabPanel("Update Vitals Information", 
          titlePanel(h1("Medical Practice Database", align="center")),
          textInput("Up_Vitals_SelectedPatient", "Enter the Patient ID number (or 0 to exit): "),
          textOutput("Up_VitalsInfo_Table_Patient_ID"),
          tableOutput("Up_VitalsInfo_Data_Patient_ID"),
          textOutput("Up_Vitals_Title_currentconditions"),
          tableOutput("Up_Vitals_Data_currentconditions"),
          selectInput("Up_Vitals_SI_last_height",label="Do you need to update the patient's height? ",
                      choices=c("NO (Keep as is)", "YES (Update)")),
          conditionalPanel(condition = "input.Up_Vitals_SI_last_height=='YES (Update)'",
                           textInput("Up_Vitals_last_height","Enter the patient's new height: ")),
          selectInput("Up_Vitals_SI_last_weight",label="Do you need to update the patient's weight? ",
                      choices=c("NO (Keep as is)", "YES (Update)")),
          conditionalPanel(condition = "input.Up_Vitals_SI_last_weight=='YES (Update)'",
                           textInput("Up_Vitals_last_weight","Enter the patient's new weight: ")),
          selectInput("Up_Vitals_SI_last_heartrate",label="Do you need to update the patient's heart rate? ",
                      choices=c("NO (Keep as is)", "YES (Update)")),
          conditionalPanel(condition = "input.Up_Vitals_SI_last_heartrate=='YES (Update)'",
                           textInput("Up_Vitals_last_heartrate","Enter the patient's new heart rate: ")),
          selectInput("Up_Vitals_SI_last_systolic_bp",label="Do you need to update the patient's systolic blood pressure? ",
                      choices=c("NO (Keep as is)", "YES (Update)")),
          conditionalPanel(condition = "input.Up_Vitals_SI_last_systolic_bp=='YES (Update)'",
                           textInput("Up_Vitals_last_systolic_bp","Enter the patient's new systolic blood pressure: ")),
          selectInput("Up_Vitals_SI_last_diastolic_bp",label="Do you need to update the patient's diastolic blood pressure? ",
                      choices=c("NO (Keep as is)", "YES (Update)")),
          conditionalPanel(condition = "input.Up_Vitals_SI_last_diastolic_bp=='YES (Update)'",
                           textInput("Up_Vitals_last_diastolic_bp","Enter the patient's new diastolic blood pressure: ")),
          actionButton("AB_Update_Vitals", label="Click Here to Update Patient Vitals info in Database")
          ),
 
 
   tabPanel("Update Financial Information", 
            titlePanel(h1("Medical Practice Database", align="center")),
            textInput("Up_FinInfo_SelectedPatient", "Enter the Patient ID number (or 0 to exit): "),
            textOutput("Up_FinInfo_Table_Patient_ID"),
            tableOutput("Up_FinInfo_Data_Patient_ID"),
            textOutput("Up_FinInfo_Title_Amount_due"),
            tableOutput("Up_FinInfo_Data_Amount_due"),
            textInput("Up_FinInfo_New_bill", "Enter new bill amount: "),
            textInput("Up_FinInfo_New_payment", "Enter new payment amount: "),
            textOutput("Up_FinInfo_Title_New_balance"),
            tableOutput("Up_FinInfo_Data_New_balance"),
            actionButton("AB_Update_finance", label="Click Here to Update Amount Due in Database")
            ),
 
   tabPanel("Update Patient Personal and Contact Information", 
            titlePanel(h1("Medical Practice Database", align="center")),
            textInput("Up_PPCInfo_SelectedPatient", "Enter the Patient ID number (or 0 to exit): "),
            textOutput("Up_PPCInfo_Table_Patient_ID"),
            tableOutput("Up_PPCInfo_Data_Patient_ID"),
            selectInput("Up_PPC_SI_Firstname", label="Do you need to update the patient's First name? ",
                         choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_PPC_SI_Firstname=='YES (Update)'",
                             textOutput("Up_FirstNameChangeAttempt")),
            selectInput("Up_PPC_SI_Lastname", label="Do you need to update the patient's Last name? ",
                         choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_PPC_SI_Lastname=='YES (Update)'",
                             textOutput("Up_LastNameChangeAttempt")),
            selectInput("Up_PPC_SI_Current_patient", label="Do you need to update current patient status? ",
                         choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_PPC_SI_Current_patient=='YES (Update)'",
                             selectInput("Up_PPC_Current_patient", 
                                          "Enter new patient status (0=NOT current patient, 1=current patient): ",
                                          choices=c(0,1))),
            selectInput("Up_PPC_SI_Doctor", label="Do you need to update the patient's assigned doctor? ",
                        choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_PPC_SI_Doctor=='YES (Update)'",
                             selectInput("Up_PPC_Doctor", label="Select the assigned doctor: ",
                                          choices = c("Smith", "Williams", "Jones", "Rodriguez", "Zhang", "Perez",
                                                      "Jackson", "Harris", "Tataryn", "Petit"))),
            selectInput("Up_PPC_SI_Email", label="Do you need to update the patient's email? ",
                         choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_PPC_SI_Email=='YES (Update)'",
                             textInput("Up_PPC_Email", "Enter new Email: ")),
            selectInput("Up_PPC_SI_Street_address", label="Do you need to update the patient's street address? ",
                         choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_PPC_SI_Street_address=='YES (Update)'",
                             textInput("Up_PPC_Street_address", "Enter new Street address: ")),
            selectInput("Up_PPC_SI_Zip", label="Do you need to update the patient's zip code? ",
                         choices=c("NO (Keep as is)", "YES (Update)")),
            conditionalPanel(condition="input.Up_PPC_SI_Zip=='YES (Update)'",
                             selectInput("Up_PPC_Zip", "Enter new zip code: ",
                                         choices=c(10002, 10005, 10006, 10007, 10012, 10013))),
            actionButton("AB_Update_PPC", label="Click Here to Update Personal, Patient, Contact info in Database")
            ),
 
   tabPanel("Add New Patient",
            titlePanel(h1("Medical Practice Database", align="center")),
            textOutput("ANP_Title_and_Patient_ID"),
            textInput("New_Patient_ID_Firstname", "Enter the new patient firstname: "),
            textInput("New_Patient_ID_Lastname", "Enter the new patient lastname: "),
            dateInput("New_Patient_ID_DOB", "Select the new patient Date of Birth: ",
                      value="1984-01-01", startview="year"),
            # age
            radioButtons("New_Patient_ID_Biol_sex", label="Select most appropriate biological sex:", 
                         choices=c("Female", "Male")),
            selectInput("New_Patient_ID_Ethnicity", label="Select most appropriate ethnicity:",
                         choices=c("American Indian or Native Alaskan",
                                   "Asian or Pacific Islander",
                                   "Black (not Hispanic)",
                                   "Hispanic",
                                   "White (not Hispanic)",
                                   "Middle-Eastern, Arabic")),
            textInput("New_Patient_contact_Email", "Enter the new patient Email: "),
            textInput("New_Patient_contact_Street_address", "Enter the new patient Street address: "),
            # city = NY
            # state = NY
            selectInput("New_Patient_contact_Zip", label="Select from allowed zip codes: ", 
                         choices=c(10002, 10005, 10006, 10007, 10012, 10013)),
            
            
            selectInput("New_Patient_doctors_Doctor", label="Select a doctor for new patient: ",
                         choices=c("Smith", "Williams", "Jones", "Rodriguez", "Zhang", "Perez",
                                   "Jackson", "Harris", "Tataryn", "Petit")),
            # amount due starts at zero=0.
            selectInput("New_Patient_finance_Ins_co", label="Select from the insurance companies we accept: ",
                         choices=c("LifeWell", "Healthplan Plus", "New Day Medical",
                                   "Health Partners of New York", "CityPlan Health", "MetroCare Gold",
                                   "MetroCare Basic")),
            numericInput("New_Patient_vitals_Last_height", label="Select height to nearest centimeter: ",
                         value=169, min=92, max=244, step=1),
            numericInput("New_Patient_vitals_Last_weight", label="Select weight to nearest pound: ",
                         value=188, min=90, max=330, step=1),
            numericInput("New_Patient_vitals_Last_heartrate", label="Select heartrate in bpm: ",
                         value=76, min=30, max=160, step=1),
            numericInput("New_Patient_vitals_Last_systolic_BP", label="Select systolic blood pressure: ",
                         value=123, min=90, max=220, step=1),
            numericInput("New_Patient_vitals_Last_diastolic_BP", label="Select diastolic blood pressure: ",
                         value=71, min=50, max=160),
            checkboxInput("New_Patient_health_Current_smoker", label="Is new patient a current smoker? ",
                          value=FALSE),
            checkboxInput("New_Patient_health_Condition_1", label="Does new patient have Condition 1? ",
                          value=FALSE),
            checkboxInput("New_Patient_health_Condition_2", label="Does new patient have Condition 2? ",
                          value=FALSE),
            checkboxInput("New_Patient_health_Condition_3", label="Does new patient have Condition 3? ",
                          value=FALSE),
            checkboxInput("New_Patient_health_Condition_4", label="Does new patient have Condition 4? ",
                          value=FALSE),
            checkboxInput("New_Patient_health_Condition_5", label="Does new patient have Condition 5? ",
                          value=FALSE),
            checkboxInput("New_Patient_health_Condition_6", label="Does new patient have Condition 6? ",
                          value=FALSE),
            checkboxInput("New_Patient_health_Condition_7", label="Does new patient have Condition 7? ",
                          value=FALSE),
            checkboxInput("New_Patient_health_Condition_8", label="Does new patient have Condition 8? ",
                          value=FALSE),
            checkboxInput("New_Patient_health_Condition_9", label="Does new patient have Condition 9? ",
                          value=FALSE),
            checkboxInput("New_Patient_health_Condition_10", label="Does new patient have Condition 10? ",
                          value=FALSE),
            actionButton("AB_New_Patient", label="Click Here to Update New Patient in Database")
            
   ),
 
    tabPanel("Visualization Dashboard",
          titlePanel(h1("Medical Practice Database",align = "center")),
          sidebarLayout(
            sidebarPanel(
              textInput("DataViz_SelectedPatient", "Enter the Patient ID number (or 0 to exit): "),
              checkboxInput("DataViz_Last_height",label="Height",value=FALSE),
              checkboxInput("DataViz_Last_weight",label="Weight",value=FALSE),
              checkboxInput("DataViz_Last_heartrate",label="Heart rate",value=FALSE),
              checkboxInput("DataViz_Last_systolic_BP",label="Systolic BP",value=FALSE),
              checkboxInput("DataViz_Last_diastolic_BP",label="Diastolic BP",value=FALSE),
            ),
            mainPanel(
             conditionalPanel(condition="input$DataViz_Last_height==TRUE",
                              plotOutput("DataViz_Height_Plot")),
             conditionalPanel(condition="input$DataViz_Last_weight==TRUE",
                              plotOutput("DataViz_Weight_Plot")),
             conditionalPanel(condition="input$DataViz_Last_heartrate==TRUE",
                              plotOutput("DataViz_Heartrate_Plot")),
             conditionalPanel(condition="input$DataViz_Last_systolic_BP==TRUE",
                              plotOutput("DataViz_Systolic_Plot")),
             conditionalPanel(condition="input$DataViz_Last_diastolic_BP==TRUE",
                              plotOutput("DataViz_Diastolic_Plot"))
            )
          )
    ),
 
    tabPanel("Transaction Confirmation", 
          titlePanel(h1("Transaction Completed", align="center")),
          
 ),
 
    tabPanel("Transaction Failure", 
          titlePanel(h1("Transaction NOT Completed", align="center"))
          
 )   
     
) #tabsetPanel
) #ui

server <- function(input, output, session) {
    
    onStop(function(){dbDisconnect(conn)
                      print("Closing database.")}
    )
  
  #hideTab("tabs", "Transaction Completed")
    
## OUTPUT for tabPanel "View Patient Information"
    output$Table_Patient_ID <- renderText({
        "TABLE Patient_ID"
    })
    output$Data_Patient_ID <- renderTable({
        df1<-dbGetQuery(conn, 'SELECT *
                          FROM Patient_ID 
                          WHERE Patient_ID = ?',
                        params = as.integer(input$SelectedPatient))
        df1
    }, digits=0)
    
    output$Table_Patient_contact <- renderText({
        "TABLE Patient_contact"
    })
    output$Data_Patient_contact <- renderTable({
        df2<-dbGetQuery(conn, 'SELECT *
                          FROM Patient_contact
                          WHERE Patient_ID = ?',
                        params = as.integer(input$SelectedPatient))
        df2
    }, digits=0)
    
    output$Table_Patient_doctors <- renderText({
        "TABLE Patient_doctors JOIN Doctors"
    })
    output$Data_Patient_doctors <- renderTable({
        df3<-dbGetQuery(conn, 'SELECT *
                          FROM Patient_doctors
                          JOIN Doctors ON Patient_doctors.Doctor = Doctors.Lastname
                          WHERE Patient_ID = ?',
                        params = as.integer(input$SelectedPatient))
        df3
    }, digits=0)
    
    output$Table_Patient_finance <- renderText({
        "TABLE Patient_finance"
    })
    output$Data_Patient_finance <- renderTable({
        df4<-dbGetQuery(conn, 'SELECT *
                          FROM Patient_finance 
                          WHERE Patient_ID = ?',
                        params = as.integer(input$SelectedPatient))
        df4
    }, digits=0)
    
    output$Table_Patient_vitals <- renderText({
        "TABLE Patient_vitals"
    })
    output$Data_Patient_vitals <- renderTable({
        df5<-dbGetQuery(conn, 'SELECT *
                          FROM Patient_vitals 
                          WHERE Patient_ID = ?',
                        params = as.integer(input$SelectedPatient))
        df5
    }, digits=0)
    
    output$Table_Patient_health <- renderText({
        "TABLE Patient_health"
    })
    output$Data_Patient_health <- renderTable({
        df6<-dbGetQuery(conn, 'SELECT Patient_ID,
                               (CASE Current_smoker WHEN 0
                               THEN "" ELSE "Current Smoker, " END) ||
                               (CASE Condition_1 WHEN 0
                               THEN "" ELSE "Condition 1, " END) ||
                               (CASE Condition_2 WHEN 0
                               THEN "" ELSE "Condition 2, " END) ||
                               (CASE Condition_3 WHEN 0
                               THEN "" ELSE "Condition 3, " END) ||
                               (CASE Condition_4 WHEN 0
                               THEN "" ELSE "Condition 4, " END) ||
                               (CASE Condition_5 WHEN 0
                               THEN "" ELSE "Condition 5, " END) ||
                               (CASE Condition_6 WHEN 0
                               THEN "" ELSE "Condition 6, " END) ||
                               (CASE Condition_7 WHEN 0
                               THEN "" ELSE "Condition 7, " END) ||
                               (CASE Condition_8 WHEN 0
                               THEN "" ELSE "Condition 8, " END) ||
                               (CASE Condition_9 WHEN 0
                               THEN "" ELSE "Condition 9, " END) ||
                               (CASE Condition_10 WHEN 0
                               THEN "" ELSE "Condition 10, " END)
                               AS Known_health_conditions
                          FROM Patient_health 
                          WHERE Patient_ID = ?',
                        params = as.integer(input$SelectedPatient))
        df6
    }, digits=0)
    
## OUTPUT for tabPanel "Update Health Information"
    
    output$Up_HealthInfo_Table_Patient_ID <- renderText({
        "TABLE Patient_ID"
    })
    output$Up_HealthInfo_Data_Patient_ID <- renderTable({
        df1<-dbGetQuery(conn, 'SELECT *
                          FROM Patient_ID 
                          WHERE Patient_ID = ?',
                        params = as.integer(input$Up_Health_SelectedPatient))
        df1
    }, digits=0)
    
    output$Up_Health_Title_currentconditions <- renderText({
      "This patient is listed as having the following health conditions: "
    })
    
    output$Up_Health_Data_currentconditions <- renderTable({
      df6<-dbGetQuery(conn, 'SELECT Patient_ID,
                               (CASE Current_smoker WHEN 0
                               THEN "" ELSE "Current Smoker, " END) ||
                               (CASE Condition_1 WHEN 0
                               THEN "" ELSE "Condition 1, " END) ||
                               (CASE Condition_2 WHEN 0
                               THEN "" ELSE "Condition 2, " END) ||
                               (CASE Condition_3 WHEN 0
                               THEN "" ELSE "Condition 3, " END) ||
                               (CASE Condition_4 WHEN 0
                               THEN "" ELSE "Condition 4, " END) ||
                               (CASE Condition_5 WHEN 0
                               THEN "" ELSE "Condition 5, " END) ||
                               (CASE Condition_6 WHEN 0
                               THEN "" ELSE "Condition 6, " END) ||
                               (CASE Condition_7 WHEN 0
                               THEN "" ELSE "Condition 7, " END) ||
                               (CASE Condition_8 WHEN 0
                               THEN "" ELSE "Condition 8, " END) ||
                               (CASE Condition_9 WHEN 0
                               THEN "" ELSE "Condition 9, " END) ||
                               (CASE Condition_10 WHEN 0
                               THEN "" ELSE "Condition 10, " END)
                               AS Known_health_conditions
                          FROM Patient_health 
                          WHERE Patient_ID = ?',
                      params = as.integer(input$Up_Health_SelectedPatient))
      df6
    }, digits=0)
    
    observeEvent(input$AB_Update_Health, {
      if(input$Up_Health_SI_smoking == "YES (Update)"){
        dbExecute(conn, 'UPDATE Patient_health SET Current_smoker = ? WHERE Patient_ID = ?',
                  params = (c(input$Up_Health_smoking, input$Up_Health_SelectedPatient)))
      }
      if(input$Up_Health_SI_condition1 == "YES (Update)"){
        dbExecute(conn, 'UPDATE Patient_health SET Condition_1 = ? WHERE Patient_ID = ?',
                  params = (c(input$Up_Health_condition1, input$Up_Health_SelectedPatient)))
      }
      if(input$Up_Health_SI_condition2 == "YES (Update)"){
        dbExecute(conn, 'UPDATE Patient_health SET Condition_2 = ? WHERE Patient_ID = ?',
                  params = (c(input$Up_Health_condition2, input$Up_Health_SelectedPatient)))
      }
      if(input$Up_Health_SI_condition3 == "YES (Update)"){
        dbExecute(conn, 'UPDATE Patient_health SET Condition_3 = ? WHERE Patient_ID = ?',
                  params = (c(input$Up_Health_condition3, input$Up_Health_SelectedPatient)))
      }
      if(input$Up_Health_SI_condition4 == "YES (Update)"){
        dbExecute(conn, 'UPDATE Patient_health SET Condition_4 = ? WHERE Patient_ID = ?',
                  params = (c(input$Up_Health_condition4, input$Up_Health_SelectedPatient)))
      }
      if(input$Up_Health_SI_condition5 == "YES (Update)"){
        dbExecute(conn, 'UPDATE Patient_health SET Condition_5 = ? WHERE Patient_ID = ?',
                  params = (c(input$Up_Health_condition5, input$Up_Health_SelectedPatient)))
      }
      if(input$Up_Health_SI_condition6 == "YES (Update)"){
        dbExecute(conn, 'UPDATE Patient_health SET Condition_6 = ? WHERE Patient_ID = ?',
                  params = (c(input$Up_Health_condition6, input$Up_Health_SelectedPatient)))
      }
      if(input$Up_Health_SI_condition7 == "YES (Update)"){
        dbExecute(conn, 'UPDATE Patient_health SET Condition_7 = ? WHERE Patient_ID = ?',
                  params = (c(input$Up_Health_condition7, input$Up_Health_SelectedPatient)))
      }
      if(input$Up_Health_SI_condition8 == "YES (Update)"){
        dbExecute(conn, 'UPDATE Patient_health SET Condition_8 = ? WHERE Patient_ID = ?',
                  params = (c(input$Up_Health_condition8, input$Up_Health_SelectedPatient)))
      }
      if(input$Up_Health_SI_condition9 == "YES (Update)"){
        dbExecute(conn, 'UPDATE Patient_health SET Condition_9 = ? WHERE Patient_ID = ?',
                  params = (c(input$Up_Health_condition9, input$Up_Health_SelectedPatient)))
      }
      if(input$Up_Health_SI_condition10 == "YES (Update)"){
        dbExecute(conn, 'UPDATE Patient_health SET Condition_10 = ? WHERE Patient_ID = ?',
                  params = (c(input$Up_Health_condition10, input$Up_Health_SelectedPatient)))
      }
      
      updateTabsetPanel(session=session, "tabs", selected = "Transaction Confirmation")
    })
    
    ## OUTPUT for tabPanel "Update Vitals Information"
    
    output$Up_VitalsInfo_Table_Patient_ID <- renderText({
      "TABLE Patient_ID"
    })
    output$Up_VitalsInfo_Data_Patient_ID <- renderTable({
      df1<-dbGetQuery(conn, 'SELECT *
                          FROM Patient_ID 
                          WHERE Patient_ID = ?',
                      params = as.integer(input$Up_Vitals_SelectedPatient))
      df1
    }, digits=0)
    
    output$Up_Vitals_Title_currentconditions <- renderText({"Patient's last vitals"})
    
    output$Up_Vitals_Data_currentconditions <- renderTable({
      df5<-dbGetQuery(conn, 'SELECT *
                          FROM Patient_vitals
                          WHERE Patient_ID = ?',
                        params = as.integer(input$Up_Vitals_SelectedPatient))
      df5
    }, digits=0)
    
    observeEvent(input$AB_Update_Vitals, {
      if(input$Up_Vitals_SI_last_height == "YES (Update)"){
        dbExecute(conn,'UPDATE Patient_vitals SET Last_height = ? WHERE Patient_ID = ?',
                  params = (c(input$Up_Vitals_last_height,input$Up_Vitals_SelectedPatient)))
      }
      if(input$Up_Vitals_SI_last_weight == "YES (Update)"){
        dbExecute(conn, 'UPDATE Patient_vitals SET Last_weight = ? WHERE Patient_ID = ?',
                  params = (c(input$Up_Vitals_last_weight,input$Up_Vitals_SelectedPatient)))
      }
      if(input$Up_Vitals_SI_last_heartrate == "YES (Update)"){
        dbExecute(conn, 'UPDATE Patient_vitals SET Last_heartrate = ? WHERE Patient_ID = ?',
                  params = (c(input$Up_Vitals_last_heartrate,input$Up_Vitals_SelectedPatient)))
      }
      if(input$Up_Vitals_SI_last_systolic_bp == "YES (Update)"){
        dbExecute(conn, 'UPDATE Patient_vitals SET Last_systolic_BP = ? WHERE Patient_ID = ?',
                  params = (c(input$Up_Vitals_last_systolic_bp,input$Up_Vitals_SelectedPatient)))
      }
      if(input$Up_Vitals_SI_last_diastolic_bp == "YES (Update)"){
        dbExecute(conn, 'UPDATE Patient_vitals SET Last_diastolic_BP = ? WHERE Patient_ID = ?',
                  params = (c(input$Up_Vitals_last_diastolic_bp,input$Up_Vitals_SelectedPatient)))
      }
      updateTabsetPanel(session=session, "tabs", selected = "Transaction Confirmation")
    })
## OUTPUT for tabPanel "Update Financial Information"    
    
    output$Up_FinInfo_Table_Patient_ID <- renderText({
        "TABLE Patient_ID"
    })
    output$Up_FinInfo_Data_Patient_ID <- renderTable({
        df1<-dbGetQuery(conn, 'SELECT *
                          FROM Patient_ID 
                          WHERE Patient_ID = ?',
                        params = as.integer(input$Up_FinInfo_SelectedPatient))
        df1
    }, digits=0)
    output$Up_FinInfo_Title_Amount_due <- renderText({
      "Amount currently due"
    })
    output$Up_FinInfo_Data_Amount_due <- renderTable({
      df4_fin<-dbGetQuery(conn, 'SELECT Amount_due
                          FROM Patient_finance 
                          WHERE Patient_ID = ?',
                      params = as.integer(input$Up_FinInfo_SelectedPatient))
      df4_fin
    }, digits=2)
    output$Up_FinInfo_Title_New_balance <- renderText({
      "New amount due"
    })
    output$Up_FinInfo_Data_New_balance <- renderTable({
      df4_fin<-dbGetQuery(conn, 'SELECT (Amount_due + ? - ?) AS Amount_due
                          FROM Patient_finance 
                          WHERE Patient_ID = ?',
                          params = (c(input$Up_FinInfo_New_bill,
                                      input$Up_FinInfo_New_payment,
                                      input$Up_FinInfo_SelectedPatient)))
      df4_fin  
    }, digits=2)
    
    New_balance <- reactive({
      df4_fin<-dbGetQuery(conn, 'SELECT (Amount_due + ? - ?) AS Amount_due
                          FROM Patient_finance 
                          WHERE Patient_ID = ?',
                          params = (c(input$Up_FinInfo_New_bill,
                                      input$Up_FinInfo_New_payment,
                                      input$Up_FinInfo_SelectedPatient)))
      round(as.numeric(df4_fin), digits=2)  
    })
    
    observeEvent(input$AB_Update_finance, {
      dbExecute(conn, 'UPDATE Patient_finance SET Amount_due = ? WHERE Patient_ID = ?',
                params = (c(New_balance(), input$Up_FinInfo_SelectedPatient)))
      updateTabsetPanel(session=session, "tabs", selected = "Transaction Confirmation")
 
    })
      
## OUTPUT for tabPanel "Update Patient Personal and Contact Information"    
    
    output$Up_PPCInfo_Table_Patient_ID <- renderText({
        "TABLE Patient_ID"
    })
    output$Up_PPCInfo_Data_Patient_ID <- renderTable({
        df1<-dbGetQuery(conn, 'SELECT *
                          FROM Patient_ID 
                          WHERE Patient_ID = ?',
                        params = as.integer(input$Up_PPCInfo_SelectedPatient))
        df1
    }, digits=0)
    
    output$Up_FirstNameChangeAttempt <- renderText({
      "For a legal name change, create a new patient.  Name will not update in database."
    })
    output$Up_LastNameChangeAttempt <- renderText({
      "For a legal name change, create a new patient.  Name will not update in database."
    })
    
   observeEvent(input$AB_Update_PPC, {
    #if(input$Up_PPC_SI_Firstname == "YES (Update)"){
    #   dbExecute(conn, 'UPDATE Patient_ID SET Firstname = ? WHERE Patient_ID = ?',
    #             params = (c(input$Up_PPC_Firstname, input$Up_PPCInfo_SelectedPatient)))
    # }
    #if(input$Up_PPC_SI_Lastname == "YES (Update)"){
    #   dbExecute(conn, 'UPDATE Patient_ID SET Lastname = ? WHERE Patient_ID = ?',
    #             params = (c(input$Up_PPC_Lastname, input$Up_PPCInfo_SelectedPatient)))
    # }
     if(input$Up_PPC_SI_Current_patient == "YES (Update)"){
       dbExecute(conn, 'UPDATE Patient_ID SET Current_patient = ? WHERE Patient_ID = ?',
                 params = (c(input$Up_PPC_Current_patient, input$Up_PPCInfo_SelectedPatient)))
     }
     if(input$Up_PPC_SI_Doctor == "YES (Update)"){
       dbExecute(conn, 'UPDATE Patient_doctors SET Doctor = ? WHERE Patient_ID = ?',
                 params = (c(input$Up_PPC_Doctor, input$Up_PPCInfo_SelectedPatient)))
     }
     if(input$Up_PPC_SI_Email == "YES (Update)"){
       dbExecute(conn, 'UPDATE Patient_contact SET Email = ? WHERE Patient_ID = ?',
                 params = (c(input$Up_PPC_Email, input$Up_PPCInfo_SelectedPatient)))
     }
     if(input$Up_PPC_SI_Street_address == "YES (Update)"){
       dbExecute(conn, 'UPDATE Patient_contact SET Street_address = ? WHERE Patient_ID = ?',
                 params = (c(input$Up_PPC_Street_address, input$Up_PPCInfo_SelectedPatient)))
     }
     if(input$Up_PPC_SI_Zip == "YES (Update)"){
       dbExecute(conn, 'UPDATE Patient_contact SET Zip = ? WHERE Patient_ID = ?',
                 params = (c(input$Up_PPC_Zip, input$Up_PPCInfo_SelectedPatient)))
     }
     updateTabsetPanel(session=session, "tabs", selected = "Transaction Confirmation")
   })    
      
    
    
## OUTPUT for tabPanel "Add new patient"    
    
    observeEvent(input$AB_New_Patient, {
        
        #The next few lines enforce that you can't have 2 people with the same Firstname, Lastname, and DOB in database.
        charDOB <- as.character(input$New_Patient_ID_DOB)
        SameFnLnDOB <- 0
        SameFnLnDOB <- as.integer(dbGetQuery(conn, 'SELECT COUNT(*) 
                                         FROM Patient_ID
                                         WHERE ((Firstname = ?) & (Lastname = ?) & (DOB = ?))',
                        params = c(input$New_Patient_ID_Firstname, input$New_Patient_ID_Lastname, charDOB)))
        
        if(SameFnLnDOB<1){
      
        Highest_Patient_ID <- dbGetQuery(conn, 'SELECT MAX(Patient_ID) FROM Patient_ID')
        New_Patient_ID <- Highest_Patient_ID + 1
        
        df_Patient_ID <- dbGetQuery(conn, "SELECT * FROM Patient_ID")
        New_Patient_ID_Age <- trunc(as.numeric(difftime(Sys.Date(), input$New_Patient_ID_DOB), units="weeks")/52.25)
        v_New_Patient_ID <- df_Patient_ID[1,]
        v_New_Patient_ID[1,1] = as.integer(New_Patient_ID)
        v_New_Patient_ID[1,2] = input$New_Patient_ID_Firstname
        v_New_Patient_ID[1,3] = input$New_Patient_ID_Lastname
        v_New_Patient_ID[1,4] = charDOB
        v_New_Patient_ID[1,5] = New_Patient_ID_Age
        v_New_Patient_ID[1,6] = input$New_Patient_ID_Biol_sex
        v_New_Patient_ID[1,7] = input$New_Patient_ID_Ethnicity
        v_New_Patient_ID[1,8] = as.integer(1)
        df_New_Patient_ID <- rbind(df_Patient_ID, v_New_Patient_ID)
        dbWriteTable(conn, "Patient_ID", df_New_Patient_ID, overwrite=TRUE)
        
        df_Patient_contact <- dbGetQuery(conn, "SELECT * FROM Patient_contact")
        v_New_Patient_contact <- df_Patient_contact[1,]
        v_New_Patient_contact[1,1] = New_Patient_ID
        v_New_Patient_contact[1,2] = input$New_Patient_contact_Email
        v_New_Patient_contact[1,3] = input$New_Patient_contact_Street_address
        v_New_Patient_contact[1,4] = "NY"
        v_New_Patient_contact[1,5] = "NY"
        v_New_Patient_contact[1,6] = input$New_Patient_contact_Zip
        df_New_Patient_contact <- rbind(df_Patient_contact, v_New_Patient_contact)
        dbWriteTable(conn, "Patient_contact", df_New_Patient_contact, overwrite=TRUE)
        
        df_Patient_doctors <- dbGetQuery(conn, "SELECT * FROM Patient_doctors")
        v_New_Patient_doctors <- df_Patient_doctors[1,]
        v_New_Patient_doctors[1,1] <- New_Patient_ID
        v_New_Patient_doctors[1,2] <- input$New_Patient_doctors_Doctor
        df_New_Patient_doctors <- rbind(df_Patient_doctors, v_New_Patient_doctors)
        dbWriteTable(conn, "Patient_doctors", df_New_Patient_doctors, overwrite=TRUE)
        
        df_Patient_finance <- dbGetQuery(conn, "SELECT * FROM Patient_finance")
        v_New_Patient_finance <- df_Patient_finance[1,]
        v_New_Patient_finance[1,1] <- New_Patient_ID
        v_New_Patient_finance[1,2] <- 0
        v_New_Patient_finance[1,3] <- input$New_Patient_finance_Ins_co
        df_New_Patient_finance <- rbind(df_Patient_finance, v_New_Patient_finance)
        dbWriteTable(conn, "Patient_finance", df_New_Patient_finance, overwrite=TRUE)
        
        df_Patient_health <- dbGetQuery(conn, "SELECT * FROM Patient_health")
        v_New_Patient_health <- df_Patient_health[1,]
        v_New_Patient_health[1,1] <- New_Patient_ID
        v_New_Patient_health[1,2] <- as.integer(input$New_Patient_health_Current_smoker)
        v_New_Patient_health[1,3] <- as.integer(input$New_Patient_health_Condition_1)
        v_New_Patient_health[1,4] <- as.integer(input$New_Patient_health_Condition_2)
        v_New_Patient_health[1,5] <- as.integer(input$New_Patient_health_Condition_3)
        v_New_Patient_health[1,6] <- as.integer(input$New_Patient_health_Condition_4)
        v_New_Patient_health[1,7] <- as.integer(input$New_Patient_health_Condition_5)
        v_New_Patient_health[1,8] <- as.integer(input$New_Patient_health_Condition_6)
        v_New_Patient_health[1,9] <- as.integer(input$New_Patient_health_Condition_7)
        v_New_Patient_health[1,10] <- as.integer(input$New_Patient_health_Condition_8)
        v_New_Patient_health[1,11] <- as.integer(input$New_Patient_health_Condition_9)
        v_New_Patient_health[1,12] <- as.integer(input$New_Patient_health_Condition_10)
        df_New_Patient_health <- rbind(df_Patient_health, v_New_Patient_health)
        dbWriteTable(conn, "Patient_health", df_New_Patient_health, overwrite=TRUE)
        
        df_Patient_vitals <- dbGetQuery(conn, "SELECT * FROM Patient_vitals")
        v_New_Patient_vitals <- df_Patient_vitals[1,]
        v_New_Patient_vitals[1,1] <- New_Patient_ID
        v_New_Patient_vitals[1,2] <- input$New_Patient_vitals_Last_height
        v_New_Patient_vitals[1,3] <- input$New_Patient_vitals_Last_weight
        v_New_Patient_vitals[1,4] <- input$New_Patient_vitals_Last_heartrate
        v_New_Patient_vitals[1,5] <- input$New_Patient_vitals_Last_systolic_BP
        v_New_Patient_vitals[1,6] <- input$New_Patient_vitals_Last_diastolic_BP
        df_New_Patient_vitals <- rbind(df_Patient_vitals, v_New_Patient_vitals)
        dbWriteTable(conn, "Patient_vitals", df_New_Patient_vitals, overwrite=TRUE)
        updateTabsetPanel(session=session, "tabs", selected = "Transaction Confirmation")
        }
        
        else {updateTabsetPanel(session=session, "tabs", selected = "Transaction Failure")}
        
    }) 
    
    
    ## Output for Visualization Dashboard
    observeEvent(input$DataViz_Last_height, {
      if(input$DataViz_Last_height == TRUE && input$DataViz_SelectedPatient != "") {
        patient_height <- dbGetQuery(conn, paste0("SELECT Last_height FROM Patient_vitals WHERE Patient_ID = '", input$DataViz_SelectedPatient, "'"))
        patient_sex <- dbGetQuery(conn, paste0("SELECT Biol_sex FROM Patient_ID WHERE Patient_ID = '", input$DataViz_SelectedPatient, "'"))
        
        
          output$DataViz_Height_Plot <- renderPlot({
            height_df <- dbGetQuery(conn,"SELECT pv.Last_height,pid.Biol_sex FROM Patient_vitals pv JOIN Patient_ID pid on pv.Patient_ID = pid.Patient_ID;")
            ggplot(height_df,aes(x=Last_height,color=Biol_sex))+geom_density() + 
              geom_vline(xintercept = patient_height$Last_height, color = ifelse(patient_sex == "Female", "blue", "red"), linewidth = 2, linetype = "dashed") + 
              labs(title = paste0("Distribution of Height (Patient ID = ", input$DataViz_SelectedPatient, ")"))
          })
        
      } else if(input$DataViz_Last_height == TRUE && input$DataViz_SelectedPatient == "") {
        output$DataViz_Height_Plot <- renderPlot({
          height_df <- dbGetQuery(conn,"SELECT pv.Last_height,pid.Biol_sex FROM Patient_vitals pv JOIN Patient_ID pid on pv.Patient_ID = pid.Patient_ID;")
          ggplot(height_df,aes(x=Last_height,color=Biol_sex))+geom_density() +
            labs(title = 'Distribution of Height')
        })
      } else {
        output$DataViz_Height_Plot <- NULL
      }
    })
    
    observeEvent(input$DataViz_Last_weight, {
      if(input$DataViz_Last_weight == TRUE && input$DataViz_SelectedPatient != "") {
        patient_weight <- dbGetQuery(conn, paste0("SELECT Last_weight FROM Patient_vitals WHERE Patient_ID = '", input$DataViz_SelectedPatient, "'"))
        patient_sex <- dbGetQuery(conn, paste0("SELECT Biol_sex FROM Patient_ID WHERE Patient_ID = '", input$DataViz_SelectedPatient, "'"))
        
        
        output$DataViz_Weight_Plot <- renderPlot({
          weight_df <- dbGetQuery(conn,"SELECT pv.Last_weight,pid.Biol_sex FROM Patient_vitals pv JOIN Patient_ID pid on pv.Patient_ID = pid.Patient_ID;")
          ggplot(weight_df,aes(x=Last_weight,color=Biol_sex))+geom_density() + 
            geom_vline(xintercept = patient_weight$Last_weight, color = ifelse(patient_sex == "Female", "blue", "red"), linewidth = 2, linetype = "dashed") + 
            labs(title = paste0("Distribution of Weight (Patient ID = ", input$DataViz_SelectedPatient, ")"))
        })
        
      } else if(input$DataViz_Last_weight == TRUE && input$DataViz_SelectedPatient == "") {
        output$DataViz_Height_Plot <- renderPlot({
          weight_df <- dbGetQuery(conn,"SELECT pv.Last_weight,pid.Biol_sex FROM Patient_vitals pv JOIN Patient_ID pid on pv.Patient_ID = pid.Patient_ID;")
          ggplot(weight_df,aes(x=Last_weight,color=Biol_sex))+geom_density() +
            labs(title = 'Distribution of Weight')
        })
      } else {
        output$DataViz_Weight_Plot <- NULL
      }
    })
    
    
    observeEvent(input$DataViz_Last_heartrate, {
      if(input$DataViz_Last_heartrate == TRUE && input$DataViz_SelectedPatient != "") {
        patient_heartrate <- dbGetQuery(conn, paste0("SELECT Last_heartrate FROM Patient_vitals WHERE Patient_ID = '", input$DataViz_SelectedPatient, "'"))
        patient_sex <- dbGetQuery(conn, paste0("SELECT Biol_sex FROM Patient_ID WHERE Patient_ID = '", input$DataViz_SelectedPatient, "'"))
        
        
        output$DataViz_Heartrate_Plot <- renderPlot({
          heartrate_df <- dbGetQuery(conn,"SELECT pv.Last_heartrate,pid.Biol_sex FROM Patient_vitals pv JOIN Patient_ID pid on pv.Patient_ID = pid.Patient_ID;")
          ggplot(heartrate_df,aes(x=Last_heartrate,color=Biol_sex))+geom_density() + 
            geom_vline(xintercept = patient_heartrate$Last_heartrate, color = ifelse(patient_sex == "Female", "blue", "red"), linewidth = 2, linetype = "dashed") + 
            labs(title = paste0("Distribution of Heartrate (Patient ID = ", input$DataViz_SelectedPatient, ")"))
        })
        
      } else if(input$DataViz_Last_heartrate == TRUE && input$DataViz_SelectedPatient == "") {
        output$DataViz_Height_Plot <- renderPlot({
          heartrate_df <- dbGetQuery(conn,"SELECT pv.Last_heartrate,pid.Biol_sex FROM Patient_vitals pv JOIN Patient_ID pid on pv.Patient_ID = pid.Patient_ID;")
          ggplot(heartrate_df,aes(x=Last_heartrate,color=Biol_sex))+geom_density() +
            labs(title = 'Distribution of Heartrate')
        })
      } else {
        output$DataViz_Heartrate_Plot <- NULL
      }
    })
    
    observeEvent(input$DataViz_Last_systolic_BP, {
      if(input$DataViz_Last_systolic_BP == TRUE && input$DataViz_SelectedPatient != "") {
        patient_systolic_BP <- dbGetQuery(conn, paste0("SELECT Last_systolic_BP FROM Patient_vitals WHERE Patient_ID = '", input$DataViz_SelectedPatient, "'"))
        patient_sex <- dbGetQuery(conn, paste0("SELECT Biol_sex FROM Patient_ID WHERE Patient_ID = '", input$DataViz_SelectedPatient, "'"))
        
        
        output$DataViz_Systolic_Plot <- renderPlot({
          systolic_BP_df <- dbGetQuery(conn,"SELECT pv.Last_systolic_BP,pid.Biol_sex FROM Patient_vitals pv JOIN Patient_ID pid on pv.Patient_ID = pid.Patient_ID;")
          ggplot(systolic_BP_df,aes(x=Last_systolic_BP,color=Biol_sex))+geom_density() + 
            geom_vline(xintercept = patient_systolic_BP$Last_systolic_BP, color = ifelse(patient_sex == "Female", "blue", "red"), linewidth = 2, linetype = "dashed") + 
            labs(title = paste0("Distribution of Systolic BP (Patient ID = ", input$DataViz_SelectedPatient, ")"))
        })
        
      } else if(input$DataViz_Last_systolic_BP == TRUE && input$DataViz_SelectedPatient == "") {
        output$DataViz_Systolic_Plot <- renderPlot({
          systolic_BP_df <- dbGetQuery(conn,"SELECT pv.Last_systolic_BP,pid.Biol_sex FROM Patient_vitals pv JOIN Patient_ID pid on pv.Patient_ID = pid.Patient_ID;")
          ggplot(heartrate_df,aes(x=Last_systolic_BP,color=Biol_sex))+geom_density() +
            labs(title = 'Distribution of  Systolic BP')
        })
      } else {
        output$DataViz_Systolic_Plot <- NULL
      }
    })
    
    observeEvent(input$DataViz_Last_diastolic_BP, {
      if(input$DataViz_Last_diastolic_BP == TRUE && input$DataViz_SelectedPatient != "") {
        patient_diastolic_BP <- dbGetQuery(conn, paste0("SELECT Last_diastolic_BP FROM Patient_vitals WHERE Patient_ID = '", input$DataViz_SelectedPatient, "'"))
        patient_sex <- dbGetQuery(conn, paste0("SELECT Biol_sex FROM Patient_ID WHERE Patient_ID = '", input$DataViz_SelectedPatient, "'"))
        
        
        output$DataViz_Diastolic_Plot <- renderPlot({
          diastolic_BP_df <- dbGetQuery(conn,"SELECT pv.Last_diastolic_BP,pid.Biol_sex FROM Patient_vitals pv JOIN Patient_ID pid on pv.Patient_ID = pid.Patient_ID;")
          ggplot(diastolic_BP_df,aes(x=Last_diastolic_BP,color=Biol_sex))+geom_density() + 
            geom_vline(xintercept = patient_diastolic_BP$Last_diastolic_BP, color = ifelse(patient_sex == "Female", "blue", "red"), linewidth = 2, linetype = "dashed") + 
            labs(title = paste0("Distribution of Systolic BP (Patient ID = ", input$DataViz_SelectedPatient, ")"))
        })
        
      } else if(input$DataViz_Last_diastolic_BP == TRUE && input$DataViz_SelectedPatient == "") {
        output$DataViz_Diastolic_Plot <- renderPlot({
          diastolic_BP_df <- dbGetQuery(conn,"SELECT pv.Last_diastolic_BP,pid.Biol_sex FROM Patient_vitals pv JOIN Patient_ID pid on pv.Patient_ID = pid.Patient_ID;")
          ggplot(heartrate_df,aes(x=Last_diastolic_BP,color=Biol_sex))+geom_density() +
            labs(title = 'Distribution of  Systolic BP')
        })
      } else {
        output$DataViz_Diastolic_Plot <- NULL
      }
    })
     
    ## General observations
    
    observe({
        if(input$SelectedPatient==0) {stopApp()}
        if(input$Up_FinInfo_SelectedPatient==0) {stopApp()}
        if(input$Up_PPCInfo_SelectedPatient==0) {stopApp()}
        if(input$Up_Health_SelectedPatient==0) {stopApp()}
        if(input$Up_Vitals_SelectedPatient==0) {stopApp()}
        if(input$DataViz_SelectedPatient==0) {stopApp()}
    })
}

shinyApp(ui=ui, server=server)


