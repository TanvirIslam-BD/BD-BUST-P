package com.tanvir.bsts

import grails.web.servlet.mvc.GrailsParameterMap
import org.hsqldb.User

import javax.transaction.Transactional

@Transactional
class MemberService {


    AuthenticationService authenticationService

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

    def saveUserPermission(GrailsParameterMap params) {
        Long userId = params.userId.toLong()
        params.permission.each{
            UserPermission userPermission = UserPermission.findByPermissionKeyAndUserId(it.key, userId) ?:  new UserPermission()
            userPermission.permissionKey = it.key
            userPermission.permissionValue = it.value.toBoolean()
            userPermission.userId = userId
            userPermission.save()
        }
        return [isSuccess: true]
    }

    def userPermissions(GrailsParameterMap params) {
        return UserPermission.findAllByUserId(params.userId)
    }

    boolean userPermissionCheck(def permissionKey) {
        Member user = authenticationService.getMember()
        if(user && user.memberType == GlobalConfig.USER_TYPE.ADMINISTRATOR){
            return true
        }
        def userPermission = UserPermission.findByUserIdAndPermissionKey(user.id, permissionKey)
        return userPermission ? userPermission?.permissionValue : false
    }

    def update(Member member, GrailsParameterMap params) {
        member.properties = params
        def response = AppUtil.saveResponse(false, member)
        if (member.validate()) {
            member.merge()
            if (!member.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }


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
