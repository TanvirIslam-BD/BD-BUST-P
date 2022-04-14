package com.tanvir.bsts

import grails.converters.JSON

class HoldTicketController {

    HoldTicketService holdTicketService

    def save(){
      boolean isSuccess = holdTicketService.save(params)
      render([success: isSuccess, message: "Ticket Hold"] as JSON)
    }

    def allHoldTickets(){
        def holdTickets = holdTicketService.allHoldTickets(params)
        render([holdTickets: holdTickets, message: "Ticket Hold"] as JSON)
    }

    def index() {
        def result = holdTicketService.list(params)
        session.activeTab = "HOLD TICKET"
        [holdTickets: result.list, total: result.count]
    }

    def delete(Integer id) {
        def response = holdTicketService.get(id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "holdTicket", action: "index")
        }else{
            response = holdTicketService.delete(response)
            if (!response){
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.delete"), false)
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "deleted"))
            }
            redirect(controller: "holdTicket", action: "index")
        }
    }

}
