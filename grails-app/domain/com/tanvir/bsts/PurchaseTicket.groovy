package com.tanvir.bsts

class PurchaseTicket {

    Long id

    String name
    String sex
    String email
    String mobile
    String age
    String passport
    Double discount

    Counter referencedCounter

    String address
    String nationality
    String boardingPlace

    Double totalPaid

    String seatBooked = ""


    Date dateCreated
    Date lastUpdated


    static belongsTo = [BusTicket, Counter]


    static constraints = {
        name(blank: false, size: 1..100, maxSize: 100)
        email(nullable: true)
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
        seatBooked(nullable: true)
    }

    def beforeValidate() {
        if(!this.dateCreated) {
            this.dateCreated = new Date()
        }
        if(!this.lastUpdated) {
            this.lastUpdated = new Date()
        }
    }

    def beforeUpdate() {
        this.lastUpdated = new Date()
    }
}
