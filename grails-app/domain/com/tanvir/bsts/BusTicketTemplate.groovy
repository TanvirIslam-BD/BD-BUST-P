package com.tanvir.bsts

import grails.gorm.MultiTenant

class BusTicketTemplate implements MultiTenant<BusTicketTemplate> {

    Integer id

    String boardingTime

    Route route

    Coach coach

    static belongsTo = [route: Route, coach: Coach]

    static constraints = {
        route(nullable: true)
        coach(nullable: true)
    }
}
