<%@ page import="com.tanvir.bsts.Counter" %>

<meta name="layout" content="main"/>

<asset:stylesheet src="jquery.seat-charts.css"/>
<asset:stylesheet src="booking.css"/>
<asset:stylesheet src="ticketBooking.css"/>
<asset:stylesheet src="seat.css"/>
<asset:stylesheet src="remote-idle-design.css"/>
<asset:javascript src="spin.js"/>
<asset:javascript src="remote-idle-app.js"/>

<div class="row">
    <div class="card">
        <div class="card-header booking-details-daily-trip">
            <span class="route-title-header">${busTicket.route.name}</span> <span class="boardingtime-title-header"> <UIHelper:parseTimeInFormat time="${busTicket.boardingTime}"/> </span>
        </div>

        <div id="advance-ticket-book-ui-body" class="card-body seat-booking-panel-with-seat-plan-design seat-container advance-ticket-book-ui-body">

            <asset:javascript src="jquery.seat-charts.js"/>
            <asset:javascript src="ticketBooking.js"/>

            <g:if test="${busTicket}">
                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 seat-design-map-ui">
                    <div class="row">
                        <div class="col-md-offset-7 col-md-4 col-sm-offset-7 col-sm-4 col-xs-offset-7 col-xs-4 bus-steering-wheel">
                            <i class="fa fa-steering-wheel"></i>
                        </div>
                    </div>
                    <g:if test="${busTicket?.coach?.seatMap}">
                        <div class="row" id="seat-design">
                            <div ticketid="${busTicket?.id}" id="seat-map" class="seat-panel seatCharts-container"
                                 femalesoldseats="${femaleSoldSeats?.seatBooked?.toString()}"
                                 extraseatinlastrow="${busTicket?.coach?.seatMap?.extraSeatInLastRow}"
                                 soldseats="${purchaseTickets?.seatBooked?.toString()}"
                                 bookedseats="${bookedSeats?.seatBooked?.toString()}"
                                 price="${100}"
                                 date="${date}"
                                 rows="${busTicket?.coach?.seatMap?.seatRows}"
                                 columns="${busTicket?.coach?.seatMap?.seatColumns}">

                            </div>
                        </div>
                    </g:if>
                </div>
                <div class="booking-details col-lg-8 col-md-8 col-sm-12 col-xs-12">
                    <h6>BOOKING DETAILS</h6>
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
                        <form class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="ticketForm">
                            <input type="hidden" name="busTicketId" value="${busTicket?.id}">
                            <input type="hidden" name="coachNo" value="${busTicket?.coach?.coachNumber}">
                            <input type="hidden" name="routeName" value="${busTicket?.route?.name}">
                            <input type="hidden" id="route-id" name="routeId" value="${busTicket?.route?.id}">
                            <input type="hidden" name="scheduledDate" value="${date}">
                            <input type="hidden" name="departureTime" value="${busTicket?.boardingTime}">

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
                                    <input id="customer-phoneNumber" name="mobile" type="text" class="form-control font_detail" aria-label="Passenger Mobile">
                                </div>

                            </div>
                            <div class="form-row">

                                <div class="form-group col-md-4">
                                    <label class="required">Name</label>
                                    <div class="input-group" id="user-group">
                                        <input id="customer-name" name="name" class="form-control form_width font_detail" type="text">
                                        <span class="input-group-addon">
                                            <label style="cursor: pointer">
                                                <input type="checkbox" id="unknownUserCheckBox">
                                                UNKNOWN
                                            </label>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="required">Gender</label>
                                    <UIHelper:gender id="customer-gender" value="${busTicket}"/>
                                </div>
                                <div class="form-group col-md-4">
                                    <label >Discount</label>
                                    <input name="discount" class="form-control booked-seat-discount-on-total form_width font_detail" type="number" value="0">
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-4">
                                    <label >Total Paid</label>
                                    <input name="totalPaid" id="totalPaidAmount" class="total-paid-amount form-control form_width fw-bold font_detail" style="pointer-events: none;
                                    background-color: #E9ECEF;" type="number">
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-required" for="ReceivedFromCustomer">Received</label>
                                    <input class="form-control input-sm text-box single-line" data-val="true" data-val-number="The field Received must be a number." data-val-required="The Received field is required." id="receivedFromCustomer" name="receivedFromCustomer" onkeypress="onlyNonNegativeNumeric(event)" type="text" value="0.00">
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-required" for="DueAmount">Due</label>
                                    <input class="form-control input-sm text-box single-line valid" data-val="true" data-val-number="The field Due must be a number." data-val-required="The Due field is required." id="DueAmount" name="dueAmount" onkeypress="onlyNonNegativeNumeric(event)" readonly="true" tabindex="-1" type="text" value="0.00" aria-describedby="DueAmount-error" aria-invalid="false">
                                </div>
                            </div>
                            <div class="form-row book-sell-button-row">
                                <div class="btn-group-wrap">
                                    <div class="btn-group">
                                        <button type="button"  class="disabled btn btn-primary book-confirm-button">Book</button>
                                    </div>
                                    <div class="btn-group">
                                        <button type="button"  class="disabled btn btn-primary sell-confirm">Sell</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="row booking-legend-row">
                        <div id="legend" style="padding: 15px 0 0 80px; pointer-events: none;" class="seatCharts-legend"></div>
                    </div>
                </div>
            </g:if>

            <g:else>
                <g:render template="noDataFound" />
            </g:else>

            <script>

                $('.book-confirm-button').on('click',function(e) {
                    var formData = serializeObject($('#ticketForm'))
                    formData.paymentType =  "book"
                    $.ajax({
                        url: BSTS.baseURL + 'busTicketAdvance/saveBookingTicket',
                        method: 'GET',
                        dataType: 'html',
                        async: false,
                        data: formData,
                        success: function (data) {
                            var bookingPanel = data;
                            $("#advance-ticket-book-ui-body").html(bookingPanel);
                            swal({
                                html: true,
                                content: {
                                    element: 'p',
                                    attributes: {
                                        innerHTML: `<div class="swal2-html-container" style="display: block;">Ticket has been booked successfully!!!</div>`
                                    }
                                },
                                icon:"success"
                            });
                        }
                    });
                });

                $('.sell-confirm').on('click',function(e) {
                    var formData = serializeObject($('#ticketForm'))
                    formData.paymentType =  "sell"
                    $.ajax({
                        url: BSTS.baseURL + 'busTicketAdvance/saveBookingTicket',
                        method: 'GET',
                        dataType: 'html',
                        async: false,
                        data: formData,
                        success: function (data) {
                            var bookingPanel = data;
                            $("#advance-ticket-book-ui-body").html(bookingPanel);
                            swal({
                                html: true,
                                content: {
                                    element: 'p',
                                    attributes: {
                                        innerHTML: `<div class="swal2-html-container" style="display: block;">Ticket has been sold successfully!!!</div>`
                                    }
                                },
                                icon:"success"
                            });
                        }
                    });
                });

                function serializeObject(form) {
                    var o = {}
                    var a = (form.is("form") ? form : form.find(":input")).serializeArray()
                    $.each(a, function () {
                        if (o[this.name] !== undefined) {
                            if (!$.isArray(o[this.name])) {
                                o[this.name] = [o[this.name]]
                            }
                            o[this.name].push(this.value || '')
                        } else {
                            o[this.name] = this.value || ''
                        }
                    })
                    return o
                }

            </script>

        </div>


    </div>
</div>

