<%@ page import="com.tanvir.bsts.GlobalConfig" %>
%{--Include Main Layout--}%
<meta name="layout" content="main"/>
<div class="common-list-table-view-ui col-lg-13 mt-4">
    <div class="card">
        <div class="card-header pb-0">
            <div class="row">
                <div class="col-lg-6 col-7">
                    <h6>BOOKED TICKETS</h6>
                    <p class="text-sm mb-0">
                        <i class="fa fa-check text-info" aria-hidden="true"></i>
                        The booked tickets list of the passengers
                    </p>
                </div>
                <div class="col-lg-6 col-5 my-auto text-end">
                    <div class="btn-group">
                        <g:form controller="purchasedTicket" action="index" method="GET">
                            <div class="input-group" id="search-area">
                                <g:select name="colName" class="form-control" from="[boardingTime: 'Boarding Time']" value="${params?.colName}" optionKey="key" optionValue="value"/>
                                <input name="colValue" class="form-control" type="time" value="${params?.colValue}">
                                <span class="input-group-text text-body">
                                    <button class="btn btn-sm" type="submit"><i class="fas fa-search" aria-hidden="true"></i></button>
                                </span>
                            </div>
                        </g:form>
                    </div>

                    <div class="form-group">
                        <g:link controller="purchasedTicket" action="index" class="btn bg-gradient-info btn-sm pull-end"><g:message code="reload"/></g:link>
                    </div>

                </div>
            </div>
        </div>
        <div class="card-body px-0 pb-2">
            <div class="table-responsive">
                <table class="table align-items-center mb-0">
                    <thead>
                    <tr>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">SL.</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">CUSTOMER NAME</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">STATUS</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">PHONE NUMBER</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">GENDER</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">ROUTE</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">COACH NO</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">SCHEDULED DATE</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">DEPARTURE TIME</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">NO. OF SEAT</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">SEAT NUMBER</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">REVENUE</th>
%{--                        <th class="text-secondary opacity-7"></th>--}%
                    </tr>
                    </thead>
                    <tbody>
                    <g:if test="${purchasedTickets}">
                        <g:each in="${purchasedTickets}" var="ticket">
                            <tr>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"><span class="time-ticket-badge">${ticket?.id}</td>
                                <td class="align-middle  text-sm"><span class="text-xs font-weight-bold"> ${ticket?.name} </span></td>
                                <td class="align-middle text-sm">
                                    <span class="text-xs font-weight-bold">
                                        <div class="d-flex align-items-center">
                                            <button class="btn btn-icon-only btn-rounded ${ticket?.isReturned ? 'btn-outline-danger' : (ticket?.paymentType == "book" ? 'btn-outline-dark' : ' btn-outline-success')} mb-0 me-2 btn-sm d-flex align-items-center justify-content-center">
                                                <i class="fas ${ticket?.isReturned ? 'fa-undo' : (ticket?.paymentType == "book" ? 'fa-cheese' : 'fa-check')}" aria-hidden="true"></i>
                                            </button>
                                            <span>${ticket?.isReturned ? 'RETURNED' : (ticket?.paymentType == "book" ? 'BOOKED' : 'SOLD')}</span>
                                        </div>
                                   </span>
                                </td>
                                <td class="align-middle text-sm"><span class="text-xs font-weight-bold"> ${ticket?.mobile} </span></td>
                                <td class="align-middle  text-sm"><span class="text-xs font-weight-bold"> ${g.message(code: ticket?.sex)} </span></td>
                                <td class="align-middle text-sm"><span class="text-xs font-weight-bold"> ${ticket?.routeName} </span></td>
                                <td class="align-middle text-sm"><span class="text-xs font-weight-bold"> ${ticket?.coachNo}</span></td>
                                <td class="align-middle text-sm"><span class="text-xs font-weight-bold"> ${ticket?.scheduledDate}</span></td>
                                <td class="align-middle text-sm"><span class="text-xs font-weight-bold"><UIHelper:parseTimeInFormat time="${ticket?.departureTime}"/> </span></td>
                                <td class="align-middle text-sm"><span class="text-xs font-weight-bold"> ${ticket?.totalBookedSeat}</span></td>
                                <td class="align-middle text-sm"><span class="text-xs font-weight-bold"> ${ticket?.seatBookedForDisplay.replaceAll("\\]","").replaceAll("\\[","")}</span></td>
                                <td class="align-middle text-sm"><span class="text-xs font-weight-bold"> ${ticket?.receivedFromCustomer}</span></td>
                            </tr>
                        </g:each>
                    </g:if>
                    <g:else>
                        <g:render template="noDataFound" />
                    </g:else>
                    </tbody>
                </table>
                <div class="paginate">
                    <g:paginate total="${total ?: 0}" />
                </div>
            </div>
        </div>
    </div>
</div>


