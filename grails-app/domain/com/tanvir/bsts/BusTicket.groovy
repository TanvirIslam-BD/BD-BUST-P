package com.tanvir.bsts

class BusTicket {

    Integer id

    Date boardingDate

    String boardingTime

    Fares fares

    Coach coach

    Collection<PurchaseTicket> purchaseTickets

    static hasMany = [purchaseTickets: PurchaseTicket]

    static belongsTo = [fares: Fares, coach: Coach]

    static constraints = {
        purchaseTickets(nullable: true)
        fares(nullable: true)
        coach(nullable: true)
    }
}
