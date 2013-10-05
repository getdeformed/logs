<cfscript>
	http = new Http();
	http.setUrl("http://10.0.0.11/tstat");
	result = http.send().getPrefix();
</cfscript>
<cfdump var="#result#">