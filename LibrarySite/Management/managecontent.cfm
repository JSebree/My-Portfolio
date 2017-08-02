<cfparam name="content" default=""/>
<cfset preprocess()>
<div class="col-lg-3">
<cfoutput>#sidenav()#</cfoutput>
</div>
<div class="col-lg-9">
<cfoutput>#mainform()#</cfoutput>
</div>

<cffunction name="sidenav" access="private">
    <cfquery name="allcontent" datasource="#application.dsource#">
    	select * from content order by title
    </cfquery>

    <ul class="nav nav-stacked">
    <cfoutput>
            <li><a href="#cgi.SCRIPT_NAME#?tool=managecontent&content=new">New</a></li>
    </cfoutput>
    <cfoutput query="allcontent">
            <li><a href="#cgi.SCRIPT_NAME#?tool=managecontent&content=#contentid#">#title#</a></li>
    </cfoutput>
    </ul>
</cffunction>

<cffunction name="mainform" access="private">
    <cfif content neq ''>
        <cfif content eq 'new'>
            <cfset content=''>
        </cfif>
        <cfquery name="thiscontent" datasource="#application.dsource#">
    		select * from content where contentid='#content#'
	    </cfquery>

        <form action="#cgi.SCRIPT_NAME#?tool=managecontent&content=#content#" method="post">
        <cfoutput>
            <input type="hidden" name="contentid" value="#thiscontent.contentid[1]#" />
        <div class="form-group">
            <label for="title" class="col-sm-3 control-label">Title</label>
        <div class="col-sm-9">
                <input type="text" name="title" value="#thiscontent.title[1]#" />
        </div><br/>
        </div>
        <div class="form-group">
            <label for="description" class="col-sm-3 control-label">Description</label>
        <div class="col-sm-9">
        <textarea name="description">#thiscontent.description[1]#</textarea>
            <script>
                CKEDITOR.replace('description');
            </script>
        </div>
        </div>
            <div class="form-group">
                <label for="title" class="col-sm-3 control-label">&nbsp;</label>
                <div class="col-sm-9">
                    <input type="submit" value="Edit"/>
                </div>
            </div>
        </cfoutput>
        </form>
    </cfif>
</cffunction>

<cffunction name="preprocess">
    <cfif isdefined('form.contentid')>
        <cfif form.contentid eq ''>
            <cfset form.contentid=createuuid()>
            <cfset content=form.contentid>
        </cfif>
        <cfquery name="putin" datasource="#application.dsource#">
        	if not exists (select * from content where contentid='#form.contentid#')
            insert into content (contentid) values ('#form.contentid#');
            update content set title='#form.title#', description='#form.description#' 
            where contentid='#form.contentid#'
        </cfquery>
    </cfif>
</cffunction> 