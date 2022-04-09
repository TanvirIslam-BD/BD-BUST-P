package com.tanvir.bsts

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class PurchasedTicketsService {


    def list(GrailsParameterMap params) {
        params.max = params.max ?: GlobalConfig.itemsPerPage()
        List<PurchaseTicket> purchasedTicketList = PurchaseTicket.createCriteria().list(params) {
            if (params?.colName && params?.colValue) {
                like(params.colName, "%" + params.colValue + "%")
            }
            if (!params.sort) {
                order("id", "desc")
            }
        }
        return [list: purchasedTicketList, count: purchasedTicketList.totalCount]
    }

    def soldList(GrailsParameterMap params) {
        params.max = params.max ?: GlobalConfig.itemsPerPage()
        def ticketId = params?.id?.toLong()
        List<PurchaseTicket> soldTicketList = PurchaseTicket.createCriteria().list(params) {
            eq("busTicketTemplateId", ticketId)
            eq("scheduledDate", params.date)
            eq("paymentType", "sell")
            if (params?.colName && params?.colValue) {
                like(params.colName, "%" + params.colValue + "%")
            }
            if (!params.sort) {
                order("id", "desc")
            }
        }
        return [list: soldTicketList, count: soldTicketList.totalCount]
    }
}
