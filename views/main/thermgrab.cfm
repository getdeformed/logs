<cfscript>
	http = new Http();
	http.setUrl("http://10.0.0.11/tstat");
	result = deserializejson( http.send().getPrefix()["filecontent"]);
	temp = entitynew("indoor_temp");
	if(structKeyexists(result,"tmode")){
		if(result["tmode"] == 1 ){
			temp.setMode("heat");
			temp.setSet_point(result["t_heat"]);
		} else if (result["tmode"] == 2 ){
			temp.setMode("cool");
			temp.setSet_point(result["t_cool"]);
		}
	}
	temp.setTemperature(result["temp"]);
	temp.setCreated(now());
	entitySave(temp);
	OrmFlush();
</cfscript>