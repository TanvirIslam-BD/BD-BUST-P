package com.tanvir.bsts

class Route  {

    Integer id

    String name = ""

    City districtFrom
    City districtTo

    Counter fromStoppage
    Counter toStoppage

    String status

    Date dateCreated
    Date lastUpdated

    Collection<Counter> counters = []

    static hasMany = [counters: Counter]


    static belongsTo = [
            fromStoppage: Counter,
            toStoppage: Counter,
            districtFrom: City,
            districtTo: City,
    ]

    static mappedBy = [fromStoppage: "none",toStoppage: "none",districtFrom: "none",districtTo: "none", counters: "routes"]

    static constraints = {
        fromStoppage(nullable: true)
        toStoppage(nullable: true)
        districtFrom(nullable: true)
        districtTo(nullable: true)
    }

    static mapping = {
        version(false)
    }

}
