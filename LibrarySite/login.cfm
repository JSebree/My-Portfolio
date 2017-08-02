<cfparam name="AccountMessage" default="">
<cfparam name="loginmessage" default="">
<cfset preprocess()>
<script>
    function validateNewAccount(){
        origpw=document.getElementById('newaccountpassword').value;
        confpw=document.getElementById('newaccountpasswordconfirm').value;
        if(origpw == confpw && origpw != '' && confpw != ''){
            document.getElementById('submitnewaccountform').click();
            document.getElementById('newaccountmessage').innerHTML="";
        }
        else{
            document.getElementById('newaccountmessage').innerHTML="These passwords do not match. Please try again.";
        }
    }
</script>

<div class="col-lg-6 col-md-6">
        <legend>Sign Up</legend>
    <cfoutput>
        <div id="newaccountmessage">
            #AccountMessage#
        </div>
            <form action="#cgi.SCRIPT_NAME#?p=login" method="post">
                <input type="hidden" name="newpersonid">
            <div class="form-group">
                <label for="firstname" class="col-sm-4 control-label">First Name</label>
                <div class="col-sm-6">
                    <input type="text" name="firstname" class="form-control" placeholder="First Name" required>
                </div>
            </div>
            <div class="form-group">
                <label for="lastname" class="col-sm-4 control-label">Last Name</label>
                <div class="col-sm-6">
                    <input type="text" name="lastname" class="form-control" placeholder="Last Name" required>
                </div>
            </div>
            <div class="form-group">
                <label for="email" class="col-sm-4 control-label">Email</label>
                <div class="col-sm-6">
                    <input type="email" name="email" class="form-control" placeholder="Email" required>
                </div>
            </div>
            <div class="form-group">
                <label for="newaccountpassword" class="col-sm-4 control-label">New Password</label>
                <div class="col-sm-6">
                    <input type="password" id="newaccountpassword" name="password" class="form-control" placeholder="Password" required>
                </div>
            </div>
            <div class="form-group">
                <label for="newaccountpasswordconfirm" class="col-sm-4 control-label">Confirm Password</label>
                <div class="col-sm-6">
                    <input type="password" name="password2" class="form-control" id="newaccountpasswordconfirm" placeholder="Confirm Password" required>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox"> Remember me
                        </label>
                    </div>
                </div>
            </div>
            <div class="col-sm-offset-2 col-sm-10">
                <button id="newaccountbutton" class="btn btn-warning" type="button"
                    onclick="validateNewAccount()">Make Account
                </button>
                    <input type="submit" id="submitnewaccountform" style="display:none" />
            </div>
        </form>
    </cfoutput>
</div>
<div class="col-lg-6 col-med-6">
<legend>Login</legend>
        <cfoutput>
            #loginmessage#
        </cfoutput>
        <cfoutput>
                <form action="#cgi.SCRIPT_NAME#?p=login" method="post">
                    <div class="form-group">
                        <label for="loginemail" class="col-sm-4 control-label">Login Email</label>
                        <div class="col-sm-6">
                            <input type="email" class="form-control" name="loginemail" id="loginemail" placeholder="Login Email" required><br>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="loginpass" class="col-sm-4 control-label">Password</label>
                        <div class="col-sm-6">
                            <input type="password" class="form-control" id="loginpass" name="loginpass" placeholder="Login Password" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox"> Remember me
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"></label>
                        <div class="col-sm-10">
                            <input type="submit" value="login" class="btn btn-primary" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">&nbsp</label>
                        <div class="col-sm-10">
                            <a href="#cgi.SCRIPT_NAME#?p=forgotpw">Forgot Password</a>
                        </div>
                    </div>
                </form>
        </cfoutput>
</div>

<cffunction name="preprocess" access="private">
    <cfif isdefined('form.newpersonid')>
        <cfset newid=createuuid()>
        <cfquery name="getemail" datasource="jsebr66205">
            select * from people where email='#form.email#'
        </cfquery>
        <cfif getemail.recordcount eq 0>
            <cfquery name="putin" datasource="jsebr66205">
				    insert into people (personid,firstname,lastname,email,isadmin)
                    values ('#newid#','#form.firstname#','#form.lastname#','#form.email#',#0#)
                </cfquery>
            <cfquery name="putinpassword" datasource="jsebr66205">
            	    insert into passwords (personid,password)
                    values ('#newid#','#hash(form.password,"SHA-256")#')
            </cfquery>
            Registration complete! Please Log in.
        <cfelse>
            <cfset AccountMessage="That email has already registered. Please login">
        </cfif>
    </cfif>
</cffunction>