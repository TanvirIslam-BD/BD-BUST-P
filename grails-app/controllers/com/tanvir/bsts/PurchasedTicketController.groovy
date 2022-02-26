package com.tanvir.bsts

class PurchasedTicketController {

    PurchasedTicketsService purchasedTicketsService

    def index() {
        def response = purchasedTicketsService.list(params)
        session.activeTab = "BOOKED TICKETS"
        [purchasedTickets: response.list, total:response.count]
    }
}
