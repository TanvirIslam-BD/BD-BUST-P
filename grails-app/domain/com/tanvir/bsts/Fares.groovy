package com.tanvir.bsts

class Fares {

    Integer id

    String name = ""

    Counter fromStoppage
    Counter toStoppage

    Double amount = 0.00

    String seatClass = "AC"

    String status

    Date dateCreated
    Date lastUpdated

    static constraints = {

    }
}
