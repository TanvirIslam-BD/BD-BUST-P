package com.tanvir.bsts

class Trip {

    Integer ticketScheduleId

    Integer driverId
    Integer supervisorId
    Integer helperId

    String scheduleDate

    boolean  isActive = true

    static constraints = {
        driverId(nullable: true)
        supervisorId(nullable: true)
        helperId(nullable: true)
    }
}
