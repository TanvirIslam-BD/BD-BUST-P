package com.tanvir.bsts

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
        out << g.link(controller: "authentication", action: "logout", class: "dropdown-item"){g.message(code:"Counter")}
        out << g.link(controller: "authentication", action: "logout", class: "dropdown-item"){g.message(code:"Counter Man")}
        out << g.link(controller: "authentication", action: "logout", class: "dropdown-item"){g.message(code:"Fares")}
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


    def appBaseURL = { attrs, body ->
        out << AppUtil.baseURL();
    }

}
