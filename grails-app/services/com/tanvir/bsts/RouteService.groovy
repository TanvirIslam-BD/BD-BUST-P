package com.tanvir.bsts

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

import javax.servlet.http.HttpServletRequest

@Transactional
class RouteService {

    def get(Serializable id) {
        return Route.get(id)
    }

    def update(Route route, GrailsParameterMap params, HttpServletRequest request) {
        route.properties = params
        def response = AppUtil.saveResponse(false, route)
        if (route.validate()) {
            route.save()
            if (!route.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }

    def save(GrailsParameterMap params, HttpServletRequest request) {
        Route route = new Route(params)
        def response = AppUtil.saveResponse(false, route)
        if (route.validate()) {
            route.save()
            if (!route.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }

    def list(GrailsParameterMap params) {
        params.max = params.max ?: GlobalConfig.itemsPerPage()
        List<Route> routeList = Route.createCriteria().list(params) {
            if (params?.colName && params?.colValue) {
                like(params.colName, "%" + params.colValue + "%")
            }
            if (!params.sort) {
                order("id", "desc")
            }
        }
        return [list: routeList, count: routeList.totalCount]
    }


    def delete(Route fares) {
        try {
            fares.delete()
        } catch (Exception e) {
            println(e.getMessage())
            return false
        }
        return true
    }


}
