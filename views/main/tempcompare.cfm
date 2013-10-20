<cfscript>
	logs = application.beanFactory.getBean("logs");
	observations = logs.getObeservationsForDate(now());
	fromDate = dateAdd("d",-1,now());
	toDate = now();
	/* query = " from observed_conditions where date >= :fromDate and date <= :toDate and metar like 'METAR%' order by date";
	results = ormExecutequery(query,{fromDate=fromDate,toDate=toDate});
	outdoorResultsQuery = entityToquery(results); */
	query = " from indoor_temp where created >= :fromDate and created < :toDate and temperature <> -1 order by created";
	results = ormExecutequery(query,{fromDate=fromDate,toDate=toDate});
	indoorResultsQuery = entityToquery(results);
</cfscript>
<cfquery name="results">
	select distinct on (oc.id) oc.id,oc.date, tempi, it.id,it.temperature, it.set_point, it.created, 
	floor(least(
	(select min(oc2.tempi) from observed_conditions oc2 where oc2.metar not ilike 'spec%' and oc2.date >= <cfqueryparam value="#fromDate#" cfsqltype="cf_sql_timestamp"> and oc2.date <= <cfqueryparam value="#toDate#" cfsqltype="cf_sql_timestamp"> ),
	(select min(it2.temperature) from indoor_temp it2 where it2.temperature <> -1 and it2.created >= <cfqueryparam value="#fromDate#" cfsqltype="cf_sql_timestamp"> and it2.created <= <cfqueryparam value="#toDate#" cfsqltype="cf_sql_timestamp">)
	)) as min_temp
		from observed_conditions oc left join indoor_temp it on it.created >= oc.date and it.temperature <> -1
		where oc.metar not ilike 'spec%' 
		and oc.date >= <cfqueryparam value="#fromDate#" cfsqltype="cf_sql_timestamp"> and oc.date <= <cfqueryparam value="#toDate#" cfsqltype="cf_sql_timestamp">
		order by oc.id asc
</cfquery>
<!--- <cfdump var="#indoorResultsQuery#">
<cfdump var="#outdoorResultsQuery#"> --->
<cfdump var="#results#">
<cfchart yaxistitle="temp" xaxistitle="date/time" chartheight="450" chartwidth="1700" showmarkers="true" scaleFrom="55">
	<cfchartseries type="line" query="indoorResultsQuery" itemcolumn="created" valuecolumn="temperature" />
	<cfchartseries type="line" query="indoorResultsQuery" itemcolumn="created" valuecolumn="set_point" />
	
</cfchart>
<cfchart yaxistitle="temp" xaxistitle="date/time" chartheight="450" chartwidth="1700" scalefrom="#results["min_temp"][1] - 2#">
	<cfchartseries type="line" query="results" itemcolumn="date" valuecolumn="tempi" />
	<cfchartseries type="line" query="results" itemcolumn="date" valuecolumn="temperature" />
	<cfchartseries type="line" query="results" itemcolumn="date" valuecolumn="set_point" /> 
</cfchart>
<cfdump var="#observations#">