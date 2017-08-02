<cfparam name="searchme" default="">
<cfparam name="publisher" default="">
<cfparam name="genre" default="">
<cfparam name="year" default="">

<cfif searchme neq '' or genre neq '' or publisher neq '' or year neq ''>
    <cfif genre neq ''>
        <cfquery name="bookinfo" datasource="#application.dsource#">
			select * from books
			inner join genrestobooks on books.isbn13=genrestobooks.isbn13
            inner join publishers on books.publisher=publishers.publisherid
            inner join people on books.author=people.personid
            where genreid='#genre#'
		</cfquery>
    <cfelseif publisher neq ''>
        <cfquery name="bookinfo" datasource="#application.dsource#">
   			select * from books
            inner join publishers on books.publisher=publishers.publisherid
            inner join people on books.author=people.personid
            where publishers.publisherid like '%#publisher#%'
    	</cfquery>
        <cfelseif year neq ''>
        <cfquery name="bookinfo" datasource="#application.dsource#">
   			select * from books
   			inner join people on books.author=people.personid
   			inner join publishers on books.publisher=publishers.publisherid
            where books.year like '%#year#%'
    	</cfquery>
    <cfelse>
        <cfquery name="bookinfo" datasource="#application.dsource#">
   			select * from books
            inner join publishers on books.publisher=publishers.publisherid
            inner join people on books.author=people.personid
            where title like '%#searchme#%' or isbn13 like '%#searchme#%'or year like '%#searchme#%'
    	</cfquery>
    </cfif>
    <cfif bookinfo.recordcount eq 0>
        Sorry. It appears we do not have that book. Please search a different title.
    <cfelseif bookinfo.recordcount gt 1>
        We found the following:
    <ul>
    <cfoutput query="bookinfo">
            <li><a href="#cgi.SCRIPT_NAME#?p=details&searchme=#isbn13#">#title#</a></li>
    </cfoutput>
    </ul>
    <cfelseif bookinfo.recordcount eq 1>
    <cfoutput>
        <img src="images/#bookinfo.image[1]#" style="float:left; width:250px; height:250px; padding: 0px 10px 10px 0px;"/>
        Title: #bookinfo.title[1]#<br/>
        Year: <a href="#cgi.SCRIPT_NAME#?p=details&year=#bookinfo.year[1]#">#bookinfo.year[1]#</a><br/>
        Author: #bookinfo.firstname# #bookinfo.lastname#<br/>
        ISBN13: #bookinfo.isbn13[1]#<br/>
        Publisher: <a href="#cgi.SCRIPT_NAME#?p=details&publisher=#bookinfo.publisherid[1]#">#bookinfo.name[1]#</a><br/>
        Description: #bookinfo.description[1]#<br/>
    </cfoutput>
    </cfif>
</cfif>