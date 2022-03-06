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
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">CUSTOMER NAME</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">PHONE NUMBER</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">GENDER</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">ROUTE</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">COACH NO</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">SCHEDULED DATE</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">DEPARTURE TIME</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">NO. OF SEAT</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">SEAT NUMBER</th>
%{--                        <th class="text-secondary opacity-7"></th>--}%
                    </tr>
                    </thead>
                    <tbody>
                    <g:if test="${purchasedTickets}">
                        <g:each in="${purchasedTickets}" var="ticket">
                            <tr>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"><span class="time-ticket-badge">${ticket?.id}</td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.name} </span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.mobile} </span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${g.message(code: ticket?.sex)} </span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.routeName} </span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.coachNo}</span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.scheduledDate}</span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"><UIHelper:parseTimeInFormat time="${ticket?.departureTime}"/> </span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.totalBookedSeat}</span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.seatBookedForDisplay.replaceAll("\\]","").replaceAll("\\[","")}</span></td>
                                %{--                        <td>--}%
                                %{--                            <div class="btn-group">--}%
                                %{--                                <g:link data-bs-toggle="tooltip" data-bs-placement="top"  title="Book Seat" controller="busTicket" action="details" class="btn btn-secondary seat-ticket-book-button" id="${ticket.id}"><i class="fa fa-ticket"></i></g:link>--}%
                                %{--                            </div>--}%
                                %{--                            <div class="btn-group">--}%
                                %{--                                <g:link controller="busTicket" action="edit" class="btn btn-secondary" id="${ticket.id}"><i class="fas fa-edit"></i></g:link>--}%
                                %{--                                <g:link controller="busTicket" action="delete" id="${ticket.id}" class="btn btn-secondary delete-confirmation"><i class="fas fa-trash"></i></g:link>--}%
                                %{--                            </div>--}%
                                %{--                        </td>--}%
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


