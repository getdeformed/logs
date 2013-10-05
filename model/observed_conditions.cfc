<cfcomponent displayname="observed_conditions" hint="observed_conditions" output="false" persistent="true">
	<cfproperty name="id" generator="identity" ormType="integer" fieldtype="id" >
	<cfproperty name="location" type="string" ormtype="string">
	<cfproperty name="created" type="date" ormType="timestamp" default="#now()#">
	<cfproperty name="conds" type="string" ormtype="string">
	<cfproperty name="date" type="date" ormType="timestamp">
	<cfproperty name="dewpti" type="numeric" ormType="big_decimal" >
	<cfproperty name="dewptm" type="numeric" ormType="big_decimal" >
	<cfproperty name="fog" type="string" ormtype="string">
	<cfproperty name="hail" type="string" ormtype="string">
	<cfproperty name="heatindexi" type="numeric" ormType="big_decimal" >
	<cfproperty name="heatindexm" type="numeric" ormType="big_decimal" >
	<cfproperty name="hum" type="numeric" ormType="big_decimal" >
	<!--- <cfproperty name="icon" type="string" ormtype="string"> --->
	<cfproperty name="metar" type="string" ormtype="text">
	<cfproperty name="precipi" type="numeric" ormType="big_decimal" >
	<cfproperty name="precipm" type="numeric" ormType="big_decimal" >
	<cfproperty name="pressurei" type="numeric" ormType="big_decimal" >
	<cfproperty name="pressurem" type="numeric" ormType="big_decimal" >
	<cfproperty name="rain" type="string" ormtype="string">
	<cfproperty name="snow" type="string" ormtype="string">
	<cfproperty name="tempi" type="numeric" ormType="big_decimal" >
	<cfproperty name="tempm" type="numeric" ormType="big_decimal" >
	<cfproperty name="thunder" type="string" ormtype="string">
	<cfproperty name="tornado" type="string" ormtype="string">
	<cfproperty name="utcdate" type="date" ormType="timestamp">
	<cfproperty name="visi" type="numeric" ormType="big_decimal" >
	<cfproperty name="vism" type="numeric" ormType="big_decimal" >
	<cfproperty name="wdird" type="numeric" ormType="big_decimal" >
	<cfproperty name="wdire" type="string" ormtype="string">
	<cfproperty name="wgusti" type="numeric" ormType="big_decimal" >
	<cfproperty name="wgustm" type="numeric" ormType="big_decimal" >
	<cfproperty name="windchilli" >
	<cfproperty name="windchillm" >
	<cfproperty name="wspdi" type="numeric" ormType="big_decimal" >
	<cfproperty name="wspdm" type="numeric" ormType="big_decimal" >
	<!--- begin;
	 create unique index unique_location_and_date on observed_conditions (date,location);
	alter table observed_conditions alter COLUMN created set default now();
	alter table observed_conditions alter COLUMN created set not null;
	alter table observed_conditions alter COLUMN location set not null;
	commit;--->
</cfcomponent>