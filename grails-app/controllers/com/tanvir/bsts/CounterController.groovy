package com.tanvir.bsts

class CounterController {

    CounterService counterService

    def index() {
        def response = counterService.list(params)
        session.activeTab = "Counters"
        [counters: response.list, total:response.count]
    }

    def details(Integer id) {
        def response = counterService.get(id)
        if (!response){
            redirect(controller: "counter", action: "index")
        }else{
            [coach: response]
        }
    }

    def create() {
        [counter: flash.redirectParams]
    }

    def save() {
        def response = counterService.save(params, request)
        if (response.isSuccess) {
            flash.message = AppUtil.infoMessage(g.message(code: "saved"))
            redirect(controller: "counter", action: "index")
        } else {
            flash.redirectParams = response.model
            flash.message = AppUtil.infoMessage(g.message(code: "unable.to.save"), false)
            redirect(controller: "counter", action: "create")
        }
    }

    def edit(Integer id) {
        if (flash.redirectParams) {
            [counter: flash.redirectParams]
        } else {
            def response = counterService.get(id)
            if (!response) {
                flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
                redirect(controller: "counter", action: "index")
            } else {
                [counter: response]
            }
        }
    }

    def update() {
        def response = counterService.get(params.id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "counter", action: "index")
        }else{
            response = counterService.update(response, params, request)
            if (!response.isSuccess){
                flash.redirectParams = response.model
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.update"), false)
                redirect(controller: "counter", action: "edit")
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "updated"))
                redirect(controller: "counter", action: "index")
            }
        }
    }

    def delete(Integer id) {
        def response = counterService.get(id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "counter", action: "index")
        }else{
            response = counterService.delete(response)
            if (!response){
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.delete"), false)
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "deleted"))
            }
            redirect(controller: "counter", action: "index")
        }
    }




}
