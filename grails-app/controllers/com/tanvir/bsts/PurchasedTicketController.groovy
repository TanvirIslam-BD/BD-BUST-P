package com.tanvir.bsts

class PurchasedTicketController {

    PurchasedTicketsService purchasedTicketsService

    def index() {
        def response = purchasedTicketsService.list(params)
        session.activeTab = "Booked Tickets"
        [purchasedTickets: response.list, total:response.count]
    }
}
