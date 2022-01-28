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
            BSTS.messageBox.showMessage(Boolean(${flash.message?.success}), "${flash.message?.info}");
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
                            <div class="col-sm-6 col-md-5 mx-auto">

%{--                                <div class="account-wall">--}%
%{--                                    <h1 class="text-center login-title">Admin Login</h1>--}%
%{--                                    <g:img dir="images" file="usericon.png" class="profile-img"/>--}%
%{--                                    <g:form controller="authentication" action="doLogin" class="form-signin">--}%
%{--                                        <g:textField name="email" class="form-control" placeholder="Email" required="required" />--}%
%{--                                        <g:passwordField name="password" class="form-control" placeholder="Password" required="required" />--}%
%{--                                        <g:submitButton class="btn btn-lg btn-primary btn-block" name="login" value="Login"/>--}%
%{--                                    --}%%{--                            <g:link controller="authentication" action="registration" class="btn btn-lg btn-primary btn-block">Member Registration</g:link>--}%
%{--                                    </g:form>--}%
%{--                                </div>--}%

                                <section class="form-elegant">
%{--                                <g:submitButton class="btn btn-lg btn-primary btn-block" name="login" value="Login"/>--}%

                                    <!--Form without header-->
                                    <div class="card">

                                        <div class="card-body mx-4">

                                            <!--Header-->
                                            <div class="text-center">
                                                <h4 class="dark-grey-text mb-5"><strong>Sign in</strong></h4>
                                            </div>

                                            <!--Body-->
                                            <g:form controller="authentication" action="doLogin">
                                                <div class="md-form">
                                                    <g:textField name="email" class="form-control" placeholder="Email" required="required" />
                                                </div>

                                                <div class="md-form pb-3">
                                                    <g:passwordField name="password" class="form-control" placeholder="Password" required="required" />
                                                    <p class="font-small blue-text d-flex justify-content-end">Forgot <a href="#" class="blue-text ml-1">
                                                        Password?</a></p>
                                                </div>

                                                <div class="text-center mb-3">
                                                    <button type="submit" class="btn blue-gradient btn-block btn-rounded z-depth-1a">Sign in</button>
                                                </div>
                                            </g:form>

                                            <div class="row my-3 d-flex justify-content-center">
                                                <!--Facebook-->
                                                <button type="button" class="btn btn-white btn-rounded mr-md-3 z-depth-1a"><i class="fab fa-facebook-f blue-text text-center"></i></button>
                                                <!--Twitter-->
                                                <button type="button" class="btn btn-white btn-rounded mr-md-3 z-depth-1a"><i class="fab fa-twitter blue-text"></i></button>
                                                <!--Google +-->
                                                <button type="button" class="btn btn-white btn-rounded z-depth-1a"><i class="fab fa-google-plus-g blue-text"></i></button>
                                            </div>

                                        </div>

                                        <!--Footer-->
                                        <div class="modal-footer mx-5 pt-3 mb-1">
                                            <p class="font-small grey-text d-flex justify-content-end">Not a member? <g:link class="blue-text ml-1" controller="authentication" action="registration" >Sign Up</g:link>
                                            </p>
                                        </div>

                                    </div>
                                    <!--/Form without header-->

                                </section>



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

