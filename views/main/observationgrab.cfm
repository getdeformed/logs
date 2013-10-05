<cfscript>
	apiKey = "52ab287379302d7c";
	http = new http();
	dateMask = "yyyymmdd";
	if(structKeyexists(rc,"date")){
		tempDate = rc.date;
		date = dateFormat(tempDate,dateMask);
	} else {
		date = dateFormat(dateAdd("d",-1,now()),dateMask);
	}
	
	 location = "84720.5.99999";
	//http.setUrl("http://api.wunderground.com/api/#apiKey#/yesterday/q/zmw:84720.1.99999.json");
	http.setUrl("http://api.wunderground.com/api/#apiKey#/history_#date#/q/zmw:#location#.json");
	result = deserializejson( http.send().getPrefix()["filecontent"]);
	observations = result["history"]["observations"];
	for(ob in observations){
		try {
			date = createdatetime(ob["date"]["year"],ob["date"]["mon"],ob["date"]["mday"],ob["date"]["hour"],ob["date"]["min"],0);
			utcdate = createdatetime(ob["utcdate"]["year"],ob["utcdate"]["mon"],ob["utcdate"]["mday"],ob["utcdate"]["hour"],ob["utcdate"]["min"],0);
			structUpdate(ob,"date",date);
			structUpdate(ob,"utcdate",utcdate);
			structInsert(ob,"location",location);
			structInsert(ob,"created",now());
			structDelete(ob,"icon");
			obCon = entityNew("observed_conditions",ob);
			entitySave(obCon);
			ormFlush();
		} catch (any e){
			
		}
	} 
	//ormFlush();
</cfscript>
<cfdump var="#observations#"> 