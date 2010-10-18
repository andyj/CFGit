<cfscript>
	args = [ "/opt/local/bin/git","/Users/andyjarrett/Sites/somesite/"];
	
	// Get the CFC
	g = createObject( 'component', 'git');
	
	// init, passing in location to GIT and the folder you want to run
	// the commands against.
	g.init( args[1], args[2] );
	
	// out = g.status();
	out = g.status();
</cfscript>
<cfoutput>#out#</cfoutput>

