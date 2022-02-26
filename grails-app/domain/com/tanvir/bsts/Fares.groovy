package com.tanvir.bsts


class Fares {

    Integer id

    Route route

    City districtFrom
    City districtTo

    Counter fromStoppage
    Counter toStoppage

    Double amount = 0.00

    String seatClass = "AC"

    String status

    Date dateCreated
    Date lastUpdated


    static belongsTo = [
            fromStoppage: Counter,
            toStoppage: Counter,
            districtFrom: City,
            districtTo: City,
            route: Route,
    ]

    static mappedBy = [route: "none", fromStoppage: "none",toStoppage: "none",districtFrom: "none",districtTo: "none"]

    static constraints = {
        fromStoppage(nullable: true)
        toStoppage(nullable: true)
        districtFrom(nullable: true)
        districtTo(nullable: true)
        route(nullable: true)
    }

    static mapping = {
        version(false)
    }

}
