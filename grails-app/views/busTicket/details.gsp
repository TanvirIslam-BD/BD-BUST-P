%{--Include Main Layout--}%
<meta name="layout" content="main"/>
<asset:stylesheet src="jquery.seat-charts.css"/>
<asset:stylesheet src="booking.css"/>
<asset:stylesheet src="ticketBooking.css"/>

<asset:javascript src="ticketBooking.js"/>

<div class="card">
    <div class="card-header">
        Ticket Booking - ( ${busTicket.fares.fromStoppage.name} to ${busTicket.fares.toStoppage.name})
    </div>
    <div class="card-body">
        <div class="seat-plan-design">
            <g:if test="${busTicket.coach.seatMap}">
                <div class="booking-details">
                    <div id="legend"></div>
                </div>
                <div id="seat-map" class="seat-panel" price="${busTicket.fares.amount}" rows="${busTicket.coach.seatMap.seatRows}" columns="${busTicket.coach.seatMap.seatColumns}" >

                </div>
            </g:if>
        </div>
        <div class="seat-info-booking-info">
            <div class="seat-info">
                <h5>SEAT INFORMATION</h5>
                <table class="table information_table table-responsive">
                    <thead>
                    <tr class="border-0">
                        <td scope="col" class="text-center font_detail" style="width:24%">TOTAL SEATS(<span id="counter">0</span>)</td>
                        <td scope="col"  class="text-center font_detail" style="width:23%">TOTAL FARE</td>
                    </tr>
                    </thead>
                    <tbody class="table-striped border-1">
                    <tr>
                        <td class="border-1 text-center font_detail">
                             <span class="orange-bold-text" id="selected-seats"></span>
                        </td>
                        <td class="border-1 text-center font_detail">
                             <span id="total"  class="orange-bold-text"></span>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <h5>BOOKING INFORMATION</h5>
            <div class="booking-info">
                <div class="row">
                    <div class="col-sm-12 col-md-6 col-lg-6">
                        <table border="0">
                            <tbody class="dashboard_tble">
                            <tr>
                                <td>
                                    <p class="font_detail">Passenger
                                    Mobile</p>
                                </td>
                                <td>
                                    <div class="input-group form_width font_detail">
                                        <input type="text" class="form-control font_detail" aria-label="Passenger Mobile" aria-describedby="basic-addon1" wire:model.lazy="passenger_mobile">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p class="font_detail">Name</p>
                                </td>
                                <td>
                                    <input class="form-control form_width font_detail" type="text" wire:model.lazy="passenger_name">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p class="font_detail">Gender</p>
                                </td>
                                <td>
                                    <select class="form-select form-select-sm form_width font_detail" aria-label="example" wire:model="passenger_gender">
                                        <option selected="" value="">Select an
                                        option
                                        </option>
                                        <option value="Male">Male
                                        </option>
                                        <option value="Female">Female
                                        </option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p class="font_detail">Age</p>
                                </td>
                                <td>
                                    <input class="form-control form_width font_detail" type="text" wire:model.lazy="passenger_age">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p class="font_detail">Passport</p>
                                </td>
                                <td>
                                    <input class="form-control form_width font_detail" type="text" wire:model.lazy="passenger_passport">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p class="font_detail">Net pay</p>
                                </td>
                                <td>
                                    <input class="form-control form_width font_detail" disabled="" type="number" wire:model="net_pay">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p class="font_detail">Discount</p>
                                </td>
                                <td>
                                    <input class="form-control form_width font_detail" type="number" wire:model="total_discount">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p class="font_detail">Referenced Counter</p>
                                </td>
                                <td>
                                    <select class="form-select form-select-sm form_width font_detail" aria-label="example" wire:model="referenced_counter">
                                        <option value="">Select a Counter
                                        </option>
                                        <option value="31">
                                            Dhaka
                                        </option>
                                        <option value="32">
                                            Kamalapur counter (Dhaka)
                                        </option>
                                        <option value="33">
                                            Tikatuli (Dhaka)
                                        </option>
                                        <option value="34">
                                            Shanir akhra 1 (Dhaka)
                                        </option>
                                        <option value="35">
                                            Shanir akhra 2 (Dhaka)
                                        </option>
                                        <option value="36">
                                            Signboard 1 (Dhaka)
                                        </option>
                                        <option value="37">
                                            Signboard 2 (Dhaka)
                                        </option>
                                        <option value="38">
                                            Chittagong Road (Dhaka)
                                        </option>
                                        <option value="39">
                                            Kachpur (Dhaka)
                                        </option>
                                        <option value="40">
                                            Kachua
                                        </option>
                                        <option value="41">
                                            Hajiganj
                                        </option>
                                        <option value="42">
                                            Katakhali
                                        </option>
                                        <option value="43">
                                            Khalifar dorja
                                        </option>
                                        <option value="44">
                                            Sonapur
                                        </option>
                                        <option value="45">
                                            Ramganj
                                        </option>
                                        <option value="46">
                                            Paddar bazar
                                        </option>
                                        <option value="47">
                                            Panpara
                                        </option>
                                        <option value="48">
                                            Mirganj
                                        </option>
                                        <option value="49">
                                            Bangla bazar
                                        </option>
                                        <option value="50">
                                            Kalibazar
                                        </option>
                                        <option value="51">
                                            Palerhat
                                        </option>
                                        <option value="52">
                                            Bhuiyarhat
                                        </option>
                                        <option value="53">
                                            Bagbari
                                        </option>
                                        <option value="54">
                                            Laxmipur
                                        </option>
                                        <option value="55">
                                            Bashubazar
                                        </option>
                                        <option value="77">
                                            Mirpur
                                        </option>
                                        <option value="116">
                                            Fatehpur
                                        </option>
                                        <option value="337">
                                            Fakir bazar
                                        </option>
                                        <option value="339">
                                            Kachukhet
                                        </option>
                                        <option value="340">
                                            Mirpur 10
                                        </option>
                                        <option value="341">
                                            Mirpur 1
                                        </option>
                                        <option value="342">
                                            Adabor
                                        </option>
                                        <option value="343">
                                            Jigatola
                                        </option>
                                        <option value="344">
                                            Nilkhet
                                        </option>
                                        <option value="347">
                                            Sonargaon (Dhaka)
                                        </option>
                                        <option value="349">
                                            Laxmipur Station
                                        </option>
                                    </select>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                    </div>
                    <div class="col-sm-12 col-md-6 col-lg-6">
                        <table border="0" class="inner_dashboard_table">
                            <tbody class="dashboard_tble">
                            <tr>
                                <td>
                                    <p class="font_detail">Address</p>
                                </td>
                                <td>
                                    <input class="form-control form_width font_detail" type="text" wire:model.lazy="passenger_address">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p class="font_detail">
                                        Nationality</p>
                                </td>
                                <td>
                                    <input class="form-control form_width font_detail" type="text" wire:model.lazy="passenger_nationality">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p class="font_detail">Boarding
                                    Place</p>
                                </td>
                                <td>
                                    <input class="form-control form_width font_detail" type="text" wire:model.lazy="boarding_place">
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <p class="font_detail fw-bold">Total
                                    Paid</p>
                                </td>
                                <td>
                                    <input class="form-control form_width fw-bold font_detail" type="number" disabled="" wire:model.lazy="total_paid">
                                </td>
                            </tr>

                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-6 col-sm-6 col-md-12 col-lg-12 d-flex d-sm-flex justify-content-sm-end justify-content-end justify-content-md-center justify-content-lg-center">
                        <div class="form-action-panel">
                            <a href="/busTicket/index" class="btn btn-primary">Confirm</a>
                        </div>
                        <div class="form-action-panel">
                            <a href="/busTicket/index" class="btn btn-primary">Cancel</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <asset:javascript src="jquery.seat-charts.js"/>
</div>
