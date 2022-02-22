package com.tanvir.bsts

import grails.gorm.multitenancy.CurrentTenant
import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

import javax.servlet.http.HttpServletRequest

@CurrentTenant
@Transactional
class CounterService {

    def get(Serializable id) {
        return Counter.get(id)
    }

    def update(Counter counter, GrailsParameterMap params, HttpServletRequest request) {
        counter.properties = params
        def response = AppUtil.saveResponse(false, counter)
        if (counter.validate()) {
            counter.save()
            if (!counter.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }

    def save(GrailsParameterMap params, HttpServletRequest request) {
        Counter counter = new Counter(params)
        def response = AppUtil.saveResponse(false, counter)
        if (counter.validate()) {
            counter.save()
            if (!counter.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }

    def list(GrailsParameterMap params) {
        params.max = params.max ?: GlobalConfig.itemsPerPage()
        List<Counter> counterList = Counter.createCriteria().list(params) {
            if (params?.colName && params?.colValue) {
                like(params.colName, "%" + params.colValue + "%")
            }
            if (!params.sort) {
                order("id", "desc")
            }
        }
        return [list: counterList, count: counterList.totalCount]
    }


    def delete(Counter counter) {
        try {
            counter.delete()
        } catch (Exception e) {
            println(e.getMessage())
            return false
        }
        return true
    }



}
