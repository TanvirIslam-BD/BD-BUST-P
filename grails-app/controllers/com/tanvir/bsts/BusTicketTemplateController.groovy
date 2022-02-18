package com.tanvir.bsts

class BusTicketTemplateController {

    BusTicketService busTicketService

    def index() {
        def response = busTicketService.listOfTicketTemplates(params)
        session.activeTab = "TicketTemplates"
        [busTicketTemplates: response.list, total:response.count]
    }

    def details() {
        def response = busTicketService.getTicketTemplate(params.id)
        if (!response){
            redirect(controller: "busTicketTemplate", action: "index")
        }else{
            [busTicketTemplate: response]
        }
    }

    def create() {
        [busTicketTemplate: flash.redirectParams]
    }

    def save() {
        def response = busTicketService.saveTicketTemplate(params, request)
        if (response.isSuccess) {
            flash.message = AppUtil.infoMessage(g.message(code: "saved"))
            redirect(controller: "busTicketTemplate", action: "index")
        } else {
            flash.redirectParams = response.model
            flash.message = AppUtil.infoMessage(g.message(code: "unable.to.save"), false)
            redirect(controller: "busTicketTemplate", action: "create")
        }
    }

    def edit(Integer id) {
        if (flash.redirectParams) {
            [busTicketTemplate: flash.redirectParams]
        } else {
            def response = busTicketService.getTicketTemplate(id)
            if (!response) {
                flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
                redirect(controller: "busTicketTemplate", action: "index")
            } else {
                [busTicketTemplate: response]
            }
        }
    }

    def update() {
        def response = busTicketService.getTicketTemplate(params.id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "busTicketTemplate", action: "index")
        }else{
            response = busTicketService.updateTicketTemplate(response, params, request)
            if (!response.isSuccess){
                flash.redirectParams = response.model
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.update"), false)
                redirect(controller: "busTicketTemplate", action: "edit")
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "updated"))
                redirect(controller: "busTicketTemplate", action: "index")
            }
        }
    }

    def delete(Integer id) {
        def response = busTicketService.getTicketTemplate(id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "busTicketTemplate", action: "index")
        }else{
            response = busTicketService.deleteTicketTemplate(response)
            if (!response){
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.delete"), false)
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "deleted"))
            }
            redirect(controller: "busTicketTemplate", action: "index")
        }
    }

}
