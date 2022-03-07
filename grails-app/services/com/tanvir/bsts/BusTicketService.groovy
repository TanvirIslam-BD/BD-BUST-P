package com.tanvir.bsts

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

import javax.servlet.http.HttpServletRequest
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.beans.factory.annotation.Qualifier
@Transactional
class BusTicketService {

    AuthenticationService authenticationService

    @Autowired
    @Qualifier("com.tanvir.bsts.UIHelperTagLib")
    com.tanvir.bsts.UIHelperTagLib uiHelperTagLib

    def get(Serializable id) {
        return BusTicket.get(id)
    }

    def getAdvancedTicket(Serializable id) {
        return BusTicketTemplate.get(id)
    }

    def getFemaleBookedSeats(BusTicket busTicket) {
        def femaleBookedSeats = []
        if(busTicket){
            femaleBookedSeats = busTicket.purchaseTickets.collect{
                if(it.sex == "female"){
                    return it
                }
            }
        }
        return femaleBookedSeats
    }

    def getFemaleSoldSeatsAdvance(BusTicketTemplate busTicket, String date) {
        def femaleBookedSeats = []
        if(busTicket){
            femaleBookedSeats = PurchaseTicket.findAllByBusTicketTemplateIdAndScheduledDate(busTicket.id, date).collect{
                if(it.sex == "female"){
                    return it
                }
            }
        }
        return femaleBookedSeats
    }


    def getBookedSeatsAdvance(BusTicketTemplate busTicket, String date) {
        def femaleBookedSeats = []
        if(busTicket){
            femaleBookedSeats = PurchaseTicket.findAllByBusTicketTemplateIdAndScheduledDate(busTicket.id, date).collect{
                if(it.paymentType == "book"){
                    return it
                }
            }
        }
        return femaleBookedSeats
    }


    def getPurchaseTicketsAdvance(BusTicketTemplate busTicket, String date) {
        def bookedSeats = []
        if(busTicket){
            bookedSeats = PurchaseTicket.findAllByBusTicketTemplateIdAndScheduledDate(busTicket.id, date)
        }
        return bookedSeats
    }


    def getBookedSeatsAdvance(BusTicketTemplate busTicket) {
        def bookedSeats = []
        if(busTicket){
            bookedSeats = PurchaseTicket.findAllByBusTicketTemplateId(busTicket.id)
        }
        return bookedSeats
    }

    def getBookedSeatsData(BusTicket busTicket) {
        def bookedSeatsData = [:]
        if(busTicket){
             busTicket.purchaseTickets.each{ticket ->
               def seatList = ticket.seatBooked.replaceAll("\\[","").replaceAll("\\]","").replaceAll(" ","").split(",")
                 seatList.each {seat ->
                     bookedSeatsData[seat] = [
                             seatNo: seat,
                             passengerName: ticket.name,
                             mobile: ticket.mobile,
                             pickFrom: ticket.fromCounter.name,
                             saleBy: ticket?.saleBy?.firstName +" "+ ticket?.saleBy?.lastName
                     ]
                 }
            }
        }
        return bookedSeatsData
    }

    def getRouteCounters(BusTicket busTicket) {
        def routeCounters = []
        if(busTicket){
            routeCounters = busTicket.route.counters
        }
        return routeCounters
    }


    def getRouteCountersAdvance(BusTicketTemplate busTicket) {
        def routeCounters = []
        if(busTicket){
            routeCounters = busTicket.route.counters
        }
        return routeCounters
    }

    def getScheduleItemList(def routeId, def date) {

        def scheduleItemList = []


        Route route = Route.get(routeId)
        def scheduleTicketList = BusTicketTemplate.findAllByRoute(route)

        scheduleTicketList.each {
            def scheduleItemTemplate = [
                    Disabled: false,
                    Group: null,
                    Selected: false,
                    Text: "2:20 AM (TAN)",
                    ThirdValue: "TAN",
                    Value: "1"
            ]
            scheduleItemTemplate.Text = uiHelperTagLib.parseTimeInFormat(time: it.boardingTime)
            scheduleItemTemplate.Value = it.id
            scheduleItemTemplate.ThirdValue = date
            scheduleItemList.add(scheduleItemTemplate)
        }

        return scheduleItemList
    }

    def fareByFromToStoppage(def params) {
        def amount = 0.0
        Route route = Route.get(params.routeId)
        Counter from = Counter.get(params.from)
        Counter to = Counter.get(params.to)
        def seatFares =  Fares.findAllByRouteAndFromStoppageAndToStoppage(route, from, to)
        if(seatFares){
            amount = seatFares[0].amount
        }
        return amount
    }

    def getRouteCountersFrom(BusTicket busTicket) {
        def routeCounters = []
        if(busTicket){
            routeCounters = busTicket.route.counters.collect{
                if(it.city == busTicket.route.districtFrom){
                    return it
                }
            }
        }
        return routeCounters
    }


    def getRouteCountersFromAdvance(BusTicketTemplate busTicket) {
        def routeCounters = []
        if(busTicket){
            routeCounters = busTicket.route.counters.collect{
                if(it.city == busTicket.route.districtFrom){
                    return it
                }
            }
        }
        return routeCounters
    }


    def getRouteCountersTo(BusTicket busTicket) {
        def routeCounters = []
        if(busTicket){
            routeCounters = busTicket.route.counters.collect{
                if(it.city == busTicket.route.districtTo){
                    return it
                }
            }
        }
        return routeCounters
    }

  def getRouteCountersToAdvance(BusTicketTemplate busTicket) {
        def routeCounters = []
        if(busTicket){
            routeCounters = busTicket.route.counters.collect{
                if(it.city == busTicket.route.districtTo){
                    return it
                }
            }
        }
        return routeCounters
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
                oldBusTicket.route = null
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
                    busTicket.route = template.route
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
        params.seatBookedForDisplay = params.seatBookedForDisplay.toString()
        BusTicket busTicket = BusTicket.get(params.busTicketId)
        PurchaseTicket purchaseTicket = new PurchaseTicket(params)
        purchaseTicket.totalBookedSeat = totalBookedSeat
        purchaseTicket.saleBy = authenticationService.getMember()
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


    def saveBookingTicketAdvance(GrailsParameterMap params, HttpServletRequest request) {
        def totalBookedSeat = params["seatBooked[]"].size()
        params.seatBooked = params["seatBooked[]"].toString()
        params.seatBookedForDisplay = params."seatBookedForDisplay[]".toString()
        BusTicketTemplate busTicket = BusTicketTemplate.get(params.busTicketId)
        PurchaseTicket purchaseTicket = new PurchaseTicket(params)
        purchaseTicket.totalBookedSeat = totalBookedSeat
        purchaseTicket.saleBy = authenticationService.getMember()
        purchaseTicket.busTicketTemplateId = busTicket.id
        def response = AppUtil.saveResponse(false, purchaseTicket)
        if (purchaseTicket.validate()) {
            purchaseTicket.save()
            if (!purchaseTicket.hasErrors()){
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
