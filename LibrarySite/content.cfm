<cfparam name="con" default="">


<cfif con neq ''>
    <cfquery name="contentinfo" datasource="#application.dsource#">
		select * from content where contentid='#con#'
	</cfquery>
    <cfoutput>
        <legend>#contentinfo.title[1]#</legend>
    <div>
        #contentinfo.description[1]#
        </div>
    </cfoutput>
<cfelse>
    Please choose one.
</cfif>