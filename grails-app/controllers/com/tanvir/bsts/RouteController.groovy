package com.tanvir.bsts

class RouteController {

    RouteService routeService

    def index() {
        def permissionKey = "routesViewPermission"
        boolean hasPermission = false
        hasPermission = memberService.userPermissionCheck(permissionKey)
        if(hasPermission){
            def response = routeService.list(params)
            session.activeTab = "ROUTES"
            [routeList: response.list, total:response.count]
        }else {
            flash.message = AppUtil.infoMessage("You are not Authorized for this Action.", false)
            redirect(uri: request.getHeader('referer'))
        }
    }

    def details(Integer id) {
        def response = routeService.get(id)
        if (!response){
            redirect(controller: "route", action: "index")
        }else{
            [coach: response]
        }
    }

    def create() {
        [route: flash.redirectParams]
    }

    def save() {
        def response = routeService.save(params, request)
        if (response.isSuccess) {
            flash.message = AppUtil.infoMessage(g.message(code: "saved"))
            redirect(controller: "route", action: "index")
        } else {
            flash.redirectParams = response.model
            flash.message = AppUtil.infoMessage(g.message(code: "unable.to.save"), false)
            redirect(controller: "route", action: "create")
        }
    }

    def edit(Integer id) {
        if (flash.redirectParams) {
            [route: flash.redirectParams]
        } else {
            def response = routeService.get(id)
            if (!response) {
                flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
                redirect(controller: "route", action: "index")
            } else {
                [route: response]
            }
        }
    }

    def update() {
        def response = routeService.get(params.id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "route", action: "index")
        }else{
            response = routeService.update(response, params, request)
            if (!response.isSuccess){
                flash.redirectParams = response.model
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.update"), false)
                redirect(controller: "route", action: "edit")
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "updated"))
                redirect(controller: "route", action: "index")
            }
        }
    }

    def delete(Integer id) {
        def response = routeService.get(id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "route", action: "index")
        }else{
            response = routeService.delete(response)
            if (!response){
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.delete"), false)
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "deleted"))
            }
            redirect(controller: "route", action: "index")
        }
    }


}
