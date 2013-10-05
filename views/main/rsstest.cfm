<cfscript>
	feed = new feed();
	feed.setSource("http://w1.weather.gov/xml/current_obs/KCDC.rss");
	result = feed.read();
</cfscript>
<cfdump var="#result#">