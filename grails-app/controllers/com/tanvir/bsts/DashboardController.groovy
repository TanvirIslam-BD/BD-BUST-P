package com.tanvir.bsts

class DashboardController {

    def index() {
        def response = []
        session.activeTab = "DASHBOARD"
        def todayMoney = PurchaseTicket.findAllByPaymentType("sell")?.sum { it.receivedFromCustomer} ?: 0
        def todayBooking = PurchaseTicket.findAllByPaymentType("book")?.sum { it.receivedFromCustomer} ?: 0
        def sales = PurchaseTicket.findAllByPaymentType("sell")?.sum { it.receivedFromCustomer} ?: 0
        def todayReturn = PurchaseTicket.findAllByIsReturned(true)?.sum { it.returnedAmount} ?: 0

        [todayMoney: todayMoney, sales: sales, todayBooking: todayBooking,  todayReturn: todayReturn]
    }
}
