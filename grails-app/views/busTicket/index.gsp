<%@ page import="com.tanvir.bsts.GlobalConfig" %>
%{--Include Main Layout--}%
<meta name="layout" content="main"/>
<div class="common-list-table-view-ui col-lg-13 mt-4">
    <div class="card">
        <div class="card-header pb-0">
            <div class="row">
                <div class="col-lg-6 col-7">
                    <h6>Daily Trips List</h6>
                    <p class="text-sm mb-0">
                        <i class="fa fa-check text-info" aria-hidden="true"></i>
                        Book the ticket from the trip list by click on book button
                    </p>
                </div>
                <div class="col-lg-6 col-5 my-auto text-end">
                    <div class="btn-group">
                        <g:form controller="busTicket" action="index" method="GET">
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
                        <g:link controller="busTicket" action="index" class="btn bg-gradient-info btn-sm pull-end"><g:message code="reload"/></g:link>
                    </div>

                </div>
            </div>
        </div>
        <div class="card-body px-0 pb-2">
            <div class="table-responsive">
                <table class="table align-items-center mb-0">
                    <thead>
                    <tr>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">BOARDING TIME & DATE</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">COACH NO.</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">ROUTE</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">STARTING COUNTER</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">END COUNTER</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">REGISTRATION NUMBER</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">COACH TYPE</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">BOOKED</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">AVAILABLE</th>
                        <th class="text-secondary opacity-7"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:if test="${busTickets}">
                        <g:each in="${busTickets}" var="ticket">
                            <tr>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"><span class="time-ticket-badge"><UIHelper:parseTimeInFormat time="${ticket?.boardingTime}"/></span><span id="ticket-date-schedule">${currentDate}</span> </span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.coach?.coachNumber} </span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.route?.name} </span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.route?.fromStoppage?.name} </span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.route?.toStoppage?.name}</span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold">${ticket?.coach?.registrationNumber}</span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"><g:message code="${ticket?.coach?.seatClass}"/> </span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> <UIHelper:getBookedSeatsCount ticketId="${ticket?.id}"/> </span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> <UIHelper:getAvailableSeatsCount ticketId="${ticket?.id}"/> </span></td>
                                <td>
                                    <div class="btn-group">
                                        <g:link data-bs-toggle="tooltip" data-bs-placement="top"  title="Book Seat" controller="busTicket" action="details" class="btn btn-secondary seat-ticket-book-button" id="?id=${ticket.id}&date=${currentDate}" date="${currentDate}"><i class="fa fa-ticket"></i></g:link>
                                    </div>
                                </td>
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
