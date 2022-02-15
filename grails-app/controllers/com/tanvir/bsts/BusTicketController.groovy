package com.tanvir.bsts

class BusTicketController {

    BusTicketService busTicketService

    def index() {
        def response = busTicketService.list(params)
        session.activeTab = "Dashboard"
        [busTickets: response.list, total:response.count]
    }

    def details(Integer id) {
        def response = busTicketService.get(id)
        if (!response){
            redirect(controller: "busTicket", action: "index")
        }else{
            [busTicket: response]
        }
    }

    def create() {
        [busTicket: flash.redirectParams]
    }

    def save() {
        def response = busTicketService.save(params, request)
        if (response.isSuccess) {
            flash.message = AppUtil.infoMessage(g.message(code: "saved"))
            redirect(controller: "busTicket", action: "index")
        } else {
            flash.redirectParams = response.model
            flash.message = AppUtil.infoMessage(g.message(code: "unable.to.save"), false)
            redirect(controller: "busTicket", action: "create")
        }
    }


    def saveBookingTicket() {
        def response = busTicketService.saveBookingTicket(params, request)
        if (response.isSuccess) {
            flash.message = AppUtil.infoMessage(g.message(code: "booked"))
            redirect(controller: "busTicket", action: "details")
        } else {
            flash.redirectParams = response.model
            flash.message = AppUtil.infoMessage(g.message(code: "unable.to.book"), false)
            redirect(controller: "busTicket", action: "details")
        }
    }

    def edit(Integer id) {
        if (flash.redirectParams) {
            [busTicket: flash.redirectParams]
        } else {
            def response = busTicketService.get(id)
            if (!response) {
                flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
                redirect(controller: "busTicket", action: "index")
            } else {
                [busTicket: response]
            }
        }
    }

    def update() {
        def response = busTicketService.get(params.id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "busTicket", action: "index")
        }else{
            response = busTicketService.update(response, params, request)
            if (!response.isSuccess){
                flash.redirectParams = response.model
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.update"), false)
                redirect(controller: "busTicket", action: "edit")
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "updated"))
                redirect(controller: "busTicket", action: "index")
            }
        }
    }

    def delete(Integer id) {
        def response = busTicketService.get(id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "busTicket", action: "index")
        }else{
            response = busTicketService.delete(response)
            if (!response){
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.delete"), false)
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "deleted"))
            }
            redirect(controller: "busTicket", action: "index")
        }
    }
}
