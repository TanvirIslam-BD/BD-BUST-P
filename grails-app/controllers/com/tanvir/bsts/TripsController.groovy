package com.tanvir.bsts

import grails.converters.JSON


class TripsController {

    BusTicketService busTicketService

    def index() {
        def response = busTicketService.tripList(params)
        session.activeTab = "TRIP"
        [currentDate: response.currentDate, busTickets: response.list, total:response.count]
    }


    def active() {
        def response = busTicketService.activateTrip(params)
        if (!response){
            flash.message = AppUtil.infoMessage("Activated", true)
        }else{
            flash.message = AppUtil.infoMessage("Deactivated")
        }
        render([success: response] as JSON)
    }

}

