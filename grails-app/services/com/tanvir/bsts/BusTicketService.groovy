package com.tanvir.bsts

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

import javax.servlet.http.HttpServletRequest

@Transactional
class BusTicketService {

    def get(Serializable id) {
        return BusTicket.get(id)
    }

    def update(BusTicket busTicket, GrailsParameterMap params, HttpServletRequest request) {
        busTicket.properties = params
        def response = AppUtil.saveResponse(false, busTicket)
        if (busTicket.validate()) {
            busTicket.save()
            if (!busTicket.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }

    def save(GrailsParameterMap params, HttpServletRequest request) {
        BusTicket busTicket = new BusTicket(params)
        def response = AppUtil.saveResponse(false, busTicket)
        if (busTicket.validate()) {
            busTicket.save()
            if (!busTicket.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }

    def list(GrailsParameterMap params) {
        params.max = params.max ?: GlobalConfig.itemsPerPage()
        List<BusTicket> busTicketList = BusTicket.createCriteria().list(params) {
            if (params?.colName && params?.colValue) {
                like(params.colName, "%" + params.colValue + "%")
            }
            if (!params.sort) {
                order("id", "desc")
            }
        }
        return [list: busTicketList, count: busTicketList.totalCount]
    }


    def delete(BusTicket busTicket) {
        try {
            busTicket.delete()
        } catch (Exception e) {
            println(e.getMessage())
            return false
        }
        return true
    }


}
