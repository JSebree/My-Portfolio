<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Management</title>
    <link href="../../includes/bootstrap/css/bootstrap.css" rel="stylesheet" />
    <link href="../../includes/css/mycss.css" rel="stylesheet" />
    <script src="../../includes/js/jQuery/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="../../includes/bootstrap/js/bootstrap.js" type="text/javascript"></script>
    <script src="../../includes/ckeditor/ckeditor.js" type="text/javascript"></script>

</head>
<cfparam name="tool" default="addedit">
<body>
    <div id="wrapper" class="container">
        <div id="headerarea" class="row">
            <cfinclude template="../header.cfm" />
        </div>
        <div id="managementnav" class="row">
            <cfinclude template="managementnavbar.cfm" />
        </div>
        <div id="mainarea">
            <cfinclude template="#tool#.cfm">
        </div>
    </div>
        <div id="footer" class="row">
            <cfinclude template="../footer.cfm" />
        </div>
</body>
</html>