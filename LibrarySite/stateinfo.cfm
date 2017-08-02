<cfif not isdefined('session.user')>
    <cfset session.isLoggedIn=false>
    <cfset session.user=structnew()>
    <cfset session.user.firstname=''>
    <cfset session.user.lastname=''>
    <cfset session.user.acctnumber=''>
    <cfset session.user.email=''>
    <cfset session.isadmin=false>
</cfif>

<cfif isdefined('url.p') and url.p eq 'logout'>
    <cfset StructClear(session)>
    <cfset session.isloggedin=false>
    <cfset p="login">
</cfif>

<cfif isdefined('form.loginemail')>
    <cfquery name="access" datasource="jsebr66205">
        select * from people
        inner join passwords on people.personid=passwords.personid
        where email='#form.loginemail#' and password='#hash(form.loginpass,"SHA-256")#'
    </cfquery>
    <cfif access.recordcount gt 0>
        <cfset session.user.firstname=access.firstname[1]>
        <cfset session.user.lastname=access.lastname[1]>
        <cfset session.user.email=access.email[1]>
        <cfset session.user.acctnumber=access.personid[1]>
        <cfset session.isloggedin=true>
        <cfset session.isadmin=access.isadmin[1]>
        <cfset p="carousel">
    <cfelse>
        <cfset loginmessage="Sorry, that login doesn't match">
    </cfif>
</cfif>