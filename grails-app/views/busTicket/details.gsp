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

        <div style="display:none;" id="SearchScheduleFrom">
            <input type="hidden" id="Date" name="routeName" value="${date}">
            <input type="hidden" id="RouteId" name="routeId" value="${busTicket?.route?.id}">
            <input type="hidden" id="ScheduleId" name="routeId" value="${busTicket?.id}">
        </div>

        <div id="advance-ticket-book-ui-body" class="card-body seat-booking-panel-with-seat-plan-design seat-container advance-ticket-book-ui-body">

            <asset:javascript src="jquery.seat-charts.js"/>
            <asset:javascript src="ticketBooking.js"/>
            <asset:javascript src="PullDataRquest.js"/>

            <g:if test="${busTicket}">
                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 seat-design-map-ui">
                    <div class="bus-steering-wheel">
                        <asset:image class="seat-front-view" src="seat-front.png" alt="seat_front"/>
                    </div>
                    <g:if test="${busTicket?.coach?.seatMap}">
                        <div class="row" id="seat-design">
                             <div ticketid="${busTicket?.id}" id="seat-map" class="seat-panel seatCharts-container"
                                     selectedseats="${selectedSeat?.seatBooked}"
                                     femalesoldseats="${femaleSoldSeats?.seatBooked?.toString()}"
                                     extraseatinlastrow="${busTicket?.coach?.seatMap?.extraSeatInLastRow}"
                                     soldseats="${purchaseTickets?.seatBooked?.toString()}"
                                     bookedseats="${bookedSeats?.seatBooked?.toString()}"
                                     femalebookedseats="${femaleBookedSeats?.seatBooked?.toString()}"
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
                                    <th class="text-center">SEAT</th>
                                    <th class="text-center" >FARE</td>
                                </tr>
                                </thead>
                                <tbody class="table-striped">

                                <tr id="selected-seats-details-row">
                                    <td class="border-1 text-center font_detail">
                                        <span class="orange-bold-text" id="selected-seats-count">
                                            TOTAL SEATS: <span id="counter">0</span>
                                        </span>
                                    </td>
                                    <td class="border-1 text-center font_detail">
                                        <span id="total"  class="total-flare-title orange-bold-text">TOTAL: 0 TK</span>
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
                            <input type="hidden" name="returnedTicketId" value="${returnedTicketId}">
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
                                                <option ${selectedSeat?.fromCounter?.id == counter?.id ? "selected" : ""} value="${counter?.id}">
                                                    ${counter?.name}( ${UIHelper.parseTimeInFormat(time: UIHelper.getTicketCounterStartTime(ticketId: busTicket?.id, counterId: counter?.id))})</option>
                                            </g:if>
                                        </g:each>
                                    </select>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="required">Drop-off (To)</label>
                                    <select id="toStoppage" name="toCounter" class="form-control fromToStoppage input-sm valid">
                                        <g:each in="${routeCountersTo}" status="i" var="counter">
                                            <g:if test="${counter}">
                                                <option ${selectedSeat?.toCounter?.id == counter?.id ? "selected" : ""} value="${counter?.id}">${counter?.name}</option>
                                            </g:if>
                                        </g:each>
                                    </select>
                                </div>

                                <div class="form-group col-md-4">
                                    <label>Vehicle</label>
                                    <label class="form-control vehicle-name-type input-sm" style="font-weight: normal; overflow:hidden">
                                        ${busTicket.coach.name}(${busTicket.coach.seatClass.toUpperCase()} Coach)
                                    </label>
                                </div>

                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-4">
                                    <label class="required">Passenger Mobile</label>
                                    <input data-val-regex="The field PhoneNumber must match the regular expression '(^([+]{1}[8]{2}|0088)?(01){1}[5-9]{1}/d{8})$'."
                                           data-val-regex-pattern="(^([+]{1}[8]{2}|0088)?(01){1}[5-9]{1}/d{8})$" data-val-required="The PhoneNumber field is required."
                                           placeholder="Mobile No." required="required" type="tel"  id="customer-phoneNumber" value="${selectedSeat?.mobile}" name="mobile"
                                           type="text" class="form-control font_detail" aria-label="Passenger Mobile">
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="required">Name</label>
                                    <div class="input-group" id="user-group">
                                        <input required="required" placeholder="Full Name" data-val="true" data-val-required="The Name field is required." value="${selectedSeat.name}"
                                               id="customer-name" name="name" class="form-control form_width font_detail" type="text">
                                        <span class="input-group-addon">
                                            <label style="cursor: pointer">
                                                <input type="checkbox" id="unknownUserCheckBox">
                                                UNKNOWN
                                            </label>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group col-md-2">
                                    <label class="required">Gender</label>
                                    <UIHelper:gender id="customer-gender" value="${busTicket}"/>
                                </div>
                                <div class="form-group col-md-2">
                                    <label >Discount</label>
                                    <input onkeypress="onlyNonNegativeNumeric(event)" data-val="true" data-val-number="The field Discount must be a number." data-val-required="The Discount field is required."
                                           value="${selectedSeat.discount}" name="discount" class="form-control booked-seat-discount-on-total form_width font_detail"
                                           type="number" value="0">
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group ${selectedSeat?.id ? "col-md-3" : "col-md-4"}">
                                    <label >Total Paid</label>
                                    <input value="${selectedSeat.totalPaid}" name="totalPaid" id="totalPaidAmount" class="total-paid-amount form-control form_width fw-bold font_detail"
                                           style="pointer-events: none;background-color: #E9ECEF;" type="number">
                                </div>
                                <div class="form-group ${selectedSeat?.id ? "col-md-3" : "col-md-4"}">
                                    <label class="control-required" for="ReceivedFromCustomer">Received</label>
                                    <input data-val="true" data-val-number="The field Received must be a number." data-val-required="The Received field is required."
                                        ${selectedSeat?.id ? "disabled" : ""}   value="${selectedSeat.receivedFromCustomer}" class="form-control input-sm text-box single-line"
                                           data-val="true" data-val-number="The field Received must be a number." data-val-required="The Received field is required."
                                           id="receivedFromCustomer" name="receivedFromCustomer" onkeypress="onlyNonNegativeNumeric(event)" type="text" value="0.00">
                                </div>
                                <div class="form-group ${selectedSeat?.id ? "col-md-3" : "col-md-4"}">
                                    <label class="control-required" for="DueAmount">Due</label>
                                    <input value="${selectedSeat.dueAmount}" class="form-control input-sm text-box single-line valid" data-val="true" data-val-number="The field Due must be a number." data-val-required="The Due field is required." id="DueAmount" name="dueAmount" onkeypress="onlyNonNegativeNumeric(event)" readonly="true" tabindex="-1" type="text" value="0.00" aria-describedby="DueAmount-error" aria-invalid="false">
                                </div>
                                <input value="0" name="commission" id="commission" class="commission-amount form-control form_width fw-bold font_detail" type="hidden">
                                <g:if test="${selectedSeat?.id}">
                                    <div class="form-group ${selectedSeat?.id ? "col-md-3" : "col-md-4"}">
                                        <label for="ReturnAmount">Return</label>
                                        <input readonly="true" id="ReturnAmount" name="returnedAmount"   value="${selectedSeat.receivedFromCustomer}" class="form-control input-sm text-box single-line" data-val="true" data-val-number="The field Ret. Amount must be a number." data-val-required="The Ret. Amount field is required." type="text" >
                                    </div>
                                </g:if>
                            </div>
                            <div class="form-row book-sell-button-row">
                                <g:if test="${selectedSeat?.id}">
                                    <div class="btn-group-wrap">
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-primary booking-return-button">RETURN</button>
                                        </div>
                                    </div>
                                </g:if>
                                <g:else>
                                    <div class="btn-group-wrap">
                                        <div class="btn-group">
                                            <button type="button" class="disabled btn btn-primary book-confirm-button">BOOK</button>
                                        </div>
                                        <div class="btn-group">
                                            <button type="button" class="disabled btn btn-primary sell-confirm">SELL</button>
                                        </div>
                                    </div>
                                </g:else>
                            </div>
                        </form>
                    </div>
                    <div class="row booking-legend-row">
                        <div id="legend" style="padding: 15px 0 0 20px; pointer-events: none;" class="seatCharts-legend"></div>
                    </div>
                </div>
            </g:if>

            <g:else>
                <g:render template="noDataFound" />
            </g:else>

            <script>

                console.log("script book");
                $('.book-confirm-button').on('click',function(e) {
                    showLoader()


                    setTimeout(function () {

                        var ticketForm = $('#ticketForm');

                        var ticketList = $(".selected-book-seats-item");
                        var maxNoSeatAllow = 5
                        if (ticketList.length < 1) {
                            swal("Seat No# Required!!!", "Please select seat first.", "error");
                            return false;

                        } else if (ticketList.length > maxNoSeatAllow) {
                            swal("Max Seats Selected!!!", `You Can Not Sell More than ${maxNoSeatAllow} Tickets at a Time.`, "error");
                            return false;
                        } else if (!$('#customer-phoneNumber').val()) {
                            swal("Mobile Number Required!!!", "Please Enter Mobile Number.", "error");
                            return false;

                        } else if (!$("#customer-name").val()) {
                            swal("Customer Name Required!!!", "Please Enter Customer Name.", "error");
                            return false;

                        } else if (!$("#fromStoppage").val()) {
                            swal("Destination Required!!!", "Please Select destination station (From).", "error");
                            return false;

                        } else if (!$("#toStoppage").val()) {
                            swal("Destination Required!!!", "Please Select destination station (To).", "error");
                            return false;

                        } else if ($("#fromStoppage").val() == $("#toStoppage").val()) {
                            swal("From and To Same!!!", "Please Select different destination station (From or To).", "error");
                            return false;
                        }else {
                            var isValidate = true;
                            ticketForm.validate();
                            isValidate = ticketForm.valid();
                            if (isValidate) {
                                Spiner.show();
                                ticketForm.find("input[type=text]").each(function() {
                                    this.value = $.trim(this.value);
                                });
                                var formData = serializeObject(ticketForm)
                                formData.paymentType =  "book"
                                proceedSeatBooking(formData)
                            }else {
                                $.each(ticketForm.validate().errorList, function(key, value) {
                                    $errorSpan = $("span[data-valmsg-for='" + value.element.id + "']");
                                    $errorSpan.html(value.message);
                                    $errorSpan.show();
                                });
                                Spiner.hide();
                                swal({
                                    html: true,
                                    content: {
                                        element: 'p',
                                        attributes: {
                                            innerHTML: `<div class="swal2-html-container" style="display: block;">Form values are invalid!!!</div>`
                                        }
                                    },
                                    icon:"error"
                                });
                            }

                        }



                    }, 1000);


                });

                $('.booking-return-button').on('click',function(e) {
                    showLoader()
                    setTimeout(function () {
                        var formData = serializeObject($('#ticketForm'))
                        formData.paymentType =  "book"
                        $.ajax({
                            url: BSTS.baseURL + 'busTicketAdvance/returnBookedTicket',
                            method: 'GET',
                            dataType: 'html',
                            async: false,
                            data: formData,
                            success: function (data) {
                                var bookingPanel = data;
                                var selectedSeats = $(".seatCharts-seat.selected")
                                clearHoldingTicketsNow(selectedSeats);
                                $("#advance-ticket-book-ui-body").html(bookingPanel);
                                swal({
                                    html: true,
                                    content: {
                                        element: 'p',
                                        attributes: {
                                            innerHTML: `<div class="swal2-html-container" style="display: block;">Ticket has been returned successfully!!!</div>`
                                        }
                                    },
                                    icon:"success"
                                });
                            }
                        });
                    }, 1000);

                });

                $('.sell-confirm').on('click',function(e) {
                    showLoader()

                    setTimeout(function () {
                        var ticketForm = $('#ticketForm');
                        var ticketList = $(".selected-book-seats-item");
                        var maxNoSeatAllow = 5
                        if (ticketList.length < 1) {
                            swal("Seat No# Required!!!", "Please select seat first.", "error");
                            return false;

                        } else if (ticketList.length > maxNoSeatAllow) {
                            swal("Max Seats Selected!!!", `You Can Not Sell More than ${maxNoSeatAllow} Tickets at a Time.`, "error");
                            return false;
                        } else if (!$('#customer-phoneNumber').val()) {
                            swal("Mobile Number Required!!!", "Please Enter Mobile Number.", "error");
                            return false;

                        } else if (!$("#customer-name").val()) {
                            swal("Customer Name Required!!!", "Please Enter Customer Name.", "error");
                            return false;

                        } else if (!$("#fromStoppage").val()) {
                            swal("Destination Required!!!", "Please Select destination station (From).", "error");
                            return false;

                        } else if (!$("#toStoppage").val()) {
                            swal("Destination Required!!!", "Please Select destination station (To).", "error");
                            return false;

                        } else if ($("#fromStoppage").val() == $("#toStoppage").val()) {
                            swal("From and To Same!!!", "Please Select different destination station (From or To).", "error");
                            return false;
                        }else {
                            var isValidate = true;
                            ticketForm.validate();
                            isValidate = ticketForm.valid();
                            if (isValidate) {
                                Spiner.show();
                                var formData = serializeObject(ticketForm)
                                formData.paymentType =  "sell"
                                proceedSeatBooking(formData)
                            } else {
                                $.each(ticketForm.validate().errorList, function(key, value) {
                                    $errorSpan = $("span[data-valmsg-for='" + value.element.id + "']");
                                    $errorSpan.html(value.message);
                                    $errorSpan.show();
                                });
                                Spiner.hide();
                                swal({
                                    html: true,
                                    content: {
                                        element: 'p',
                                        attributes: {
                                            innerHTML: `<div class="swal2-html-container" style="display: block;">Form values are invalid!!!</div>`
                                        }
                                    },
                                    icon:"error"
                                });
                            }
                        }
                    }, 1000);



                });

                function proceedSeatBooking(formData){
                    $.ajax({
                        url: BSTS.baseURL + 'busTicketAdvance/checkSeatAvailability',
                        method: 'GET',
                        dataType: 'json',
                        async: false,
                        data: formData,
                        success: function (data) {
                            var isAvailable = data.isAvailableSeatToBook;
                            if(isAvailable){
                                saveBookingSeat(formData)
                            }else {
                                seatBookingStatusUpdate(formData)
                            }
                        }
                    });
                }

                function seatBookingStatusUpdate(formData){
                    $.ajax({
                        url: BSTS.baseURL + 'busTicketAdvance/bookingPanel',
                        method: 'GET',
                        dataType: 'html',
                        async: false,
                        data: {id: formData.busTicketId, date: formData.scheduledDate},
                        success: function (data) {
                            var bookingPanel = data;
                            $("#advance-ticket-book-ui-body").html(bookingPanel);
                            Spiner.hide();
                            swal({
                                html: true,
                                content: {
                                    element: 'p',
                                    attributes: {
                                        innerHTML: `<div class="swal2-html-container" style="display: block;">Selected seat(s) already booked!</div>`
                                    }
                                },
                                icon:"error"
                            });
                        }
                    });
                }

                function saveBookingSeat(formData){
                    console.log("selectedSeats");
                    $.ajax({
                        url: BSTS.baseURL + 'busTicketAdvance/saveBookingTicket',
                        method: 'GET',
                        dataType: 'html',
                        async: false,
                        data: formData,
                        success: function (data) {
                            var bookingPanel = data;
                            var selectedSeats = $(".seatCharts-seat.selected")
                            clearHoldingTicketsNow(selectedSeats);
                            $("#advance-ticket-book-ui-body").html(bookingPanel);
                            Spiner.hide();
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
                }

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

