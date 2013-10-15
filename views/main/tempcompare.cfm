<cfscript>
	logs = application.beanFactory.getBean("logs");
	observations = logs.getObeservationsForDate(now());
	fromDate = dateAdd("d",-1,now());
	toDate = now();
	query = " from observed_conditions where date >= :fromDate and date <= :toDate and metar like 'METAR%' order by date";
	results = ormExecutequery(query,{fromDate=fromDate,toDate=toDate});
	outdoorResultsQuery = entityToquery(results);
	query = " from indoor_temp where created >= :fromDate and created < :toDate and temperature <> -1 order by created";
	results = ormExecutequery(query,{fromDate=fromDate,toDate=toDate});
	indoorResultsQuery = entityToquery(results);
	dateFormat = "yyyy-mm-dd";
	timeFormat = "HH:mm:ss";
	for(i = 1; i <= indoorResultsQuery.recordCount; i++){
		querySetcell(indoorResultsQuery,"created","#dateFormat(indoorResultsQuery["created"][i],dateFormat)# #timeFormat(indoorResultsQuery["created"][i],timeFormat)#",i);
		//{ts '2013-10-06 19:53:00'}
	}
	for(i = 1; i <= outdoorResultsQuery.recordCount; i++){
		querySetcell(outdoorResultsQuery,"date","#dateFormat(outdoorResultsQuery["date"][i],dateFormat)# #timeFormat(outdoorResultsQuery["date"][i],timeFormat)#",i);
		//{ts '2013-10-06 19:53:00'}
	}
</cfscript>
<!--- <cfdump var="#indoorResultsQuery#">
<cfdump var="#outdoorResultsQuery#"> --->
<cfchart yaxistitle="temp" xaxistitle="date/time" chartheight="400" chartwidth="1700" showmarkers="true" scaleFrom="55">
	<cfchartseries type="line" query="indoorResultsQuery" itemcolumn="created" valuecolumn="temperature" />
	<cfchartseries type="line" query="indoorResultsQuery" itemcolumn="created" valuecolumn="set_point" />
	
</cfchart>
<cfchart yaxistitle="temp" xaxistitle="date/time" chartheight="400" chartwidth="1700">
	<cfchartseries type="line" query="outdoorResultsQuery" itemcolumn="date" valuecolumn="tempi" />
</cfchart>
<cfdump var="#observations#">