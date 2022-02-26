package com.tanvir.bsts

import grails.gorm.MultiTenant

class BusTicket implements MultiTenant<BusTicket> {

    Integer id

    Date boardingDate

    String boardingTime

    Route route

    Coach coach

    Collection<PurchaseTicket> purchaseTickets

    static hasMany = [purchaseTickets: PurchaseTicket]

    static belongsTo = [route: Route, coach: Coach]

    static constraints = {
        purchaseTickets(nullable: true)
        route(nullable: true)
        coach(nullable: true)
    }
}
