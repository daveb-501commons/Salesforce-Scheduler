Salesforce-Scheduler
====================

Scheduler solution that allows reoccurring scheduling in Salesforce for any object.  Currently implmented for the Campaign object but can be extended.

<a href="https://githubsfdeploy.herokuapp.com?owner=daveb-501commons&repo=daveb-501commons/Salesforce-Scheduler">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

## Install Package

 * **SFDX Setup**
 
    SFDX Client is required for deploying the package to a Sandbox or Production
    https://trailhead.salesforce.com/en/modules/sfdx_app_dev/units/sfdx_app_dev_setup_dx

 	1) sfdx force:source:convert -d mdapi_output_dir -r src
	
	2) Sfdx force:auth:web:login
	
	3) sfdx force:mdapi:deploy -d mdapi_output_dir -u info@wholebars.com -l RunSpecifiedTests -r C501_SchedulerTests
	
	4) sfdx force:mdapi:deploy:report -w 5

## Setup Package

 	1) Setup -> Campaigns -> Edit Layout -> Related Lists

	2) Drag down the Scheduled Flows related list for the Campaign then Save the Layout

	3) Enable Scheduling on a Campaign
	
		Campaigns -> Select Campaign -> Click 'New Scheduled Flow' -> Add a Name -> Save

	4) Setup Apex Schedule

		Setup -> Apex Classes -> Schedule Apex -> 
			Send a Job Name
			Set Apex Class to C501_Scheduler
			Set Schedule
			Save
	

## Custom Components  

* **C501_ScheduledFlow__c**: Custom object with Master-Detail relationship to a Campaign.   

* **workflows**: This monitor a change on the C501_ScheduledFlow__c.FireFlow__c field.  Process builder recieves the field change, resets the field, and then calls the flow to handle the request.  Flow sample just does a couple lookups then sends out an email.

* **classes**: Apex class that is scheduled and responsible for triggering the C501_ScheduledFlow__c.FireFlow__c field.

## Description of Files and Directories  

* **orgs**: Directory that contains the scratch org definitions initially built by Cumulus CI. You reference these files when you create your scratch org with the 'cci org' or 'sfdx force:org:create' commands.
* **resource-bundles**: Directory that contains the source for the static resources and supports local testing framework.  NOTE: When making changes to these files if they are used in Salesforce then you need to zip the contents of Angular.resource\ directory and replace src\staticresources\Angular.resource followed by a 'cci task run deploy' to get the staticresources uploaded to Salesforce.  
* **src**: Directory that contains the source for the Food Bank app and tests.   
* **cumulusci.yml**:  Required by Cumulus CI.  Defines the deploy task. 
* **sfdx-project.json**: Required by Salesforce DX. Configures your project.  Use this file to specify the parameters that affect your Salesforce development project.
* **.forceignore**:  Optional SFDX file. Specifies files excluded when syncing and converting between scratch orgs and sfdx project.
* **.gitignore**:  Optional Git file. Specifies intentionally untracked files that you want Git (or in this case GitHub) to ignore.
* **.project**:  Required by the Eclipse IDE.  Describes the Eclipse project. 

 ## Issues

Please log issues related to this repository [here](https://github.com/501commons/Salesforce-Scheduler/issues).