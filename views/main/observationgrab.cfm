<cfscript>
	logs = application.beanFactory.getBean("logs");
	
	if(structKeyexists(rc,"date")){
		observations = logs.getObeservationsForDate(rc.date);
	} else {
		observations = logs.getObeservationsForDate("");
	}
	
</cfscript>
<cfdump var="#observations#"> 