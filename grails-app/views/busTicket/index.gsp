<%@ page import="com.tanvir.bsts.GlobalConfig" %>
%{--Include Main Layout--}%
<meta name="layout" content="main"/>
<div class="row">
    <div class="col-xl-4 col-sm-6 mb-xl-0 mb-4">
        <div class="card">
            <div class="card-body p-3">
                <div class="row">
                    <div class="col-8">
                        <div class="numbers">
                            <p class="text-sm mb-0 text-capitalize font-weight-bold">Today's Money</p>
                            <h5 class="font-weight-bolder mb-0">
                                $53,000
                                <span class="text-success text-sm font-weight-bolder">+55%</span>
                            </h5>
                        </div>
                    </div>
                    <div class="col-4 text-end">
                        <div class="icon icon-shape bg-gradient-primary shadow text-center border-radius-md">
                            <i class="ni ni-money-coins text-lg opacity-10" aria-hidden="true"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-4 col-sm-6 mb-xl-0 mb-4">
        <div class="card">
            <div class="card-body p-3">
                <div class="row">
                    <div class="col-8">
                        <div class="numbers">
                            <p class="text-sm mb-0 text-capitalize font-weight-bold">New Bookings</p>
                            <h5 class="font-weight-bolder mb-0">
                                +3,462
                                <span class="text-danger text-sm font-weight-bolder">-2%</span>
                            </h5>
                        </div>
                    </div>
                    <div class="col-4 text-end">
                        <div class="icon icon-shape bg-gradient-primary shadow text-center border-radius-md">
                            <i class="ni ni-paper-diploma text-lg opacity-10" aria-hidden="true"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-4 col-sm-6">
        <div class="card">
            <div class="card-body p-3">
                <div class="row">
                    <div class="col-8">
                        <div class="numbers">
                            <p class="text-sm mb-0 text-capitalize font-weight-bold">Sales</p>
                            <h5 class="font-weight-bolder mb-0">
                                $103,430
                                <span class="text-success text-sm font-weight-bolder">+5%</span>
                            </h5>
                        </div>
                    </div>
                    <div class="col-4 text-end">
                        <div class="icon icon-shape bg-gradient-primary shadow text-center border-radius-md">
                            <i class="ni ni-cart text-lg opacity-10" aria-hidden="true"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="common-list-table-view-ui col-lg-13 mt-4">
    <div class="card">
        <div class="card-header pb-0">
            <div class="row">
                <div class="col-lg-6 col-7">
                    <h6>Trips</h6>
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
                        <g:if test="${UIHelper.memberType() == GlobalConfig.USER_TYPE.ADMINISTRATOR}">
                            <g:link controller="busTicket" action="generateTickets" class="btn bg-gradient-warning btn-sm pull-end">Generate Tickets</g:link>
                        </g:if>
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
                    <g:each in="${busTickets}" var="ticket">
                        <tr>
                            <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"><span class="time-ticket-badge"><UIHelper:parseTimeInFormat time="${ticket?.boardingTime}"/></span> <UIHelper:parseDateInFormat date="${ticket?.boardingDate}"/></span></td>
                        <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.coach?.coachNumber} </span></td>
                        <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.fares?.fromStoppage?.name} </span></td>
                        <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.fares?.toStoppage?.name}</span></td>
                        <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold">${ticket?.coach?.registrationNumber}</span></td>
                        <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"><g:message code="${ticket?.fares?.seatClass}"/> </span></td>
                        <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> <UIHelper:getBookedSeatsCount ticketId="${ticket?.id}"/> </span></td>
                        <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> <UIHelper:getAvailableSeatsCount ticketId="${ticket?.id}"/> </span></td>
                        <td>
                            <div class="btn-group">
                                <g:link controller="busTicket" action="details" class="btn btn-secondary seat-ticket-book-button" id="${ticket.id}"><i class="fa fa-ticket"></i></g:link>
                            </div>
%{--                            <div class="btn-group">--}%
%{--                                <g:link controller="busTicket" action="edit" class="btn btn-secondary" id="${ticket.id}"><i class="fas fa-edit"></i></g:link>--}%
%{--                                <g:link controller="busTicket" action="delete" id="${ticket.id}" class="btn btn-secondary delete-confirmation"><i class="fas fa-trash"></i></g:link>--}%
%{--                            </div>--}%
                        </td>
                    </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="paginate">
                    <g:paginate total="${total ?: 0}" />
                </div>
            </div>
        </div>
    </div>
</div>


