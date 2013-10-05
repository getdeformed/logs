<cfcomponent displayname="indoor_temp" hint="indoor temperature" output="false" persistent="true" >
	<cfproperty name="id" generator="identity" ormType="integer" fieldtype="id" >
	<cfproperty name="temperature" type="numeric" ormType="big_decimal" >
	<cfproperty name="mode" type="string" ormtype="string">
	<cfproperty name="set_point" type="numeric" ormType="big_decimal" >
	<cfproperty name="created" type="date" ormType="timestamp">
</cfcomponent>