package com.tanvir.bsts

class SeatMapController {

    SeatMapService seatMapService


    def index() {
        def permissionKey = "seatMapViewPermission"
        boolean hasPermission = false
        hasPermission = memberService.userPermissionCheck(permissionKey)
        if(hasPermission){
            def response = seatMapService.list(params)
            session.activeTab = "Seat Plans"
            [seatMapList: response.list, total:response.count]
        }else {
            flash.message = AppUtil.infoMessage("You are not Authorized for this Action.", false)
            redirect(uri: request.getHeader('referer'))
        }
    }

    def create() {
        [seatMap: flash.redirectParams]
    }


    def edit(Integer id) {
        if (flash.redirectParams) {
            [seatMap: flash.redirectParams]
        } else {
            def response = seatMapService.get(id)
            if (!response) {
                flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
                redirect(controller: "seatMap", action: "index")
            } else {
                [seatMap: response]
            }
        }
    }

    def details(Integer id) {
        def response = seatMapService.get(id)
        if (!response){
            redirect(controller: "seatMap", action: "index")
        }else{
            [seatMap: response]
        }
    }

    def update() {
        def response = seatMapService.get(params.id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "seatMap", action: "index")
        }else{
            response = seatMapService.update(response, params, request)
            if (!response.isSuccess){
                flash.redirectParams = response.model
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.update"), false)
                redirect(controller: "seatMap", action: "edit")
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "updated"))
                redirect(controller: "seatMap", action: "index")
            }
        }
    }

    def save(){
        def response = seatMapService.save(params, request)
        if (response.isSuccess) {
            flash.message = AppUtil.infoMessage(g.message(code: "saved"))
            redirect(controller: "seatMap", action: "index")
        } else {
            flash.redirectParams = response.model
            flash.message = AppUtil.infoMessage(g.message(code: "unable.to.save"), false)
            redirect(controller: "seatMap", action: "create")
        }
    }

    def delete(Integer id) {
        def response = seatMapService.get(id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "coach", action: "index")
        }else{
            response = seatMapService.delete(response)
            if (!response){
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.delete"), false)
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "deleted"))
            }
            redirect(controller: "coach", action: "index")
        }
    }


}
