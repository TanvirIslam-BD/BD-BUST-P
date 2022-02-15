package com.tanvir.bsts

class BusTicket {

    Integer id

    Date boardingTimeAndDate

    Fares fares

    Coach coach

    Collection<PurchaseTicket> purchaseTickets

    static hasMany = [purchaseTickets: PurchaseTicket]

    static constraints = {

    }
}
