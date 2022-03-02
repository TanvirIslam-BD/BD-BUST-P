<%@ page import="com.tanvir.bsts.Counter" %>
%{--Include Main Layout--}%
<meta name="layout" content="main"/>
<asset:stylesheet src="jquery.seat-charts.css"/>
<asset:stylesheet src="booking.css"/>
<asset:stylesheet src="ticketBooking.css"/>
<asset:stylesheet src="seat.css"/>
<asset:javascript src="ticketBooking.js"/>

<div class="row">
    <div class="card">
        <div class="card-header">
            Ticket Booking - <span class="route-title-header">${busTicket.route.name}</span> :<span class="boardingtime-title-header"> <UIHelper:parseTimeInFormat time="${busTicket.boardingTime}"/> </span>
        </div>
        <div class="card-body seat-booking-panel-with-seat-plan-design seat-container">
            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 seat-design-map-ui">
                <div class="row">
                    <div class="col-md-offset-7 col-md-4 col-sm-offset-7 col-sm-4 col-xs-offset-7 col-xs-4 bus-steering-wheel">
                        <i class="fa fa-steering-wheel"></i>
                    </div>
                </div>
                <g:if test="${busTicket.coach.seatMap}">
                    <div class="row" id="seat-design">
                       <div ticketid="${busTicket.id}" id="seat-map" class="seat-panel seatCharts-container" femalebookedseats="${femaleBookedSeats.seatBooked.toString()}" extraseatinlastrow="${busTicket.coach.seatMap.extraSeatInLastRow}" bookedseats="${busTicket.purchaseTickets.seatBooked.toString()}" price="${100}" rows="${busTicket.coach.seatMap.seatRows}" columns="${busTicket.coach.seatMap.seatColumns}" >

                       </div>
                    </div>
                </g:if>
            </div>
            <div class="booking-details col-lg-8 col-md-8 col-sm-12 col-xs-12">
                <h6>Booking Details</h6>
                <div class="row">
                    <div id="table-div" class="col-lg-12 col-md-12 col-sm-12 col-xs-12 table-responsive">
                        <table class="table table-bordered" id="cartTable">
                            <thead>
                            <tr>
                                <th class="text-center">TOTAL SEATS(<span id="counter">0</span>)</th>
                                <th class="text-center" >TOTAL FARE</td>
                            </tr>
                            </thead>
                            <tbody class="table-striped">
                            <tr>
                                <td class="border-1 text-center font_detail">
                                    <span class="orange-bold-text" id="selected-seats"></span>
                                </td>
                                <td class="border-1 text-center font_detail">
                                    <span id="total"  class="total-flare-title orange-bold-text"></span>
                                    <input type="hidden" class="total-amount-to-paid-to-calc" name="totalAmountToPaidToCalc" value="0">
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row  reservation-form">
                    <g:form class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="ticketForm" controller="busTicket" action="saveBookingTicket">
                        <input type="hidden" name="busTicketId" value="${busTicket.id}">
                        <input type="hidden" name="coachNo" value="${busTicket.coach.coachNumber}">
                        <input type="hidden" name="routeName" value="${busTicket.route.name}">
                        <input type="hidden" id="route-id" name="routeId" value="${busTicket.route.id}">
                        <input style="display: none" type="date" name="scheduledDate" value="${UIHelper.parseDateInFormat(date: busTicket.boardingDate)}">
                        <input type="hidden" name="departureTime" value="${busTicket.boardingTime}">

                        <div class="booked-seat-map-numbers" style="display: none;"></div>
                        <div class="form-row">
                            <div class="form-group col-md-4">
                                <label class="required">Boarding (From)</label>
                                <select id="fromStoppage"  name="fromCounter" class="form-control fromToStoppage input-sm valid">
                                    <g:each in="${routeCountersFrom}" status="i" var="counter">
                                        <g:if test="${counter}">
                                            <option value="${counter?.id}">${counter?.name}</option>
                                        </g:if>
                                    </g:each>
                                </select>
                            </div>
                            <div class="form-group col-md-4">
                                <label class="required">Drop-off (To)</label>
                                <select id="toStoppage" name="toCounter" class="form-control fromToStoppage input-sm valid">
                                    <g:each in="${routeCountersTo}" status="i" var="counter">
                                        <g:if test="${counter}">
                                            <option value="${counter?.id}">${counter?.name}</option>
                                        </g:if>
                                    </g:each>
                                </select>
                            </div>
                            <div class="form-group col-md-4">
                                <label class="required">Passenger Mobile</label>
                                <input name="mobile" type="text" class="form-control font_detail" aria-label="Passenger Mobile">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-4">
                                <label class="required">Name</label>
                                <input name="name" class="form-control form_width font_detail" type="text">
                            </div>
                            <div class="form-group col-md-4">
                                <label class="required">Gender</label>
                                <UIHelper:gender value="${busTicket}"/>
                            </div>
                            <div class="form-group col-md-4">
                                <label >Discount</label>
                                <input name="discount" class="form-control booked-seat-discount-on-total form_width font_detail" type="number" value="0">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-4">
                                <label >Total Paid</label>
                                <input name="totalPaid" class="total-paid-amount form-control form_width fw-bold font_detail" style="pointer-events: none;
                                background-color: #E9ECEF;" type="number">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="btn-group-wrap">
                                <div class="btn-group">
                                    <g:submitButton class="btn btn-primary" name="save" value="Confirm" onclick="soft.showSwal('warning-message-and-confirmation')"/>
                                </div>
                                <div class="btn-group">
                                    <g:link controller="busTicket" action="index" class="btn btn-secondary">Trip List</g:link>
                                </div>
                            </div>
                        </div>
                    </g:form>
                </div>
                <div class="row">
                    <div id="legend" style="padding: 15px 0 0 80px; pointer-events: none;" class="seatCharts-legend"></div>
                </div>
            </div>
        </div>
        <asset:javascript src="jquery.seat-charts.js"/>
    </div>
</div>

