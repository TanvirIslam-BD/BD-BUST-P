package com.tanvir.bsts

import grails.gorm.MultiTenant

class Coach implements MultiTenant<Coach> {

    Integer id

    String name

    String coachNumber
    String seatClass = "ac"
    String registrationNumber
    Integer seatCapacity
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
