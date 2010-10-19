<cfcomponent displayname="cfgit" hint="I interact with git" output="false">
	<!--- The setup --->
	<cfproperty
		name="git_path"
		displayname="Git path"
		hint="On *nix system you can find the git to path by running $which git"
		type="string" />
		
	<cfproperty
		name="git_folder"
		displayname="Repository folder"
		hint="I am the folder you are going to query"
		type="string" />

	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="argGit_path" type="string" required="true">
		<cfargument name="arggit_folder" type="string" required="true">
		
		<cfscript>
			setGit_path( argGit_path );
			setgit_folder( arggit_folder );
			return this;
		</cfscript>
	</cffunction>
	<!--- End: the setup --->

	<!--- Commands --->
	<cffunction name="add" access="public" output="false" returntype="any" hint="Add file contents to the index">
		<cfargument
			name="argFiles"
			type="string"
			default="."
			hint="Limits the number of commits to show" />
			
		<cfif len( trim( argN )) AND isValid( "integer", argN )>
			<cfset argN = "-n " & argN>
		</cfif>
		
		<cfreturn execGit( "log", argN )>
	</cffunction>

	<cffunction name="diff" access="public" output="false" returntype="any">
		<cfreturn execGit( "diff" )>
	</cffunction>
		
	<cffunction name="log" access="public" output="false" returntype="any" hint="log">
		<cfargument
			name="argN"
			type="numeric"
			default="5"
			hint="Limits the number of commits to show" />
			
		<cfif len( trim( argN )) AND isValid( "integer", argN )>
			<cfset argN = "-n " & argN>
		</cfif>
		
		<cfreturn execGit( "log", argN )>
	</cffunction>

	<cffunction name="show" access="public" output="false" returntype="any" hint="Show various types of objects">
		<cfreturn execGit( "show" )>
	</cffunction>
	
	<cffunction name="status" access="public" output="false" returntype="any" hint="Show the working tree status">
		<cfreturn execGit( "status" )>
	</cffunction>

	<!--- End: Commands --->

	<!--- wrapped up the execute in a function to save repetition --->
	<cffunction name="execGit" access="public" output="false" returntype="string">
		<cfargument name="argCommand" required="true" type="string">
		<cfargument name="argArguments" required="false" type="string" default="">
		
		<cfset var local = {} />
		
		<cfexecute name = "#getGit_path()#" 
		    arguments = "--git-dir=#getgit_folder()# #argCommand# #argArguments#"  
		    timeout = "1"
			variable="local.out"
			errorvariable="local.err"> 
		</cfexecute>		
		
		<cfif len( trim( local.err ) )>
			<cfset local.msg = "error running Git command #uCase(argCommand)# in execGit()">
			<cfthrow detail="#local.err#" type="git" message="#local.msg#" />
		<cfelse>
			<cfreturn local.out>
		</cfif>
	</cffunction>

	<!--- Getters and Setters --->
	<cffunction name="getGit_path" access="public" output="false" returntype="string">
		<cfreturn git_path>
	</cffunction>

	<cffunction name="setGit_path" access="private" output="false" returntype="void">
		<cfargument name="argGit_path" type="any">
		<cfset git_path=argGit_path/>
	</cffunction>

	<cffunction name="getgit_folder" access="public" output="false" returntype="string">
		<cfreturn git_folder>
	</cffunction>

	<cffunction name="setgit_folder" access="private" output="false" returntype="void">
		<cfargument name="arggit_folder" type="any">
		<cfscript>
			// makse sure there is a trailing slash
			if( right( arggit_folder, 1) NEQ "/"){ arggit_folder = arggit_folder & "/"; }
			arggit_folder = arggit_folder & ".git";
			git_folder=arggit_folder;
		</cfscript>		
	</cffunction>

</cfcomponent>