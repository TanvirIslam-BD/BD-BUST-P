package com.tanvir.bsts


class AppInitializationService {

    static initialize() {
        initMember()
    }

    private static initMember() {
        if (Member.count() == 0) {

            Member member = new Member()
            member.firstName = "Tanvir"
            member.lastName = "Islam"
            member.email = "tanvir@gmail.com"
            member.password = "123456"
            member.memberType = GlobalConfig.USER_TYPE.ADMINISTRATOR
            member.save(flash: true)

        }
    }
}
