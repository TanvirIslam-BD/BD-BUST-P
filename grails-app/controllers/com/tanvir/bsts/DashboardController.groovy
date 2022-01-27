package com.tanvir.bsts

class DashboardController {

    CoachService coachService

    def index() {
        def response = coachService.list(params)
        [coach: response.list, total:response.count]
    }
}
