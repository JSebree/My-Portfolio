<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>My Website</title>
    <script src="../includes/js/jQuery/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="../includes/bootstrap/js/bootstrap.js" type="text/javascript"></script>
    <link href="../includes/bootstrap/css/bootstrap.css" rel="stylesheet" />
    <link href="../includes/css/mycss.css" rel="stylesheet" />
</head>
<cfparam name="p" default="carousel" />
<cfinclude template="stateinfo.cfm" />
<body>
<div id="wrapper" class="container">
        <cfinclude template="header.cfm" />
    </div>
    <div id="maincontent" class="row">
        <div id="center" class="col-lg-9 col-md-9 col-md-push-3 col-lg-push-3">
        <cfinclude template="#p#.cfm" />
        </div>
        <div id="leftgutter" class="col-lg-3 col-md-3 col-md-pull-9 col-lg-pull-9">
        <cfinclude template="genrenav.cfm" />
        </div>
    </div>
    <div id="footer" class="row" class="footer">
        <cfinclude template="footer.cfm" />
    </div>
</div>
</body>
</html>
