package com.tanvir.bsts

import grails.converters.JSON
import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

import java.text.SimpleDateFormat

@Transactional
class HoldTicketService {


    AuthenticationService authenticationService

    def save(def params){
        if(params.isSelected.toBoolean()){
            HoldTicket holdTicket = HoldTicket.findByTripIdAndRouteIdAndDateAndSeatNo(params.tripId, params.routeId, params.date, params.seatNo)
            if(holdTicket){
                holdTicket.delete()
                return !holdTicket.hasErrors()
            }
           return true
        }else {
            HoldTicket holdTicket = new HoldTicket()
            holdTicket.tripId = params.tripId
            holdTicket.routeId = params.routeId
            holdTicket.date = params.date
            holdTicket.seatNo = params.seatNo
            holdTicket.displayName = params.displayName
            holdTicket.userId = authenticationService.getMember().id
            holdTicket.save()
            return !holdTicket.hasErrors()
        }
    }

    def allHoldTickets(def params){
        def data = params
        return HoldTicket.findAllByTripIdAndRouteIdAndDate(data.tripId, data.routeId, data.date)
    }

    def list(GrailsParameterMap params) {
        params.max = params.max ?: GlobalConfig.itemsPerPage()
        List<HoldTicket> list = HoldTicket.createCriteria().list(params) {
            if (params?.colName && params?.colValue) {
                like(params.colName, "%" + params.colValue + "%")
            }
            if (!params.sort) {
                order("id", "desc")
            }
        }


        def holdTicketDataList = []

        list.each {holdTicket ->
            def holdTicketData = [:]
            def tripId = holdTicket.tripId
            def user = Member.get(holdTicket.userId)
            BusTicketTemplate busTicketTemplate = BusTicketTemplate.get(tripId)
            holdTicketData.id = holdTicket.id
            holdTicketData.seatNo = holdTicket.displayName
            holdTicketData.tripNo = busTicketTemplate.tripNo
            if(user){
                holdTicketData.fullName = user?.firstName + " " + user?.lastName
                holdTicketData.phone = user?.mobile
                holdTicketData.counter = user?.counter?.name
            }
            if(holdTicket?.dateCreated){
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM, yyyy hh:mm aa")
                String time = dateFormat.format(holdTicket.dateCreated).toString()
                holdTicketData.time = time
            }
            holdTicketDataList.add(holdTicketData)
        }

        return [list: holdTicketDataList, count: list.totalCount]
    }

    def get(Serializable id) {
        return HoldTicket.get(id)
    }

    def delete(HoldTicket holdTicket) {
        try {
            holdTicket.delete()
        } catch (Exception e) {
            println(e.getMessage())
            return false
        }
        return true
    }



}
