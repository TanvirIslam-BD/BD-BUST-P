package com.tanvir.bsts

class BusTicketTemplate {

    Integer id

    String boardingTime

    String tripNo

    Route route

    SeatMap seatMap

    Coach coach

    String scheduleStartDateStr
    String scheduleEndDateStr

    Boolean isOnlineSale = false
    String seatClass = "ac"

    Double flatFare = 0.00

    Collection<TicketCounterTime> ticketCounterTimes

    static hasMany = [ticketCounterTimes: TicketCounterTime]

    static belongsTo = [route: Route, coach: Coach, seatMap: SeatMap]

    static constraints = {
        route(nullable: true)
        coach(nullable: true)
        scheduleStartDateStr(nullable: true)
        scheduleEndDateStr(nullable: true)
        tripNo(nullable: true)
        flatFare(nullable: true)
    }

}
