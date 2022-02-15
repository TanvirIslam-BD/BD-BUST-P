package com.tanvir.bsts

class FaresController {

    FaresService faresService

    def index() {
        def response = faresService.list(params)
        session.activeTab = "Fares"
        [faresList: response.list, total:response.count]
    }

    def details(Integer id) {
        def response = faresService.get(id)
        if (!response){
            redirect(controller: "fares", action: "index")
        }else{
            [coach: response]
        }
    }

    def create() {
        [fares: flash.redirectParams]
    }

    def save() {
        def response = faresService.save(params, request)
        if (response.isSuccess) {
            flash.message = AppUtil.infoMessage(g.message(code: "saved"))
            redirect(controller: "fares", action: "index")
        } else {
            flash.redirectParams = response.model
            flash.message = AppUtil.infoMessage(g.message(code: "unable.to.save"), false)
            redirect(controller: "fares", action: "create")
        }
    }

    def edit(Integer id) {
        if (flash.redirectParams) {
            [fares: flash.redirectParams]
        } else {
            def response = faresService.get(id)
            if (!response) {
                flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
                redirect(controller: "fares", action: "index")
            } else {
                [fares: response]
            }
        }
    }

    def update() {
        def response = faresService.get(params.id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "fares", action: "index")
        }else{
            response = faresService.update(response, params, request)
            if (!response.isSuccess){
                flash.redirectParams = response.model
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.update"), false)
                redirect(controller: "fares", action: "edit")
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "updated"))
                redirect(controller: "fares", action: "index")
            }
        }
    }

    def delete(Integer id) {
        def response = faresService.get(id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "fares", action: "index")
        }else{
            response = faresService.delete(response)
            if (!response){
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.delete"), false)
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "deleted"))
            }
            redirect(controller: "fares", action: "index")
        }
    }


}
