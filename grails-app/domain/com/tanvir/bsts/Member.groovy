package com.tanvir.bsts

import grails.gorm.MultiTenant

class Member implements MultiTenant<Member> {

    Integer id
    String firstName
    String lastName
    String email
    String mobile
    String password
    String memberType = GlobalConfig.USER_TYPE.REGULAR_MEMBER
    String identityHash
    Long identityHashLastUpdate
    Boolean isActive = true

    String address


    Counter counter

    Date dateCreated
    Date lastUpdated

    static belongsTo = [
            counter: Counter
    ]

    static constraints = {
        email(email: true, nullable: false, unique: true, blank: false)
        mobile(nullable: false, unique: true, blank: false)
        password(blank: false)
        lastName(nullable: true)
        identityHash(nullable: true)
        identityHashLastUpdate(nullable: true)
        counter(nullable: true)
    }

    def beforeInsert (){
        this.password = this.password.encodeAsMD5()
    }


    def beforeUpdate(){
        this.password = this.password.encodeAsMD5()
    }

    static mapping = {
        version(false)
    }

}
