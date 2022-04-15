<%@ page import="com.tanvir.bsts.SeatMap; com.tanvir.bsts.Coach; com.tanvir.bsts.Route" %>

<div class="row">
    <div class="col-md-6">
        <div class="form-group col-md">
            <label for="example-time-input" class="form-control-label">Boarding Time</label>
            <input name="boardingTime" class="form-control" type="time" value="${busTicketTemplate?.boardingTime}" id="example-time-input" onfocus="focused(this)">
        </div>
        <div class="form-group col-md">
            <label>Trip#</label>
            <input name="tripNo" class="form-control"  data-val="true" data-val-length="Trip# can only between 1 to 128 characters."
                   data-val-length-max="128" data-val-length-min="1" data-val-required="'Trip#' is a required field. Please enter the 'Trip#'."
                   maxlength="128" type="text" value="${busTicketTemplate?.tripNo}" id="trip-no-input" onfocus="focused(this)">
        </div>
        <div class="form-group col-md">
            <label class="required">Flat Fare</label>
            <g:textField name="flatFare" class="form-control" value="${busTicketTemplate?.flatFare}" placeholder="Please Enter Fare Amount"/>
            <UIHelper:renderErrorMessage fieldName="flatFare" model="${busTicketTemplate}" errorMessage="please.enter.amount"/>
        </div>
        <div class="form-group col-md">
            <label>Routes</label>
            <UIHelper:domainSelect class="form-control" domain="${Route}" name="route" value="${busTicketTemplate?.route ? busTicketTemplate?.route?.id : null}"/>
        </div>
        <div class="form-group col-md">
            <label>Seat Type</label>
            <UIHelper:domainSelect class="form-control" domain="${SeatMap}" name="seatMap" value="${busTicketTemplate ? busTicketTemplate?.seatMap?.id : null}"/>
            <UIHelper:renderErrorMessage fieldName="seatMap" model="${busTicketTemplate}" errorMessage="Seat Type"/>
        </div>

    </div>
    <div class="col-md-6">
        <div class="form-group col-md">
            <label>Coach </label>
            <UIHelper:domainSelect class="form-control" domain="${Coach}" name="coach" value="${busTicketTemplate?.coach ? busTicketTemplate?.coach?.id : null}"/>
        </div>
        <div class="form-group col-md">
            <label>Coach Type</label>
            <UIHelper:seatClass name="seatClass" value="${busTicketTemplate?.seatClass}"/>
        </div>
        <div class="form-group">
            <label class="control-label col-md" for="ScheduleStartDateStr">Start Date</label>
            <div class="col-md">
                <div class="input-group dp " id="dtp_ScheduleStartDateStr">
                    <input class="form-control readonly" id="ScheduleStartDateStr" name="scheduleStartDateStr" type="text" value="${busTicketTemplate?.scheduleStartDateStr}">
                    <span class="input-group-addon"><span class="fa fa-calendar"></span></span></div>
                <span class="text-danger field-validation-valid" data-valmsg-for="ScheduleStartDateStr" data-valmsg-replace="true"></span>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md" for="ScheduleEndDateStr">End Date</label>
            <div class="col-md">
                <div class="input-group dp " id="dtp_ScheduleEndDateStr"> <input class="form-control readonly" id="ScheduleEndDateStr" name="scheduleEndDateStr" type="text" value="${busTicketTemplate?.scheduleEndDateStr}"> <span class="input-group-addon"><span class="fa fa-calendar"></span></span></div>
                <span class="text-danger field-validation-valid" data-valmsg-for="ScheduleEndDateStr" data-valmsg-replace="true"></span>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-5 required">Online Sale?</label>
            <div class="col-md-7">
                <div class="">
                    <label class="control-label" id="label_isOnlineSale_True">
                        <input data-val="true" data-val-required="The Online Sale? field is required." id="isOnlineSale_True" name="isOnlineSale" type="radio" value="true">
                        <span class="radio-text">Yes</span>
                    </label>
                    <label class="control-label" id="label_isOnlineSale_False">
                        <input checked="checked" id="isOnlineSale_False" name="isOnlineSale" type="radio" value="false">
                        <span class="radio-text">No</span>
                    </label>
                </div>
                <span class="text-danger field-validation-valid" data-valmsg-for="isOnlineSale" data-valmsg-replace="true"></span>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="form-group has-success">
            <label class="control-label col-md-2">SCHEDULE TIME SETUP</label>
            <div class="col-md-10" id="scheduleDetailGrid">
                <div class="table-responsive">
                    <table id="scheduleDetailTable" class="table table-default table-hover">
                        <thead>
                        <tr>
                            <th>SL#</th>
                            <th>
                                <label class="control-label">SCHEDULE</label>
                            </th>
                            <th>
                                <label class="control-label">START TIME</label>
                            </th>
                        </tr>

                        </thead>
                        <tbody>

                        <g:each in="${countersFrom}" var="counterFrom">
                            <g:if test="${counterFrom?.id}">
                                <tr>
                                    <td style="text-align: center"> ${counterFrom.id} </td>
                                    <td style="text-align: center; min-width: 130px">
                                        <input class="form-control disabled text-box single-line" id="counter" name="scheduleName" type="text" value="${counterFrom?.name}-${busTicketTemplate?.route?.districtTo?.name}">
                                        <input name="counter" type="hidden" value="${counterFrom?.id}">
                                    </td>
                                    <td style="text-align: center; min-width: 130px">
                                        <div class="input-group date tp dtpReportingTime">
                                            <input class="form-control valid" id="startTime" name="startTime" type="time" value="${UIHelper.getTicketCounterStartTime(ticketId: busTicketTemplate?.id, counterId: counterFrom?.id)}" aria-invalid="false">
                                        </div>
                                    </td>
                                </tr>
                            </g:if>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">



</script>
