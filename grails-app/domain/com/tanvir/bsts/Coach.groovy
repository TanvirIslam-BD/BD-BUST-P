package com.tanvir.bsts

class Coach {

    Integer id
    String coachNumber
    String registrationNumber
    String seatCapacity
    String seatPlan

    String status

    Member member

    Date dateCreated
    Date lastUpdated

    static constraints = {

    }

    static mapping = {
        version(false)
    }
}
