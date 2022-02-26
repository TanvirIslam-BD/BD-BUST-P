package com.tanvir.bsts

import grails.web.servlet.mvc.GrailsParameterMap

import javax.transaction.Transactional


class MemberService {

    @Transactional
    def save(GrailsParameterMap params) {
        Member member = new Member(params)
        def response = AppUtil.saveResponse(false, member)
        if (member.validate()) {
            member.save()
            if (!member.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }

    @Transactional
    def update(Member member, GrailsParameterMap params) {
        member.properties = params
        def response = AppUtil.saveResponse(false, member)
        if (member.validate()) {
            member.save()
            if (!member.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }


    @Transactional
    def updatePassword(Member member, GrailsParameterMap params) {
        member.properties = params
        def response = AppUtil.saveResponse(false, member)
        if (member.validate()) {
            member.save()
            if (!member.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }


    def getById(Serializable id) {
        return Member.get(id)
    }


    def list(GrailsParameterMap params) {
        params.max = params.max ?: GlobalConfig.itemsPerPage()
        List<Member> memberList = Member.createCriteria().list(params) {
            if (params?.colName && params?.colValue) {
                if(params.colName == "name"){
                    or {
                        like('firstName', "%" + params.colValue + "%")
                        like('lastName', "%" + params.colValue + "%")
                    }

                }else {
                    like(params.colName, "%" + params.colValue + "%")
                }

            }
            if (!params.sort) {
                order("id", "desc")
            }
        }
        return [list: memberList, count: memberList.totalCount]
    }

    @Transactional
    def delete(Member member) {
        try {
            member.delete()
        } catch (Exception e) {
            println(e.getMessage())
            return false
        }
        return true
    }
}
