package com.tanvir.bsts

class SeatMapController {

    SeatMapService seatMapService


    def index() {
        def response = seatMapService.list(params)
        [seatMapList: response.list, total:response.count]
    }

    def create() {
        [seatMap: flash.redirectParams]
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
