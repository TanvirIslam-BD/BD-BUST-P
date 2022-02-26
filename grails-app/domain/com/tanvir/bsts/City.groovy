package com.tanvir.bsts

import grails.gorm.MultiTenant

class City implements MultiTenant<City> {


    Integer id

    String name

    static constraints = {

    }

    static void initialize() {

        if(City.count() == 0) {
            GlobalConfig.CITY_NAME.each {cityName->
                new City(name: cityName.value).save()
            }
        }
    }

}
