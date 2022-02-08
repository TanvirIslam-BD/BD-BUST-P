package com.tanvir.bsts

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

import javax.servlet.http.HttpServletRequest

@Transactional
class SeatMapService {

    AuthenticationService authenticationService

    def serviceMethod() {

    }

    @Transactional
    def save(GrailsParameterMap params, HttpServletRequest request) {
        SeatMap seatMap = new SeatMap(params)
        def response = AppUtil.saveResponse(false, seatMap)
        if (seatMap.validate()) {
            seatMap.save()
            if (!seatMap.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }

    def list(GrailsParameterMap params) {
        params.max = params.max ?: GlobalConfig.itemsPerPage()
        List<SeatMap> seatMapList = SeatMap.createCriteria().list(params) {
            if (params?.colName && params?.colValue) {
                like(params.colName, "%" + params.colValue + "%")
            }
            if (!params.sort) {
                order("id", "desc")
            }
        }
        return [list: seatMapList, count: seatMapList.totalCount]
    }

    @Transactional
    def delete(SeatMap seatMap) {
        try {
            seatMap.delete()
        } catch (Exception e) {
            println(e.getMessage())
            return false
        }
        return true
    }



}
