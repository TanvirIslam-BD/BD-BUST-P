package com.tanvir.bsts

import grails.gorm.MultiTenant

class SeatMap implements MultiTenant<SeatMap> {

    Integer id

    Long seatRows = 4
    Long seatColumns = 10
    boolean extraSeatInLastRow = true
    String name = ""

    Date dateCreated
    Date lastUpdated

    static constraints = {

    }
}
