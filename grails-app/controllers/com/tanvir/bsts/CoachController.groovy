package com.tanvir.bsts

class CoachController {

    CoachService coachService

    def index() {
        session.activeTab = "Coaches"
        def response = coachService.list(params)
        [coach: response.list, total:response.count]
    }

    def details(Integer id) {
        def response = coachService.get(id)
        if (!response){
            redirect(controller: "coach", action: "index")
        }else{
            [coach: response]
        }
    }

    def create() {
        [coach: flash.redirectParams]
    }

    def save() {
        def response = coachService.save(params, request)
        if (response.isSuccess) {
            flash.message = AppUtil.infoMessage(g.message(code: "saved"))
            redirect(controller: "coach", action: "index")
        } else {
            flash.redirectParams = response.model
            flash.message = AppUtil.infoMessage(g.message(code: "unable.to.save"), false)
            redirect(controller: "coach", action: "create")
        }
    }

    def edit(Integer id) {
        if (flash.redirectParams) {
            [coach: flash.redirectParams]
        } else {
            def response = coachService.get(id)
            if (!response) {
                flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
                redirect(controller: "coach", action: "index")
            } else {
                [coach: response]
            }
        }
    }

    def update() {
        def response = coachService.get(params.id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "coach", action: "index")
        }else{
            response = coachService.update(response, params, request)
            if (!response.isSuccess){
                flash.redirectParams = response.model
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.update"), false)
                redirect(controller: "coach", action: "edit")
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "updated"))
                redirect(controller: "coach", action: "index")
            }
        }
    }

    def delete(Integer id) {
        def response = coachService.get(id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "coach", action: "index")
        }else{
            response = coachService.delete(response)
            if (!response){
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.delete"), false)
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "deleted"))
            }
            redirect(controller: "coach", action: "index")
        }
    }
}
