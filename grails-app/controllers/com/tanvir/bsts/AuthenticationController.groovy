package com.tanvir.bsts

class AuthenticationController {

    AuthenticationService authenticationService
    MemberService memberService

    def login() {
        if (authenticationService.isAuthenticated()) {
            redirect(controller: "busTicket", action: "index")
        }
    }

    def doLogin() {
        if (authenticationService.doLogin(params.email, params.password)) {
            redirect(controller: "busTicket", action: "index")
        } else {
            flash.message = AppUtil.infoMessage("Email Address or Password not Valid.", false)
            redirect(controller: "authentication", action: "login")
        }
    }


    def logout() {
        session.invalidate()
        redirect(controller: "authentication", action: "login")
    }

    def registration() {
        [member: flash.redirectParams]
    }


    def doRegistration() {
        def response = memberService.save(params)
        if (response.isSuccess) {
            authenticationService.setMemberAuthorization(response.model)
            redirect(controller: "busTicket", action: "index")
        } else {
            flash.redirectParams = response.model
            redirect(controller: "authentication", action: "registration")
        }
    }

}
