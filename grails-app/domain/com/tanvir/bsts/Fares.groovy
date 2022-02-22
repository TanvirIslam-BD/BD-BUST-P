package com.tanvir.bsts

import grails.gorm.MultiTenant

class Fares implements MultiTenant<Fares> {

    Integer id

    String name = ""

    Counter fromStoppage
    Counter toStoppage

    Double amount = 0.00

    String seatClass = "AC"

    String status

    Date dateCreated
    Date lastUpdated

    Collection<Counter> counters = []

    static hasMany = [counters: Counter]


    static belongsTo = [
            fromStoppage: Counter,
            toStoppage: Counter,
    ]

    static mappedBy = [fromStoppage: "none",toStoppage: "none", counters: "fares"]

    static constraints = {
        fromStoppage(nullable: true)
        toStoppage(nullable: true)
    }
}
