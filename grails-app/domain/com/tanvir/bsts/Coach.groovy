package com.tanvir.bsts

class Coach {

    Integer id

    String name

    String coachNumber
    String seatClass = "ac"
    String registrationNumber
    String seatCapacity
    SeatMap seatMap

    String status

    Member member

    Date dateCreated
    Date lastUpdated

    static constraints = {

    }

    static belongsTo = SeatMap

    static mapping = {
        version(false)
    }
}
