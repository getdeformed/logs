<cfcomponent output="false">
	<cfscript>
		function init(){
			
		}
		
		function getObeservationsForDate(dateParam){
			var maxObDate = ormExecutequery("select max(date) from observed_conditions",{},true);
			//writeDump(dateDiff("n",maxObDate,now()));
			if(dateDiff("n",maxObDate,now()) < 70 && len(dateParam)){
				return dateDiff("n",maxObDate,now());
			}
			var apiKey = application.weatherApiKey;
			var http = new http();
			var dateMask = "yyyymmdd";
			if(len(dateParam)){
				var tempDate = dateParam;
				var date = dateFormat(tempDate,dateMask);
			} else {
				var date = dateFormat(dateAdd("d",-1,now()),dateMask);
			}
			
			var location = "84720.5.99999";
			//http.setUrl("http://api.wunderground.com/api/#apiKey#/yesterday/q/zmw:84720.1.99999.json");
			http.setUrl("http://api.wunderground.com/api/#apiKey#/history_#date#/q/zmw:#location#.json");
			var result = deserializejson( http.send().getPrefix()["filecontent"]);
			var observations = result["history"]["observations"];
			for(var ob in observations){
				try {
					var date = createdatetime(ob["date"]["year"],ob["date"]["mon"],ob["date"]["mday"],ob["date"]["hour"],ob["date"]["min"],0);
					var utcdate = createdatetime(ob["utcdate"]["year"],ob["utcdate"]["mon"],ob["utcdate"]["mday"],ob["utcdate"]["hour"],ob["utcdate"]["min"],0);
					structUpdate(ob,"date",date);
					structUpdate(ob,"utcdate",utcdate);
					structInsert(ob,"location",location);
					structInsert(ob,"created",now());
					structDelete(ob,"icon");
					var obCon = entityNew("observed_conditions",ob);
					entitySave(obCon);
					ormFlush();
				} catch (any e){
					
				}
			}
			return observations;
		}
	</cfscript>
</cfcomponent>