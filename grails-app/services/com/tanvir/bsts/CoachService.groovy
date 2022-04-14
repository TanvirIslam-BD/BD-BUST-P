package com.tanvir.bsts

import grails.web.servlet.mvc.GrailsParameterMap
import javax.servlet.http.HttpServletRequest
import grails.gorm.transactions.Transactional


class CoachService {

    AuthenticationService authenticationService

    @Transactional
    def save(GrailsParameterMap params, HttpServletRequest request) {
        Coach coach = new Coach(params)
        coach.member = authenticationService.getMember()
        coach.name = coach.coachNumber
        def response = AppUtil.saveResponse(false, coach)
        if (coach.validate()) {
            coach.save()
            if (!coach.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }

    @Transactional
    def update(Coach coach, GrailsParameterMap params, HttpServletRequest request) {
        coach.properties = params
        def response = AppUtil.saveResponse(false, coach)
        if (coach.validate()) {
            coach.save()
            if (!coach.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }

    def get(Serializable id) {
        return Coach.get(id)
    }


    def list(GrailsParameterMap params) {
        params.max = params.max ?: GlobalConfig.itemsPerPage()
        List<Coach> coachList = Coach.createCriteria().list(params) {
            if (params?.colName && params?.colValue) {
                like(params.colName, "%" + params.colValue + "%")
            }
            if (!params.sort) {
                order("id", "desc")
            }
        }
        return [list: coachList, count: coachList.totalCount]
    }

    @Transactional
    def delete(Coach coach) {
        try {
            coach.delete()
        } catch (Exception e) {
            println(e.getMessage())
            return false
        }
        return true
    }

}
