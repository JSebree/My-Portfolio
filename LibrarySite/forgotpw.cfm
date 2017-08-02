<cfif isdefined('form.lastname')>
    <cfoutput>#newpassform()#
    </cfoutput>
    <cfelseif isdefined('form.password')>
    <cfoutput>
        <cfquery name="putin" datasource="jsebr66205">
        	if not exists(select * from passwords where personid='#form.personid#')
            insert into passwords (personid) values ('#form.personid#');
            update passwords
    	    set password='#hash(form.password,"SHA-256")#'
        	WHERE personid='#form.personid#'
		</cfquery>
    </cfoutput>
    <cflocation url="index.cfm?p=login" />
<cfelse>
    <cfset authform()>
</cfif>

<cffunction name="newpassform">
    <cfoutput>
        <cfquery name="person" datasource="jsebr66205">
    	    select * from people where lastname='#form.lastname#' and email='#form.email#'
        </cfquery>
    </cfoutput>
    <cfif person.recordcount gt 0>
        <script>
            function validateNewAccount(){
                origpw=document.getElementById('newaccountpassword').value;
                confpw=document.getElementById('newaccountpasswordconfirm').value;
                if(origpw == confpw && origpw != '' && confpw != ''){
                    document.getElementById('submitnewaccountform').click();
                    document.getElementById('newaccountmessage').innerHTML="";
                }
                else{
                    document.getElementById('newaccountmessage').innerHTML="These passwords do not match. " +
                            "Please try again.";
                }
            }
        </script>

        <cfoutput>
            <div id="newaccountmessage"></div>
            <form action="#cgi.SCRIPT_NAME#?p=forgotpw" method="post">
                <input type="hidden" name="personid" value="#person.personid#" />
            <div class="form-group">
                <label for="title" class="col-sm-5 control-label">Password</label>
                <div class="col-sm-5">
                    <input id="newaccountpassword" type="password" name="password" required>
                </div>
            </div>
            <div class="form-group">
                <label for="title" class="col-sm-5 control-label">Confirm Password</label>
                <div class="col-sm-5">
                    <input id="newaccountpasswordconfirm" type="password" name="confirmpw" required>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 control-label">&nbsp</label>
                <div class="col-sm-5">
                    <button id="newaccountbutton" class="btn btn-warning" type="button" onclick="validateNewAccount()">
                        Reset Password
                    </button>
                    <input type="submit" id="submitnewaccountform" style="display:none" />
                </div>
            </div>
            </form>
        </cfoutput>
    <cfelse>
        Incorrect last name or email. Please try again.
    </cfif>
</cffunction>

<cffunction name="authform">
    <cfoutput>
    <div>
        Enter your last and email address.
    </div>
    <form action="#cgi.SCRIPT_NAME#?p=forgotpw" method="post">
        <div class="form-group">
            <label for="lastname" class="col-sm-5 control-label">Last Name</label>
            <div class="col-sm-5">
                <input type="text" name="lastname" required>
            </div>
        </div>
        <div class="form-group">
            <label for="email" class="col-sm-5 control-label">Email Address</label>
            <div class="col-sm-5">
                <input type="email" name="email" required>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">&nbsp</label>
            <div class="col-sm-10">
                <input type="submit" value="login" class="btn btn-primary" />
            </div>
        </div>
    </form>
    </cfoutput>
</cffunction>