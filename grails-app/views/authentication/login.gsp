<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>Online Bus Ticket Booking System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
    <asset:stylesheet src="application.css"/>
    <asset:stylesheet src="login.css"/>
    <asset:javascript src="application.js"/>

    <script type="text/javascript">
        <g:if test="${flash?.message && flash?.message?.info}">
        jQuery(document).ready(function () {
            OCB.messageBox.showMessage(Boolean(${flash.message?.success}), "${flash.message?.info}");
        });
        </g:if>
    </script>

</head>

<body>

<div class="container-fluid">
    <div class="row">
        <main role="main" class="col-sm-12 ml-sm-auto col-md-12 pt-3">

            <div id="global-wrapper">
                <div id="content-wrapper ">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-6 col-md-4 mx-auto">
                                <div class="account-wall">
                                    <h1 class="text-center login-title">Admin Login</h1>
                                    <g:img dir="images" file="usericon.png" class="profile-img"/>
                                    <g:form controller="authentication" action="doLogin" class="form-signin">
                                        <g:textField name="email" class="form-control" placeholder="Email" required="required" />
                                        <g:passwordField name="password" class="form-control" placeholder="Password" required="required" />
                                        <g:submitButton class="btn btn-lg btn-primary btn-block" name="login" value="Login"/>
                                    %{--                            <g:link controller="authentication" action="registration" class="btn btn-lg btn-primary btn-block">Member Registration</g:link>--}%
                                    </g:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </main>
    </div>
</div>


</body>
</html>

