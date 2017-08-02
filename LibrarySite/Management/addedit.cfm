<cfparam name="qterm" default=''>
<script>
    function togglenewisbnform(){
        if(document.getElementById('newisbn13area').style.display=='none'){
            document.getElementById('newisbn13area').style.display='inline';
        }
        else{
            document.getElementById('newisbn13area').style.display='none'
        }
    }
</script>
<cftry>
    <cfoutput>
        #processForms()#
    </cfoutput>

    <div id="main" class="col-lg-9 col-lg-push-3">
    <cfoutput>
 #mainEditForm()#
 </cfoutput>
    </div>
    <div id="leftgutter" class="col-lg-3 col-lg-pull-9">
    <cfoutput>
 #sideNav()#
 </cfoutput>
    </div>
    <cfcatch type="any">
    <!---    <cfdump var="#cfcatch#">  --->
    </cfcatch>
</cftry>
<!---left side nav --->

<cffunction name="sideNav" access="private">
    <cfif qterm neq ''>
    <cfquery name="allbooks" datasource="#application.dsource#">
    		select * from books where title like '%#qterm#%'
	    </cfquery>
    <cfelse>
    <cfquery name="allbooks" datasource="#application.dsource#">
    		select top 5 * from books
	    </cfquery>
    </cfif>
    <div class="panel">
    </div>
    <cfoutput>
        <form action="#cgi.SCRIPT_NAME#?tool=addedit" method="post" class="form-inline">
            <div class="form-group">
                <label for="qterm">Book Search:</label>
                <input type="text" class="form-control" id="qterm" name="qterm" value="#qterm#">
                <button type="submit" class="btn btn-xs btn-primary">Search</button>
            </div>
        </form>
    </cfoutput>
    <cfoutput>
        <ul class="nav nav-stacked">
        <li><a href="#cgi.SCRIPT_NAME#?tool=addedit&book=new">New Book</a></li>
        <cfif isdefined('allbooks')>
            <cfloop query="allbooks">
                    <li><a href="#cgi.SCRIPT_NAME#?tool=addedit&book=#isbn13#&qterm=#qterm#">#trim(title)#</a></li>
            </cfloop>
        <cfelse>
                No Search Term Entered (Try Harry Potter)
        </cfif>
        </ul>
    </cfoutput>
</cffunction>
<cffunction name="processForms">
    <cfif isdefined('form.isbn13')>
        <cfif isdefined('form.uploadimage') and trim(form.uploadimage) neq '' >
            <cffile action="upload" filefield="uploadimage"
                    destination="#expandpath('/')#jsebr66205/MyWebSite/images/"
                    nameconflict="makeunique">
   <!--- <cfdump var="#cffile#" label="CFFILE"> --->
            <cfset form.image='#cffile.serverfile#'>
        </cfif>
    <!---    <cfdump var="#form#" />  --->
        <cfquery name="putin" datasource="#application.dsource#">
            if not exists (select * from books where isbn13='#form.isbn13#')
            insert into books (isbn13) values ('#form.isbn13#');
            update books set title='#form.booktitle#', image='#form.image#', publisher='#form.publisher#',
                isbn13='#form.isbn13#', description='#form.description#', year='#form.year#'
            where isbn13='#form.isbn13#'
        </cfquery>
    </cfif>
    <cfif isdefined('form.genre')>
        <cfquery name='delete' datasource="#application.dsource#">
            	delete from genrestobooks where isbn13='#form.isbn13#'
            </cfquery>
        <cfoutput>
            <cfloop list="#form.genre#" index="i">
                <cfquery name="putingenres" datasource="#application.dsource#">
                    	insert into genrestobooks (isbn13,genreid) values ('#form.isbn13#','#i#')
                </cfquery>
            </cfloop>
        </cfoutput>
    </cfif>
</cffunction>
<cffunction name="mainEditForm" access="private">
    <div id="main" class="col-lg-9 col-lg-push-3">
    <cfif isdefined('url.book')>
        <cfquery name="bookinfo" datasource="#application.dsource#">
            select * from books where isbn13='#url.book#'
        </cfquery>
        <cfquery name="allpubs" datasource="#application.dsource#">
            select * from publishers order by name
        </cfquery>
        <cfquery name="allgenres" datasource="#application.dsource#">
            	select * from genres order by genrename
            </cfquery>
        <cfquery name="bookgenres" datasource="#application.dsource#">
            	select * from genrestobooks where isbn13='#url.book#'
            </cfquery>

        <cfif trim(bookinfo.isbn13[1]) neq ''>
            <cfset isbnfield="none">
            <cfset isbndisp="inline">
            <cfset req=''>
        <cfelse>
            <cfset isbnfield="inline">
            <cfset isbndisp="none">
            <cfset req="required">
        </cfif>
        <cfif isdefined('form.newisbn13')>
            <cfquery datasource='application.dsource'>
                update books set isbn13='#form.newisbn13#' where isbn13='#form.isbn13#'
            </cfquery>
            <cfset form.isbn13=form.newisbn13>
        </cfif>
     <!---   <cfdump var="#bookinfo#" />  --->
        <cfoutput>
            <form action="#cgi.SCRIPT_NAME#?tool=#tool#&book=#url.book#" method="post" enctype="multipart/form-data"
            class="form-horizontal">
                <input type="hidden" name="qterm" value="#qterm#" />
                <input type="hidden" id="isbn13" name="isbn13" value="#bookinfo.isbn13[1]#" />
                <div class="form-group" >
                    <label for="isbn13" class="col-lg-3 control-label">ISBN13:</label>
                    <div class="col-lg-9">
                        <span id="newisbn13area" style="display:#isbnfield#">
                            <input type="text" id="isbn13" name="newisbn13" value="#bookinfo.isbn13[1]#"
                            class="form-control" placeholder="Insert ISBN13 Here" #req# pattern=".{13}"
                            title="Please Enter 13 Characters. No Dashes."/>
                        </span>
                        <span style="display:#isbndisp#">
                            #bookinfo.isbn13[1]#
                            <cfif isdefined('session.isadmin') and session.isadmin>
                            <button type="button" onclick="togglenewisbnform()" class="btn btn-warning btnxs">Edit
                            ISBN</button>
                            </cfif>
                        </span>
                    </div>
                </div>
                <div class="form-group">
                    <label for="title" class="col-lg-3 control-label">Title:</label>
                    <div class="col-lg-9">
                        <input type="text" class="form-control" id="booktitle" name="booktitle" value="#bookinfo.title[1]#"
                        placeholder="Insert Title Here" required maxlength="45"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="year" class="col-lg-3 control-label">Year:</label>
                    <div class="col-lg-9">
                        <input type="text" class="form-control" id="booktitle" name="booktitle" value="#bookinfo.year[1]#"
                        placeholder="Insert Year Here" required maxlength="45"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="publisher" class="control-label col-lg-3">Publisher</label>
                    <div class="col-lg-9">
                        <select id="publisher" class="form-control" name="publisher">
                            <option value="">
                            </option>
                            <cfloop query="allpubs">
                                <cfset sel=''>
                                <cfif trim(publisherid) eq trim(bookinfo.publisher[1])>
                                    <cfset sel='selected="selected"'>
                                </cfif>
                                <option value="#trim(publisherid)#" #sel#> #trim(name)#
                                </option>
                            </cfloop>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="genres" class="col-lg-3 control-label">Genres:</label>
                    <div class="col-lg-9">
                        <cfloop query="allgenres">
                            <input id="genre#genreid#" type="checkbox" name="genre" value="#genreid#"> #genrename#<br/>
                        </cfloop>
                    </div>
                </div>
                <cfloop query="bookgenres">
                        <script>document.getElementById('genre#genreid#').checked=true;</script>
                </cfloop>
                <div>
                    <label for="bookdesc">Description</label>
                    <textarea id="bookdesc" name="description">#trim(bookinfo.description[1])#</textarea>
                    <script>
                        CKEDITOR.replace('bookdesc');
                    </script>
            </div>
                <div class="form-group">
                    <label for="file" class="col-lg-3 control-label">&nbsp</label>
                    <div class="col-lg-9">
                        <input type="file" class="form-control" name="uploadimage">
                        <button type="submit" class="btn btn-primary">Save Book Data</button>
                    </div>
                </div>
                <input type="hidden" name="image" value="#trim(bookinfo.image[1])#">
                <cfif bookinfo.image[1] neq ''>
                    <img src="/jsebr66205/MyWebSite/images/#trim(bookinfo.image[1])#" style="float:left; width:250px; height:250px"/>
                </cfif>
            </form>
        </cfoutput>
    </cfif>
    </div>
</cffunction>