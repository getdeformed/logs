component extends="org.corfield.framework" {
	
	// Either put the org folder in your webroot or create a mapping for it!
	
	// FW/1 - configuration for introduction application:
	// controllers/layouts/services/views are in this folder (allowing for non-empty context root):
//	variables.framework = {
//		base = getDirectoryFromPath( CGI.SCRIPT_NAME ).replace( getContextRoot(), '' ) & 'introduction'
//	};
	this.name = "OrmEx_#hash( getCurrentTemplatePath() )#"; 
	this.sessionmanagement = true; // orm settings 
	this.datasource = "logs"; 
	this.ormEnabled = true; 
	this.ormsettings = { 
		dbcreate = "update", // This value drops the table if it exists and then creates it 
		logSQL = true, // SQL queries are logged to the console 
		cfclocation = "model" // Specifies the directory(or multiple off) to search for persistent CFCs to generate the mappings 
	}; 
	
	function setupApplication(){
		var beanFactory = new ioc("/gateway");
		setBeanFactory(beanFactory);
		application.beanFactory = beanFactory;
		
		application.weatherApiKey = "52ab287379302d7c";
	}

}
