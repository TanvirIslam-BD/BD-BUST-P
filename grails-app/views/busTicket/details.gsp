<%@ page import="com.tanvir.bsts.Counter" %>
%{--Include Main Layout--}%
<meta name="layout" content="main"/>
<asset:stylesheet src="jquery.seat-charts.css"/>
<asset:stylesheet src="booking.css"/>
<asset:stylesheet src="ticketBooking.css"/>

<asset:javascript src="ticketBooking.js"/>
<div class="row">
    <div class="card">
        <div class="card-header">
            Ticket Booking - ( ${busTicket.fares.fromStoppage.name} to ${busTicket.fares.toStoppage.name})
        </div>
        <div class="card-body seat-booking-panel-with-seat-plan-design">
            <div class="seat-plan-design">
                <g:if test="${busTicket.coach.seatMap}">
                    <div class="booking-details">
                        <div id="legend"></div>
                    </div>
                    <div id="seat-map" class="seat-panel" extraseatinlastrow="${busTicket.coach.seatMap.extraSeatInLastRow}" bookedseats="${busTicket.purchaseTickets.seatBooked.toString()}" price="${busTicket.fares.amount}" rows="${busTicket.coach.seatMap.seatRows}" columns="${busTicket.coach.seatMap.seatColumns}" >

                    </div>
                </g:if>
            </div>
            <div class="seat-info-booking-info">
                <div class="seat-info">
                    <h5>SEAT INFORMATION</h5>
                    <table class="table information_table table-responsive">
                        <thead>
                        <tr class="border-0">
                            <td scope="col" class="text-center font_detail" style="width:15%">TOTAL SEATS(<span id="counter">0</span>)</td>
                            <td scope="col"  class="text-center font_detail" style="width:15%">TOTAL FARE</td>
                        </tr>
                        </thead>
                        <tbody class="table-striped border-1">
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
                <h5>BOOKING INFORMATION</h5>
                <div class="booking-info">
                    <g:form controller="busTicket" action="saveBookingTicket">
                        <input type="hidden" name="busTicketId" value="${busTicket.id}">
                        <div class="booked-seat-map-numbers" style="display: none;"></div>
                        <div class="row">
                            <div class="col-sm-12 col-md-6 col-lg-6">
                                <table border="0">
                                    <tbody class="dashboard_tble">
                                    <tr>
                                        <td><p class="font_detail">PASSENGER MOBILE</p></td>
                                        <td>
                                            <div class="input-group form_width font_detail"><input name="mobile" type="text" class="form-control font_detail" aria-label="Passenger Mobile"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><p class="font_detail">NAME</p></td>
                                        <td><input name="name" class="form-control form_width font_detail" type="text"></td>
                                    </tr>
                                    <tr>
                                        <td><p class="font_detail">GENDER</p></td>
                                        <td>
                                            <UIHelper:gender value="${busTicket}"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><p class="font_detail">AGE</p></td>
                                        <td><input name="age" class="form-control form_width font_detail" type="text"></td>
                                    </tr>
                                    <tr>
                                        <td><p class="font_detail">PASSPORT</p></td>
                                        <td><input name="passport" class="form-control form_width font_detail" type="text"></td>
                                    </tr>
                                    <tr>
                                        <td><p class="font_detail">Referenced Counter</p></td>
                                        <td><UIHelper:domainSelect class="form-control" domain="${Counter}" name="referencedCounter"/></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-sm-12 col-md-6 col-lg-6">
                                <table border="0" class="inner_dashboard_table">
                                    <tbody class="dashboard_tble">
                                    <tr>
                                        <td><p class="font_detail">Address</p></td>
                                        <td><input name="address" class="form-control form_width font_detail" type="text"></td>
                                    </tr>
                                    <tr>
                                        <td><p class="font_detail">Nationality</p></td>
                                        <td><input name="nationality" class="form-control form_width font_detail" type="text" value="BANGLADESHI"></td>
                                    </tr>
                                    <tr>
                                        <td><p class="font_detail">Boarding Place</p></td>
                                        <td><input name="boardingPlace" class="form-control form_width font_detail" type="text"/></td>
                                    </tr>
                                    <tr>
                                        <td><p class="font_detail">Discount</p></td>
                                        <td><input name="discount" class="form-control booked-seat-discount-on-total form_width font_detail" type="number" value="0"></td>
                                    </tr>
                                    <tr class="total-paid-row">
                                        <td><p class="total-paid-title font_detail fw-bold">Total Paid</p></td>
                                        <td><input name="totalPaid" class="total-paid-amount form-control form_width fw-bold font_detail" style="pointer-events: none;
                                        background-color: #E9ECEF;" type="number"></td>
                                    </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-6 col-sm-6 col-md-12 col-lg-12 d-flex d-sm-flex justify-content-sm-end justify-content-end justify-content-md-center justify-content-lg-center">

                                <div class="form-action-panel">
                                    <g:submitButton class="btn btn-primary" name="save" value="Confirm"/>
                                    <g:link controller="busTicket" action="index" class="btn btn-secondary">Back</g:link>
                                </div>
                            </div>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>
        <asset:javascript src="jquery.seat-charts.js"/>
    </div>
</div>

