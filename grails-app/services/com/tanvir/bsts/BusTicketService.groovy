package com.tanvir.bsts

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

import javax.servlet.http.HttpServletRequest

@Transactional
class BusTicketService {

    def get(Serializable id) {
        return BusTicket.get(id)
    }

    def getTicketTemplate(Serializable id) {
        return BusTicketTemplate.get(id)
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

  def updateTicketTemplate(BusTicketTemplate busTicketTemplate, GrailsParameterMap params, HttpServletRequest request) {
      busTicketTemplate.properties = params
        def response = AppUtil.saveResponse(false, busTicketTemplate)
        if (busTicketTemplate.validate()) {
            busTicketTemplate.save()
            if (!busTicketTemplate.hasErrors()){
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

    def generateTickets(GrailsParameterMap params, HttpServletRequest request) {
        List<BusTicketTemplate> busTicketTemplateList = BusTicketTemplate.list()
        def response = [isSuccess: true]
        List<BusTicket> oldBusTicketList = BusTicket.list()
        try{
            oldBusTicketList.each {oldBusTicket ->
                oldBusTicket.purchaseTickets = null
                oldBusTicket.coach = null
                oldBusTicket.fares = null
                oldBusTicket.delete()
            }
        }catch(Exception exception){
            response.isSuccess = false
        }
        if(response.isSuccess){
            try{
                busTicketTemplateList.each {template ->
                    BusTicket busTicket = new BusTicket()
                    busTicket.boardingDate = new Date()
                    busTicket.boardingTime = template.boardingTime
                    busTicket.fares = template.fares
                    busTicket.coach = template.coach
                    busTicket.coach = template.coach
                    busTicket.save()
                }
            }catch(Exception exception){
                response.isSuccess = false
            }
        }
        return response
    }


    def saveTicketTemplate(GrailsParameterMap params, HttpServletRequest request) {
        BusTicketTemplate busTicketTemplate = new BusTicketTemplate(params)
        def response = AppUtil.saveResponse(false, busTicketTemplate)
        if (busTicketTemplate.validate()) {
            busTicketTemplate.save()
            if (!busTicketTemplate.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }

   def saveBookingTicket(GrailsParameterMap params, HttpServletRequest request) {
        def totalBookedSeat = params.seatBooked.size()
        params.seatBooked = params.seatBooked.toString()
        BusTicket busTicket = BusTicket.get(params.busTicketId)
        PurchaseTicket purchaseTicket = new PurchaseTicket(params)
       purchaseTicket.totalBookedSeat = totalBookedSeat
        def response = AppUtil.saveResponse(false, purchaseTicket)
        if (purchaseTicket.validate()) {
            purchaseTicket.save()
            if (!purchaseTicket.hasErrors()){
                busTicket.purchaseTickets.add(purchaseTicket)
                busTicket.merge()
                response.isSuccess = true
            }
        }
        return response
    }

    def listOfTicketTemplates(GrailsParameterMap params) {
        params.max = params.max ?: GlobalConfig.itemsPerPage()
        List<BusTicketTemplate> busTicketTemplateList = BusTicketTemplate.createCriteria().list(params) {
            if (params?.colName && params?.colValue) {
                like(params.colName, "%" + params.colValue + "%")
            }
            if (!params.sort) {
                order("id", "desc")
            }
        }
        return [list: busTicketTemplateList, count: busTicketTemplateList.totalCount]
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

    def deleteTicketTemplate(BusTicketTemplate busTicketTemplate) {
        try {
            busTicketTemplate.delete()
        } catch (Exception e) {
            println(e.getMessage())
            return false
        }
        return true
    }


}
