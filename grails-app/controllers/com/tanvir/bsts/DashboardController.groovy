package com.tanvir.bsts

class DashboardController {

    CoachService coachService

    def index() {
        redirect(controller: "busTicket", action: "index")
    }
}
