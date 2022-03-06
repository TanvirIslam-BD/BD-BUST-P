package com.tanvir.bsts

class DashboardController {

    CoachService coachService

    def index() {
        def response = []
        session.activeTab = "DASHBOARD"
        [busTickets: response.list, total:response.count]
    }
}
