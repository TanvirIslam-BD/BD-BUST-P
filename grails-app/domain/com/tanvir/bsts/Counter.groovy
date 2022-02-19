package com.tanvir.bsts

class Counter {

    Integer id

    Integer sequence = 0
    String name = ""

    String status

    String type = GlobalConfig.COUNTER_TYPE.AGENT

    Date dateCreated
    Date lastUpdated

    static constraints = {

    }

}
