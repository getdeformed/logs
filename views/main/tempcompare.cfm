<cfscript>
	fromDate = dateAdd("d",-1,now());
	toDate = now();
	query = " from observed_conditions where date >= :fromDate and date <= :toDate order by date";
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
<cfchart yaxistitle="temp" xaxistitle="date/time" chartheight="500" chartwidth="1000">
	<cfchartseries type="line" query="outdoorResultsQuery" itemcolumn="date" valuecolumn="tempi" />
	<cfchartseries type="line" query="indoorResultsQuery" itemcolumn="created" valuecolumn="temperature" />
	<cfchartseries type="line" query="indoorResultsQuery" itemcolumn="created" valuecolumn="set_point" />
	
</cfchart>