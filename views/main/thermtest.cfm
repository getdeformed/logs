<cfscript>
	http = new Http();
	http.setUrl("http://10.0.0.11/tstat");
	result = deserializejson( http.send().getPrefix()["filecontent"]);
</cfscript>
<cfdump var="#result#">