package com.tanvir.bsts


class Counter {

    Integer id

    Integer sequence = 0
    String name = ""

    String status

    String type = GlobalConfig.COUNTER_TYPE.AGENT

    Collection<Fares> fares = []

    Date dateCreated
    Date lastUpdated

    static hasMany = [fares: Fares]

    static mappedBy = [fares: "counters"]

    static constraints = {

    }

}
