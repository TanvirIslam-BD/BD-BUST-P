package com.tanvir.bsts

class TicketCounterTime {

    Counter counter
    String startTime


    static belongsTo = [
            counter: Counter
    ]

    static constraints = {
        counter(nullable: true)
        startTime(nullable: true)
    }

}
