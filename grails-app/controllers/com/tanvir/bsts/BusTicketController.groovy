package com.tanvir.bsts

import grails.converters.JSON
import grails.databinding.SimpleDataBinder

import java.text.DateFormat
import java.text.SimpleDateFormat

class BusTicketController {

    BusTicketService busTicketService

    def index() {
        def response = busTicketService.list(params)
        Date date = Calendar.getInstance().getTime()
        DateFormat dateFormat = new SimpleDateFormat("MMM dd, YYYY")
        String currentDate =  dateFormat.format(date)
        session.activeTab = "DAILY TRIP"
        [currentDate: currentDate, busTickets: response.list, total:response.count]
    }

    def details() {
        def response = busTicketService.getAdvancedTicket(params.id)
        def purchaseTickets = busTicketService.getPurchaseTicketsAdvance(response, params.date)
        def femaleSoldSeats = busTicketService.getFemaleSoldSeatsAdvance(response, params.date)
        def bookedSeats = busTicketService.getBookedSeatsAdvance(response, params.date)
        def routeCounters = busTicketService.getRouteCountersAdvance(response)
        def routeCountersFrom = busTicketService.getRouteCountersFromAdvance(response)
        def routeCountersTo = busTicketService.getRouteCountersToAdvance(response)
        if (!response){
            redirect(controller: "busTicket", action: "index")
        }else{
            [
                    date: params.date, bookedSeats :bookedSeats, busTicket: response,
                    routeCountersFrom: routeCountersFrom, routeCountersTo: routeCountersTo,
                    purchaseTickets: purchaseTickets, femaleSoldSeats: femaleSoldSeats, routeCounters: routeCounters

            ]
        }
    }

    def fareByFromToStoppage(){
        def seatFare = busTicketService.fareByFromToStoppage(params)
        render([seatFare: seatFare] as JSON)
    }

    def bookedSeatDataList() {
        BusTicketTemplate busTicket = busTicketService.get(params.id)
        def response = busTicketService.getBookedSeatsData(busTicket, params.date)
        render([bookedSeatDataList: response] as JSON)
    }

    def create() {
        [busTicket: flash.redirectParams]
    }

    def save() {
        def response = busTicketService.save(params, request)
        if (response.isSuccess) {
            flash.message = AppUtil.infoMessage(g.message(code: "saved"))
            redirect(controller: "busTicket", action: "index")
        } else {
            flash.redirectParams = response.model
            flash.message = AppUtil.infoMessage(g.message(code: "unable.to.save"), false)
            redirect(controller: "busTicket", action: "create")
        }
    }

    def generateTickets() {
        def response = busTicketService.generateTickets(params, request)
        if (response.isSuccess) {
            flash.message = AppUtil.infoMessage("Ticket Generate Successful")
            redirect(controller: "busTicket", action: "index")
        } else {
            flash.redirectParams = response.model
            flash.message = AppUtil.infoMessage(g.message(code: "unable.to.generate"), false)
            redirect(controller: "busTicket", action: "index")
        }
    }

    def saveBookingTicket() {
        def response = busTicketService.saveBookingTicket(params, request)
        if (response.isSuccess) {
            flash.message = AppUtil.infoMessage("Successfully Booked")
            redirect(controller: "busTicket", action: "details", id: params.busTicketId)
        } else {
            flash.redirectParams = response.model
            flash.message = AppUtil.infoMessage(g.message(code: "unable.to.book"), false)
            redirect(controller: "busTicket", action: "details", id: params.busTicketId)
        }
    }

    def edit(Integer id) {
        if (flash.redirectParams) {
            [busTicket: flash.redirectParams]
        } else {
            def response = busTicketService.get(id)
            if (!response) {
                flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
                redirect(controller: "busTicket", action: "index")
            } else {
                [busTicket: response]
            }
        }
    }

    def update() {
        def response = busTicketService.get(params.id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "busTicket", action: "index")
        }else{
            response = busTicketService.update(response, params, request)
            if (!response.isSuccess){
                flash.redirectParams = response.model
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.update"), false)
                redirect(controller: "busTicket", action: "edit")
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "updated"))
                redirect(controller: "busTicket", action: "index")
            }
        }
    }

    def delete(Integer id) {
        def response = busTicketService.get(id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "busTicket", action: "index")
        }else{
            response = busTicketService.delete(response)
            if (!response){
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.delete"), false)
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "deleted"))
            }
            redirect(controller: "busTicket", action: "index")
        }
    }
}
