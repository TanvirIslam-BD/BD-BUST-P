package com.tanvir.bsts

import grails.gorm.MultiTenant

class BusTicketTemplate implements MultiTenant<BusTicketTemplate> {

    Integer id

    String boardingTime

    Fares fares

    Coach coach

    static belongsTo = [fares: Fares, coach: Coach]

    static constraints = {
        fares(nullable: true)
        coach(nullable: true)
    }
}
