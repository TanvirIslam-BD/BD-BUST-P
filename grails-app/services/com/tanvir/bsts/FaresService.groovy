package com.tanvir.bsts

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

import javax.servlet.http.HttpServletRequest

@Transactional
class FaresService {

    def get(Serializable id) {
        return Fares.get(id)
    }

    def update(Fares fares, GrailsParameterMap params, HttpServletRequest request) {
        fares.properties = params
        def response = AppUtil.saveResponse(false, fares)
        if (fares.validate()) {
            fares.save()
            if (!fares.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }

    def save(GrailsParameterMap params, HttpServletRequest request) {
        Fares fares = new Fares(params)
        def response = AppUtil.saveResponse(false, fares)
        if (fares.validate()) {
            fares.save()
            if (!fares.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }

    def list(GrailsParameterMap params) {
        params.max = params.max ?: GlobalConfig.itemsPerPage()
        List<Fares> faresList = Fares.createCriteria().list(params) {
            if (params?.colName && params?.colValue) {
                like(params.colName, "%" + params.colValue + "%")
            }
            if (!params.sort) {
                order("id", "desc")
            }
        }
        return [list: faresList, count: faresList.totalCount]
    }


    def delete(Fares fares) {
        try {
            fares.delete()
        } catch (Exception e) {
            println(e.getMessage())
            return false
        }
        return true
    }


}
