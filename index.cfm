<cfscript>
	args = [ "/opt/local/bin/git","/Users/andyjarrett/Sites/somesite/"];
	
	// Get the CFC
	g = createObject( 'component', 'git');
	
	
	// init, passing in location to GIT and the folder you want to run
	// the commands against.
	g.init( args[1], args[2] );
	
	
	// out = g.status();
	statusOutput = g.status();
	writeOutput( htmlCodeFormat( statusOutput ) & "<hr>");
	
		
	// You can run any command you want via execGit()
	anyCommandOutput = g.execGit( "diff" ); 
	writeOutput( htmlCodeFormat( anyCommandOutput ) & "<hr>");
	
	
	// You can also catch Git errors
	try{
		//Run a command we know wont work
		g.execGit( "nonsense" );
	} catch (git e){
		// Git exception
		writeOutput( e.detail );
	} catch (any e){
		// Any exception
		writeOutput( e.detail );
	}
</cfscript>


