package com.tanvir.bsts

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

import javax.servlet.http.HttpServletRequest
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.beans.factory.annotation.Qualifier

import java.text.DateFormat
import java.text.SimpleDateFormat

@Transactional
class BusTicketService {

    AuthenticationService authenticationService

    @Autowired
    @Qualifier("com.tanvir.bsts.UIHelperTagLib")
    com.tanvir.bsts.UIHelperTagLib uiHelperTagLib

    def get(Serializable id) {
        return BusTicketTemplate.get(id)
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

    def getFemaleBookedSeats(BusTicketTemplate busTicket, String date) {
        def femaleBookedSeats = []
        if(busTicket){
            femaleBookedSeats = PurchaseTicket.findAllByBusTicketTemplateIdAndScheduledDate(busTicket.id, date).collect{
                if(it.paymentType == "book" && it.sex == "female"){
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

    def getBookedSeatsData(BusTicketTemplate busTicket, def date) {
        def bookedSeatsData = [:]
        if(busTicket){
            PurchaseTicket.findAllByBusTicketTemplateIdAndScheduledDate(busTicket.id, date).each{ticket ->
                if(ticket.seatBooked){
                    def seatList = ticket.seatBooked.replaceAll("\\[","").replaceAll("\\]","").replaceAll(" ","").split(",")
                    seatList.each {seat ->
                        bookedSeatsData[seat] = [
                                seatNo: seat,
                                ticketNo: ticket.id,
                                passengerName: ticket.name,
                                gender: ticket.sex,
                                mobile: ticket.mobile,
                                pickFrom: ticket.fromCounter.name,
                                saleBy: ticket?.saleBy?.firstName +" "+ ticket?.saleBy?.lastName
                        ]
                    }
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

            boolean isActive = true
            Trip existTrip = Trip.findByTicketScheduleIdAndScheduleDate(it.id, date)
            if(existTrip){
                isActive = existTrip.isActive
            }

            if(isActive){
                def scheduleItemTemplate = [
                        Disabled: false,
                        Group: null,
                        Selected: false,
                        Text: "2:20 AM (TAN)",
                        ThirdValue: "TAN",
                        Value: "1"
                ]
                scheduleItemTemplate.Text = uiHelperTagLib.parseTimeInFormat(time: it.boardingTime) + " (${it.tripNo})"
                scheduleItemTemplate.Value = it.id
                scheduleItemTemplate.ThirdValue = date
                scheduleItemList.add(scheduleItemTemplate)
            }

        }

        return scheduleItemList
    }

    def fareByFromToStoppage(def params) {
        def amount = 0.0
        def commission = 0.0
        Route route = Route.get(params.routeId)
        Counter from = Counter.get(params.from)
        Counter to = Counter.get(params.to)
        def seatFares =  Fares.findAllByRouteAndFromStoppageAndToStoppage(route, from, to)
        if(seatFares){
            amount = seatFares[0].amount
            commission = seatFares[0].commissionAmount
        }else {
            BusTicketTemplate busTicketTemplate = BusTicketTemplate.get(params.scheduleId)
            if(busTicketTemplate && busTicketTemplate.flatFare){
                amount = busTicketTemplate.flatFare
            }
        }
        return [amount: amount, commission: commission]
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
            Member member = authenticationService.getMember()
            boolean isAdmin = false
            def userCounterId = member.counterId
            if (member && member.memberType == GlobalConfig.USER_TYPE.ADMINISTRATOR){
                isAdmin = true
            }
            routeCounters = busTicket.route.counters.collect{
                if(isAdmin){
                    if(it.city == busTicket.route.districtFrom){
                        return it
                    }
                }else {
                    if((it.city == busTicket.route.districtFrom) && (userCounterId == it.id)){
                        return it
                    }
                }

            }
        }
        return routeCounters
    }

    def getRouteCountersFromSchedule(BusTicketTemplate busTicket) {
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


    PurchaseTicket getTicketSeat(def ticketNo) {
        def purchaseTicket = [:]
        if(ticketNo){
            purchaseTicket = PurchaseTicket.get(ticketNo)
        }
        return purchaseTicket
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
        def scheduleStartTimes =  params.startTime
        def scheduleCounter =  params.counter
         scheduleStartTimes.eachWithIndex { time, index ->
          TicketCounterTime ticketCounterTime = new TicketCounterTime()
          ticketCounterTime.startTime = time
          def counterId = Integer.parseInt(scheduleCounter[index])
          ticketCounterTime.counter = Counter.get(counterId)
          ticketCounterTime.save()
          busTicketTemplate.addToTicketCounterTimes(ticketCounterTime)
        }
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

   def checkSeatAvailability(def params){
       def alreadyBookedSeats = []
       def seatBooked = params["seatBooked[]"]
       if(!seatBooked){
           seatBooked = params["seatBooked"]
       }
       String seatBookedString = seatBooked.toString()
       if(seatBookedString){
           def seatList = seatBookedString.replaceAll("\\[","").replaceAll("\\]","").replaceAll(" ","").split(",")
           PurchaseTicket.findAllByBusTicketTemplateIdAndScheduledDate(params.busTicketId, params.scheduledDate).each {bookedTicket->
               String bookedTicketString = bookedTicket.seatBooked.toString()
               def bookedTicketList = bookedTicketString.replaceAll("\\[","").replaceAll("\\]","").replaceAll(" ","").split(",")
               seatList.each{ seat ->
                   bookedTicketList.each { booked->
                       if(booked == seat){
                           alreadyBookedSeats.add(seat)
                       }
                   }
               }
           }
       }

       return !alreadyBookedSeats.size()
    }


    def saveBookingTicketAdvance(GrailsParameterMap params, HttpServletRequest request) {
            def response
            def totalBookedSeat = params["seatBooked[]"]?.size() ?: params["seatBooked"]?.size()
            params.seatBooked = params["seatBooked[]"]?.toString() ?: params["seatBooked"]?.toString()
            params.seatBookedForDisplay = params["seatBookedForDisplay[]"]?.toString() ?: params["seatBookedForDisplay"]?.toString()
            BusTicketTemplate busTicket = BusTicketTemplate.get(params.busTicketId)
            PurchaseTicket purchaseTicket = new PurchaseTicket(params)
            purchaseTicket.totalBookedSeat = totalBookedSeat
            purchaseTicket.discount = params.discount ? params.discount.toDouble() : 0.0
            purchaseTicket.commission = params.commission ? params.commission.toDouble() : 0.0
            purchaseTicket.receivedAmountAfterCommission = params.commission ? (purchaseTicket.receivedFromCustomer - params.commission.toDouble()) : purchaseTicket.receivedFromCustomer
            purchaseTicket.saleBy = authenticationService.getMember()
            purchaseTicket.busTicketTemplateId = busTicket.id
            response = AppUtil.saveResponse(false, purchaseTicket)
            if (purchaseTicket.validate()) {
                purchaseTicket.save()
                if (!purchaseTicket.hasErrors()){
                    response.isSuccess = true
                }
            }

        return response
    }

    def returnBookedTicket(GrailsParameterMap params, HttpServletRequest request) {
        PurchaseTicket purchaseTicket = PurchaseTicket.get(params.returnedTicketId)
        purchaseTicket.isReturned = true
        purchaseTicket.seatBooked = ""
        purchaseTicket.returnedAmount = params.returnedAmount.toDouble()
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
        List<BusTicketTemplate> busTicketList = BusTicketTemplate.createCriteria().list(params) {
            if (params?.colName && params?.colValue) {
                like(params.colName, "%" + params.colValue + "%")
            }
            if (!params.sort) {
                order("id", "desc")
            }
        }
        return [list: busTicketList, count: busTicketList.totalCount]
    }


    def activeList(GrailsParameterMap params) {
        params.max = params.max ?: GlobalConfig.itemsPerPage()
        List<BusTicketTemplate> busTicketList = BusTicketTemplate.createCriteria().list(params) {
            if (params?.colName && params?.colValue) {
                like(params.colName, "%" + params.colValue + "%")
            }
            if (!params.sort) {
                order("id", "desc")
            }
        }
        Date date = Calendar.getInstance().getTime()
        DateFormat dateFormat = new SimpleDateFormat("MMM dd, YYYY")
        String currentDate =  dateFormat.format(date)
        List<BusTicketTemplate> activeList = []
        busTicketList.each {
            boolean isActive = true
            Trip existTrip = Trip.findByTicketScheduleIdAndScheduleDate(it.id, currentDate)
            if(existTrip){
                isActive = existTrip.isActive
            }
            if(isActive){
                activeList.add(it)
            }
        }

        return [list: activeList, count: activeList.size()]
    }

    def tripList(GrailsParameterMap params) {
        params.max = params.max ?: GlobalConfig.itemsPerPage()
        List<BusTicketTemplate> busTicketList = BusTicketTemplate.createCriteria().list(params) {
            if (params?.colName && params?.colValue) {
                like(params.colName, "%" + params.colValue + "%")
            }
            if (!params.sort) {
                order("id", "desc")
            }
        }

        Date date = Calendar.getInstance().getTime()
        DateFormat dateFormat = new SimpleDateFormat("MMM dd, YYYY")
        String currentDate =  dateFormat.format(date)

        def tripList = []

        busTicketList.each {scheduleTicket ->
            def  tripData = [:]
            def tripId = scheduleTicket.id
            tripData.id = tripId
            tripData.boardingTime = scheduleTicket?.boardingTime
            tripData.tripNo = scheduleTicket.tripNo
            tripData.route = scheduleTicket?.route?.name
            tripData.seatClass = scheduleTicket?.coach?.seatClass?.toUpperCase()
            tripData.flatFare = scheduleTicket?.flatFare ?: 0.00

            def seatMap = scheduleTicket?.coach?.seatMap
            def seatColumns = Integer.parseInt(seatMap?.seatColumns?.toString())
            tripData.seatMap = GlobalConfig.SEAT_FORMAT[seatColumns] + ":" + seatMap?.name
            tripData.fromStoppage = scheduleTicket?.route?.fromStoppage?.name
            tripData.toStoppage = scheduleTicket?.route?.toStoppage?.name
            tripData.coachNumber = scheduleTicket?.coach?.coachNumber
            tripData.isActive = true

            Trip oldTrip = Trip.findByTicketScheduleIdAndScheduleDate(tripId, currentDate)
            if(oldTrip){
                tripData.isActive = oldTrip.isActive
            }

            tripList.add(tripData)
        }

        return [currentDate: currentDate, list: tripList, count: busTicketList.totalCount]
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


    def activateTrip(def params) {
        try {
            Integer tripId  =  params.tripId ? Integer.parseInt(params.tripId) : null
            def isActivate = true
            if(tripId && params.date){
                Trip oldTrip = Trip.findByTicketScheduleIdAndScheduleDate(tripId, params.date)
                if(oldTrip){
                    if(oldTrip.isActive){
                        oldTrip.isActive = false
                    }else {
                        oldTrip.isActive = true
                    }
                    oldTrip.save()
                    isActivate = oldTrip.isActive
                    return isActivate
                } else {
                    Trip trip = new Trip()
                    trip.isActive = false
                    trip.ticketScheduleId = params.tripId ? Integer.parseInt(params.tripId) : null
                    trip.scheduleDate = params.date
                    isActivate =   trip.isActive
                    trip.save()
                    return isActivate
                }
            }
            return isActivate
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
