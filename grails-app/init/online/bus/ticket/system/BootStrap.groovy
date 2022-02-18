package online.bus.ticket.system

import com.tanvir.bsts.AppInitializationService

class BootStrap {

    def init = { servletContext ->
        AppInitializationService.initialize()


    }

    def destroy = {
    }
}
