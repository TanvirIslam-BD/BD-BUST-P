package com.tanvir.bsts

class BusTicketTemplate {

    Integer id

    String boardingTime

    Route route

    Coach coach

    String scheduleStartDateStr
    String scheduleEndDateStr

    static belongsTo = [route: Route, coach: Coach]

    static constraints = {
        route(nullable: true)
        coach(nullable: true)
        scheduleStartDateStr(nullable: true)
        scheduleEndDateStr(nullable: true)
    }
}
