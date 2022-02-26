package com.tanvir.bsts


class Counter {

    Integer id

    Integer sequence = 0
    String name = ""

    String status
    String code

    String type = GlobalConfig.COUNTER_TYPE.AGENT

    Collection<Route> routes = []
    City city

    Date dateCreated
    Date lastUpdated

    static hasMany = [routes: Route]

    static belongsTo = City

    static mappedBy = [routes: "counters"]

    static constraints = {

    }

    static mapping = {
        version(false)
    }

}
