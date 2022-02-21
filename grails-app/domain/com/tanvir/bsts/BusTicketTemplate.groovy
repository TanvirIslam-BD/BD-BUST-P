package com.tanvir.bsts

class BusTicketTemplate {

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
