package com.tanvir.bsts

class HoldTicket {

   String tripId
   String routeId
   String date
   String seatNo

   String displayName

   Integer userId

   Date dateCreated
   Date lastUpdated


    static constraints = {
    }


    def beforeInsert (){
        this.dateCreated = new Date()
    }


    def beforeUpdate(){
        this.lastUpdated = new Date()
    }

    static mapping = {
        version(false)
    }
}
