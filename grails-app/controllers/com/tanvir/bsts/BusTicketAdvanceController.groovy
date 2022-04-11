package com.tanvir.bsts

import grails.converters.JSON

class BusTicketAdvanceController {

    BusTicketService busTicketService
    PurchasedTicketsService purchasedTicketsService
    MemberService memberService

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
       def toCity = response?.route?.districtTo
       [       date: params.date,toCity: toCity, bookedSeats: bookedSeats, busTicket: response, selectedSeat: selectedSeat,
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


    def checkSeatAvailability() {
       def isAvailableSeatToBook = busTicketService.checkSeatAvailability(params)
       if(isAvailableSeatToBook){
           render([isAvailableSeatToBook: true] as JSON)
       }else {
           render([isAvailableSeatToBook: false] as JSON)
       }
    }

    def saveBookingTicket() {
        def permissionKey = "tickerBookingPermission"
        boolean hasPermission = memberService.userPermissionCheck(permissionKey)
        if(hasPermission){
            def response = busTicketService.saveBookingTicketAdvance(params, request)
            if (response.isSuccess) {
                flash.message = AppUtil.infoMessage("Successfully Booked")
                redirect(controller: "busTicketAdvance", action: "bookingPanel", params: [id: params.busTicketId, date: params.scheduledDate])
            } else {
                flash.redirectParams = response.model
                flash.message = AppUtil.infoMessage("Unable to Book")
                redirect(controller: "busTicketAdvance", action: "bookingPanel", params: [isSuccess: false, id: params.busTicketId, date: params.scheduledDate])
            }
        }else {
            flash.redirectParams = response.model
            flash.message = AppUtil.infoMessage("Sorry! You don't have permission to book ticket")
            redirect(controller: "busTicketAdvance", action: "bookingPanel", params:[id: params.busTicketId, date: params.scheduledDate])
        }
    }

    def returnBookedTicket() {
        def permissionKey = "ticketReturnPermission"
        boolean hasPermission = memberService.userPermissionCheck(permissionKey)
        if(hasPermission){
            def response = busTicketService.returnBookedTicket(params, request)
            if (response.isSuccess) {
                flash.message = AppUtil.infoMessage("Successfully Returned")
                redirect(controller: "busTicketAdvance", action: "bookingPanel", params: [id: params.busTicketId, date: params.scheduledDate])
            } else {
                flash.redirectParams = response.model
                flash.message = AppUtil.infoMessage("Unable to Returned")
                redirect(controller: "busTicketAdvance", action: "bookingPanel", params: [id: params.id, date: params.date])
            }
        }else {
            flash.redirectParams = response.model
            flash.message = AppUtil.infoMessage("You don't have permission to returned")
            redirect(controller: "busTicketAdvance", action: "bookingPanel", params: [id: params.id, date: params.date])
        }

    }

    def soldTicketsReport() {
        def permissionKey = "ticketReportViewPermission"
        boolean hasPermission = false
        hasPermission = memberService.userPermissionCheck(permissionKey)
        if(hasPermission){
            def ticketId = params?.id?.toLong()
            def busTicket = busTicketService.get(ticketId)
            def response = purchasedTicketsService.soldList(params)
            def soldList = response.list
            def totalSeatSold = soldList.totalBookedSeat.sum()
            def totalFare = soldList.totalPaid.sum()
            def totalReceived = soldList.receivedAmountAfterCommission.sum()
            def totalDiscount = soldList.discount.sum()
            def totalCommission = soldList.commission.sum()
            [       success: true,
                    soldList: soldList, total: response.count, totalSeatSold: totalSeatSold,
                    totalFare: totalFare, totalReceived: totalReceived, totalDiscount: totalDiscount,
                    totalCommission: totalCommission, busTicket: busTicket, date: params.date
            ]
        }else{
            [success: false, message: "You don't have permission to view the report"]
        }
    }





}
