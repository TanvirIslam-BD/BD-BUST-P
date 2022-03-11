package com.tanvir.bsts

import grails.converters.JSON

class BusTicketAdvanceController {

    BusTicketService busTicketService

    def index() {
        def response = busTicketService.list(params)
        session.activeTab = "BOOK/SELL"
        [busTickets: response.list, total:response.count]
    }

   def bookingPanel() {
       def response = busTicketService.getAdvancedTicket(params.id)
       def purchaseTickets = busTicketService.getPurchaseTicketsAdvance(response, params.date)
       def femaleSoldSeats = busTicketService.getFemaleSoldSeatsAdvance(response, params.date)
       def bookedSeats = busTicketService.getBookedSeatsAdvance(response, params.date)
       def femaleBookedSeats = busTicketService.getFemaleBookedSeats(response, params.date)
       def routeCounters = busTicketService.getRouteCountersAdvance(response)
       def routeCountersFrom = busTicketService.getRouteCountersFromAdvance(response)
       def routeCountersTo = busTicketService.getRouteCountersToAdvance(response)
       def selectedSeat = busTicketService.getTicketSeat(params.ticketNo)
       [       date: params.date, bookedSeats: bookedSeats, busTicket: response, selectedSeat: selectedSeat,
               routeCountersFrom: routeCountersFrom, routeCountersTo: routeCountersTo, femaleBookedSeats: femaleBookedSeats,
               purchaseTickets: purchaseTickets, femaleSoldSeats: femaleSoldSeats, routeCounters: routeCounters, returnedTicketId: params.ticketNo,
       ]
    }


    def loadTicketSchedules() {
       def routeId = params.routeId
       def date = params.date
       def scheduleList = busTicketService.getScheduleItemList(routeId, date)
       render(scheduleList as JSON)
    }


    def saveBookingTicket() {
        def response = busTicketService.saveBookingTicketAdvance(params, request)
        if (response.isSuccess) {
            flash.message = AppUtil.infoMessage("Successfully Booked")
            redirect(controller: "busTicketAdvance", action: "bookingPanel", params: [id: params.busTicketId, date: params.scheduledDate])
        } else {
            flash.redirectParams = response.model
            flash.message = AppUtil.infoMessage("Unable to Book")
            redirect(controller: "busTicketAdvance", action: "bookingPanel", params: [id: params.id, date: params.date])
        }
    }

    def returnBookedTicket() {
        def response = busTicketService.returnBookedTicket(params, request)
        if (response.isSuccess) {
            flash.message = AppUtil.infoMessage("Successfully Returned")
            redirect(controller: "busTicketAdvance", action: "bookingPanel", params: [id: params.busTicketId, date: params.scheduledDate])
        } else {
            flash.redirectParams = response.model
            flash.message = AppUtil.infoMessage("Unable to Returned")
            redirect(controller: "busTicketAdvance", action: "bookingPanel", params: [id: params.id, date: params.date])
        }
    }

}
