package com.tanvir.bsts

class PurchaseTicket {

    Long id

    String name
    String sex
    String mobile
    String passport
    Double discount

    Counter fromCounter
    Counter toCounter

    Double totalPaid
    String seatBooked = ""
    String seatBookedForDisplay = ""
    Integer totalBookedSeat = 0
    String coachNo = "00"

    String routeName
    String scheduledDate
    String departureTime

    Member saleBy
    Long busTicketTemplateId

    Date dateCreated
    Date lastUpdated


    boolean isReturned = false
    Double returnedAmount = 0.0


    String paymentType = "book"
    Double receivedFromCustomer = 0.0
    Double dueAmount = 0.0


    static belongsTo = [
            fromCounter: Counter,
            toCounter: Counter,
            saleBy: Member,
    ]

    static constraints = {
        name(blank: false, size: 1..100, maxSize: 100)
        sex(nullable: true, maxSize: 100)
        discount(nullable: true)
        passport(nullable: true)
        mobile(nullable: true)
        totalPaid(nullable: true)
        seatBooked(nullable: true)
        routeName(nullable: true)
        departureTime(nullable: true)
        coachNo(nullable: true)
        seatBookedForDisplay(nullable: true)
        busTicketTemplateId(nullable: true)
        toCounter(nullable: true)
        isReturned(nullable: true)
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
