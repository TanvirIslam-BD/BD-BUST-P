package com.tanvir.bsts

import grails.converters.JSON

class MemberController {

    MemberService memberService

    def index() {
        def response = memberService.list(params)
        session.activeTab = "Members"
        [memberList: response.list, total:response.count]
    }

    def details(Integer id) {
        def response = memberService.getById(id)
        session.activeTab = "Profile"
        if (!response){
            redirect(controller: "member", action: "index")
        }else{
            [member: response]
        }
    }

    def create() {
        [member: flash.redirectParams]
    }

    def save() {
        def response = memberService.save(params)
        if (!response.isSuccess) {
            flash.redirectParams = response.model
            flash.message = AppUtil.infoMessage(g.message(code: "unable.to.save"), false)
            redirect(controller: "member", action: "create")
        }else{
            flash.message = AppUtil.infoMessage(g.message(code: "saved"))
            redirect(controller: "member", action: "index")
        }
    }

    def updatePassword() {
        def response = memberService.getById(params.id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "member", action: "index")
        }

        else{
             response = memberService.updatePassword(response, params)
            if (!response.isSuccess){
                flash.redirectParams = response.model
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.update"), false)
                redirect(controller: "member", action: "edit")
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "updated"))
                redirect(controller: "member", action: "index")
            }
        }
    }

    def edit(Integer id) {
        if (flash.redirectParams) {
            [member: flash.redirectParams]
        } else {
            def response = memberService.getById(id)
            if (!response) {
                flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
                redirect(controller: "member", action: "index")
            } else {
                [member: response]
            }
        }
    }

    def update() {
        Member member = memberService.getById(params.id)
        if (!member){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "member", action: "index")
        }else{
            def response = memberService.update(member, params)
            if (!response.isSuccess){
                flash.redirectParams = response.model
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.update"), false)
                redirect(controller: "member", action: "edit")
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "updated"))
                redirect(controller: "member", action: "index")
            }
        }
    }

    def delete(Integer id) {
        def response = memberService.getById(id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "member", action: "index")
        }else{
            response = memberService.delete(response)
            if (!response){
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.delete"), false)
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "deleted"))
            }
            redirect(controller: "member", action: "index")
        }
    }

    def userPermissions(){
        def permissions = memberService.userPermissions(params)
        Member member = memberService.getById(params.userId)
        String userName = member.firstName + " " +member.lastName
        [permissions: permissions, userId: params.userId, userName: userName]
    }

    def userAccess(){
        def permissions = memberService.userPermissions(params)
        [permissions: permissions, userId: params.userId]
    }

    def saveUserPermission(){
        def result = memberService.saveUserPermission(params)
        render([success: result.isSuccess, message: "User Permission Updated"] as JSON)
    }


}
