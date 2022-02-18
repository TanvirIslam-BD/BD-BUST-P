package com.tanvir.bsts

import grails.converters.JSON

import java.text.SimpleDateFormat
import java.time.LocalDate
import java.time.LocalTime
import java.time.format.DateTimeFormatter

class UIHelperTagLib {

    static namespace = "UIHelper"

    AuthenticationService authenticationService

    def renderErrorMessage = { attrs, body ->
        def model = attrs.model
        String fieldName = attrs.fieldName
        String errorMessage = attrs.errorMessage? g.message(code: attrs.errorMessage): g.message(code: "invalid.input")
        if (model && model.errors && model.errors.getFieldError(fieldName)){
            out << "<small class='form-text text-danger''><strong>${errorMessage}</strong></small>"
        }
    }

    def memberName = { attrs, body ->
        out << authenticationService.getMemberName()
    }

    def memberDetails = { attrs, body ->
        out << "/member/details?id=${authenticationService.getMember().id}"
    }

    def memberActionMenu = { attrs, body ->
        out << '<li class="nav-item dropdown show">'
        out << g.link(class:"nav-link dropdown-toggle", "data-toggle":"dropdown"){authenticationService.getMemberName()}
        out << '<div class="dropdown-menu">'
        out << g.link(controller: "member", action: "details", id:"${authenticationService.getMember().id}", class: "dropdown-item"){g.message(code:"Profile")}
        out << g.link(controller: "member", action: "index", class: "dropdown-item"){g.message(code:"Member List")}
        out << g.link(controller: "authentication", action: "logout", class: "dropdown-item"){g.message(code:"logout")}
        out << "</div></li>"
    }


    def systemServicesActionMenu = { attrs, body ->
        out << '<li class="nav-item dropdown show">'
        out << g.link(class:"nav-link dropdown-toggle", "data-toggle":"dropdown"){"SYSTEM SERVICE"}
        out << '<div class="dropdown-menu">'
        out << g.link(controller: "counter", action: "index", class: "dropdown-item"){g.message(code:"Counter")}
        out << g.link(controller: "authentication", action: "logout", class: "dropdown-item"){g.message(code:"Counter Man")}
        out << g.link(controller: "fares", action: "index", class: "dropdown-item"){g.message(code:"Fares")}
        out << g.link(controller: "authentication", action: "logout", class: "dropdown-item"){g.message(code:"Driver")}
        out << g.link(controller: "authentication", action: "logout", class: "dropdown-item"){g.message(code:"Supervisor")}
        out << g.link(controller: "authentication", action: "logout", class: "dropdown-item"){g.message(code:"Trip")}
        out << "</div></li>"
    }


    def leftNavigation = { attrs, body ->
        List navigations = [
                [controller: "dashboard", action: "index", name: "dashboard"],
                [controller: "coachGroup", action: "index", name: "coach.group"],
                [controller: "coach", action: "index", name: "coach"],
        ]

        if(authenticationService.isAdministratorMember()){
            navigations.add([controller: "member", action: "index", name: "member"])
        }

        navigations.each { menu ->
            out << '<li class="list-group-item">'
            out << g.link(controller: menu.controller, action: menu.action) { g.message(code: menu.name, args: ['']) }
            out << '</li>'
        }
    }

    def seatPlan = { attrs, body ->
        String name = attrs.name ?: "seatPlan"
        String value = attrs.value ?: ""
        def select = [:]
        select["45AC"] = "45 Seat AC"
        select["51AC"] = "51 Seat AC"
        out << g.select(from: select, name: name, optionKey: "key", optionValue: "value", value: value, class:"form-control")
    }

    def status = { attrs, body ->
        String name = attrs.name ?: "status"
        String value = attrs.value ?: ""
        def select = [:]
        select.ACTIVE = "Active"
        select.INACTIVE = "Inactive"
        out << g.select(from: select, name: name, optionKey: "key", optionValue: "value", value: value, class:"form-control")
    }

    def gender = { attrs, body ->
        String name = attrs.name ?: "sex"
        String value = attrs.value ?: ""
        def select = [:]
        select.male = "Male"
        select.female = "Female"
        out << g.select(from: select, name: name, optionKey: "key", optionValue: "value", value: value, class:"form-control")
    }


    def stoppage = { attrs, body ->
        String name = attrs.name ?: "fromStoppage"
        String value = attrs.value ?: ""
        def select = [:]
        select.dhaka = "Dhaka"
        select.kamalapur = "Kamalapur"
        select.tikatuli = "Tikatuli"
        select.kachpur = "Kachpur"
        select.hajiganj = "Hajiganj"
        out << g.select(from: select, name: name, optionKey: "key", optionValue: "value", value: value, class:"form-control")
    }

    def seatClass = { attrs, body ->
        String name = attrs.name ?: "seatClass"
        String value = attrs.value ?: ""
        def select = [:]
        select.ac = "AC"
        select.nonac = "Non AC"
        out << g.select(from: select, name: name, optionKey: "key", optionValue: "value", value: value, class:"form-control")
    }

    def parseTimeInFormat = { attrs, body ->
        String time = attrs.time ?: ""
        if(time){
            out << LocalTime.parse(time, DateTimeFormatter.ofPattern("HH:mm")).format("hh:mm a")
        }
    }

    def parseDateInFormat = { attrs, body ->
        String date = attrs.date ?: ""
        if(date){
            out << LocalDate.parse(date.split(" ")[0], DateTimeFormatter.ofPattern("yyyy-MM-dd")).toString()
        }
    }

    def getBookedSeatsCount = { attrs, body ->
        def ticketId = attrs.ticketId ?: ""
        if(ticketId){
            BusTicket busTicket = BusTicket.get(ticketId)
            def bookedCount = busTicket.purchaseTickets.sum {it.totalBookedSeat}
            out << bookedCount ?: "0"
        }
    }

    def getAvailableSeatsCount = { attrs, body ->
        def ticketId = attrs.ticketId ?: ""
        if(ticketId){
            BusTicket busTicket = BusTicket.get(ticketId)
            def totalSeat = busTicket.coach.seatCapacity
            def bookedCount = busTicket.purchaseTickets.sum {it.totalBookedSeat}
            if(bookedCount){
                out << totalSeat - bookedCount
            }else {
                out << totalSeat
            }

        }
    }


    def appBaseURL = { attrs, body ->
        out << AppUtil.baseURL();
    }

    def domainSelect = { attrs, body ->
        Class domain = attrs.domain;
        if (!domain) {
            return
        }
        String key = attrs["key"] ?: "id"
        String text = attrs["text"] ?: "name"
        Map prependMap = attrs['prepend'] ?: null
        Map appendMap = attrs['append'] ?: null
        Map customAttrs = attrs['custom-attrs'] ?: null
        def value = attrs.value ?: ''
        def values = attrs.values ?: []
        if (value) {
            values.add(value)
        }

        Closure filter
        List sect = filter ? domain.createCriteria().list(filter) : domain.list()
        out << "<select class='${attrs["class"]}' ${attrs.name ? 'name="' + attrs.name + '"' : ''} ${attrs.id ? 'id="' + attrs.id + '"' : ''}"
        out << "${attrs.validation ? 'validation="' + attrs.validation + '"' : ''} ${attrs.disabled == 'true' ? 'disabled="true"' : ''}"
        out << " ${key != "id" ? 'select-key="' + key + '"' : ''} ${text != "name" ? 'select-text="' + text + '"' : ''} select-values='${values as JSON}'"
        if (customAttrs) {
            customAttrs.each {
                if (it.value) {
                    out << "${it.key}='${it.value}'"
                }
            }
        }
        out << ">"
        if (prependMap) {
            prependMap.each {
                out << "<option class='domain-prepend' value='${it.key}' ${it.key in values ? 'selected' : ''}>${it.value}</option>"
            }
        }

        def printChildren
        printChildren = { it ->
                out << "<option value='${it[key]}' ${it[key] in values ? 'selected' : ''}>"
                out << it[text]
                out << "</option>"
        }

        sect.each {
            printChildren it
        }

        if (appendMap) {
            appendMap.each {
                out << "<option class='domain-append' value='${it.key}'>${it.value}</option>"
            }
        }
        out << "</select>"
    }


}
