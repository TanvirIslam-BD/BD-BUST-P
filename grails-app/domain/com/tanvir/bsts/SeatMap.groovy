package com.tanvir.bsts

class SeatMap {

    Integer id

    Long seatRows = 4
    Long seatColumns = 6
    String name = "24 SEAT"

    Date dateCreated
    Date lastUpdated

    static constraints = {

    }

    static mapping = {
        version(false)
    }
}
