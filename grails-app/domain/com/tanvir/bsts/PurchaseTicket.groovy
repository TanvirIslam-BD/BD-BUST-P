package com.tanvir.bsts

class PurchaseTicket {

    Long id
    Long displayId

    String name
    String sex
    String userName
    String mobile
    String age
    String passport
    Double discount

    Counter referencedCounter

    String address
    String nationality
    String boardingPlace

    Double totalPaid

    String bookedSeats = ""


    static belongsTo = [BusTicket, Counter]



    static constraints = {
        name(blank: false, size: 1..100, maxSize: 100)
        userName(blank: false, unique: true, maxSize: 100)
        sex(nullable: true, maxSize: 100)
        boardingPlace(nullable: true)
        address(nullable: true)
        referencedCounter(nullable: true)
        discount(nullable: true)
        nationality(nullable: true)
        passport(nullable: true)
        age(nullable: true)
        mobile(nullable: true)
        totalPaid(nullable: true)
        bookedSeats(nullable: true)
        displayId(nullable: true)
    }

    def beforeValidate() {
        if(!this.created) {
            this.created = new Date().gmt()
        }
        if(!this.updated) {
            this.updated = new Date().gmt()
        }
    }

    def beforeUpdate() {
        this.updated = new Date().gmt()
    }
}
