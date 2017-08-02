<div id="topHeader" class="row">Cascade & Styles</div>
<div id="headerarea" class="row">
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#readDeseNav">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/jsebr66205/MyWebSite/index.cfm">
                <img src="/includes/classimages/rdb.png"/>
            </a>
        </div>
        <div class="collapse navbar-collapse" id="readDeseNav">
            <ul class="nav navbar-nav">
            <cfoutput>
                <li class="active"><a href="/jsebr66205/MyWebSite/index.cfm">Home</a></li>
                <li><a href="/jsebr66205/MyWebSite/index.cfm?p=content&con=AE9DAE14-D461-3878-73F1528BD7650953">About Cascade & Styles</a></li>
                 <li><a href="/jsebr66205/MyWebSite/index.cfm?p=content&con=AEF18785-B512-1AE9-C152ACAA123E1AF4">Contact Us</a></li>
            </cfoutput>
    <li>
                <li>
                    <cfoutput>
                    <form action="/jsebr66205/MyWebSite/index.cfm?p=details" method="post" class="navbar-form navbar-left" role="search">
                        <div class="form-group">
                            <input type="text" name="searchme" class="form-control" placeholder="Search">
                        </div>
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </form>
                    </cfoutput>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <cfoutput>
                    <cfif not session.isloggedin>
                        <li><a href="#cgi.SCRIPT_NAME#?p=login">Login</a></li>
                    <cfelse>
                        <li><a>Welcome #session.user.firstname#</a></li>
                        <cfif isdefined('session.isadmin') and session.isadmin>
                        <li><a href="/jsebr66205/MyWebSite/Management/index.cfm">Management</a></li>
                        </cfif>
                        <li><a href="/jsebr66205/MyWebSite/index.cfm?p=logout">logout</a></li>
                    </cfif>
                </cfoutput>
            </ul>
        </div>
    </div>
</nav>
