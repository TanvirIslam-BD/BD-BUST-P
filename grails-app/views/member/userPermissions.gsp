
<div class="modal-header">
    <h5 class="modal-title" id="myModalLabel">
        <span class="col-md-10">
           Add User Permission - ${userName}
        </span>
    </h5>
    <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close"></button>
</div>
<div class="modal-body" modal-type="normal">
   <g:form controller="member" action="saveUserPermission" method="post" role="form" data-modalprefix="my" class="form-horizontal user-access-form" >
        <input name="page" id="page" type="hidden" value="1">
        <input id="userId" name="userId" type="hidden" value="${userId}">

        <div class="table-responsive add-user-permission-wrapper">
            <table id="trainingTable" class="table table-default table-hover">
                <thead>
                <tr>
                    <th>
                        <label class="control-label required" >Key</label>
                    </th>
                    <th>
                        <label class="control-label required">Value</label>
                    </th>

                </tr>
                </thead>
                <tbody>
%{--                <tr>--}%
%{--                    <td>Sale Other Counter Ticket Permission</td>--}%
%{--                    <td>--}%
%{--                        <div>--}%
%{--                            <g:set var="saleOtherCounterTicketPermission" value="${UIHelper.getUserPermissionStatus(permissionKey: "saleOtherCounterTicketPermission", userId: userId)}"/>--}%
%{--                            <label class="control-label">--}%
%{--                                <input ${saleOtherCounterTicketPermission == "true" ? 'checked="checked"' : ''}  data-val="true" data-val-required="The Value field is required." name="permission.saleOtherCounterTicketPermission" type="radio" value="true">--}%
%{--                                <span class="radio-text">Yes</span>--}%
%{--                            </label>--}%
%{--                            <label class="control-label">--}%
%{--                                <input ${saleOtherCounterTicketPermission == "false" ? 'checked="checked"' : ''} name="permission.saleOtherCounterTicketPermission" type="radio" value="false">--}%
%{--                                <span class="radio-text">No</span>--}%
%{--                            </label>--}%
%{--                        </div>--}%
%{--                    </td>--}%
%{--                </tr>--}%
                <tr>
                    <td>Ticket Booking Permission</td>
                    <td>
                        <div>
                            <g:set var="tickerBookingPermission" value="${UIHelper.getUserPermissionStatus(permissionKey: "tickerBookingPermission", userId: userId)}"/>
                            <label class="control-label">
                                <input data-val="true"${tickerBookingPermission == "true" ? 'checked="checked"' : ''}  data-val-required="The Value field is required." name="permission.tickerBookingPermission" type="radio" value="true">
                                <span class="radio-text">Yes</span>
                            </label>
                            <label class="control-label">
                                <input ${tickerBookingPermission == "false" ? 'checked="checked"' : ''} name="permission.tickerBookingPermission" type="radio" value="false">
                                <span class="radio-text">No</span>
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Ticket Return Permission</td>
                    <td>
                        <div>
                            <g:set var="ticketReturnPermission" value="${UIHelper.getUserPermissionStatus(permissionKey: "ticketReturnPermission", userId: userId)}"/>
                            <label class="control-label">
                                <input ${ticketReturnPermission == "true" ? 'checked="checked"' : ''} data-val="true" data-val-required="The Value field is required." name="permission.ticketReturnPermission" type="radio" value="true">
                                <span class="radio-text">Yes</span>
                            </label>
                            <label class="control-label">
                                <input  ${ticketReturnPermission == "false" ? 'checked="checked"' : ''}  name="permission.ticketReturnPermission" type="radio" value="false">
                                <span class="radio-text">No</span>
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Ticket Report View Permission</td>
                    <td>
                        <div>
                            <g:set var="ticketReportViewPermission" value="${UIHelper.getUserPermissionStatus(permissionKey: "ticketReportViewPermission", userId: userId)}"/>
                            <label class="control-label">
                                <input ${ticketReportViewPermission == "true" ? 'checked="checked"' : ''} data-val="true" data-val-required="The Value field is required." name="permission.ticketReportViewPermission" type="radio" value="true">
                                <span class="radio-text">Yes</span>
                            </label>
                            <label class="control-label">
                                <input  ${ticketReportViewPermission == "false" ? 'checked="checked"' : ''}  name="permission.ticketReportViewPermission" type="radio" value="false">
                                <span class="radio-text">No</span>
                            </label>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>Ticket Schedule View Permission</td>
                    <td>
                        <div>
                            <g:set var="ticketScheduleViewPermission" value="${UIHelper.getUserPermissionStatus(permissionKey: "ticketScheduleViewPermission", userId: userId)}"/>
                            <label class="control-label">
                                <input ${ticketScheduleViewPermission == "true" ? 'checked="checked"' : ''} data-val="true" data-val-required="The Value field is required." name="permission.ticketScheduleViewPermission" type="radio" value="true">
                                <span class="radio-text">Yes</span>
                            </label>
                            <label class="control-label">
                                <input  ${ticketScheduleViewPermission == "false" ? 'checked="checked"' : ''}  name="permission.ticketScheduleViewPermission" type="radio" value="false">
                                <span class="radio-text">No</span>
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Ticket Fares View Permission</td>
                    <td>
                        <div>
                            <g:set var="ticketFaresViewPermission" value="${UIHelper.getUserPermissionStatus(permissionKey: "ticketFaresViewPermission", userId: userId)}"/>
                            <label class="control-label">
                                <input ${ticketFaresViewPermission == "true" ? 'checked="checked"' : ''} data-val="true" data-val-required="The Value field is required." name="permission.ticketFaresViewPermission" type="radio" value="true">
                                <span class="radio-text">Yes</span>
                            </label>
                            <label class="control-label">
                                <input  ${ticketFaresViewPermission == "false" ? 'checked="checked"' : ''}  name="permission.ticketFaresViewPermission" type="radio" value="false">
                                <span class="radio-text">No</span>
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Coach View Permission</td>
                    <td>
                        <div>
                            <g:set var="coachViewPermission" value="${UIHelper.getUserPermissionStatus(permissionKey: "coachViewPermission", userId: userId)}"/>
                            <label class="control-label">
                                <input ${coachViewPermission == "true" ? 'checked="checked"' : ''} data-val="true" data-val-required="The Value field is required." name="permission.coachViewPermission" type="radio" value="true">
                                <span class="radio-text">Yes</span>
                            </label>
                            <label class="control-label">
                                <input  ${coachViewPermission == "false" ? 'checked="checked"' : ''}  name="permission.coachViewPermission" type="radio" value="false">
                                <span class="radio-text">No</span>
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Seat Map View Permission</td>
                    <td>
                        <div>
                            <g:set var="seatMapViewPermission" value="${UIHelper.getUserPermissionStatus(permissionKey: "seatMapViewPermission", userId: userId)}"/>
                            <label class="control-label">
                                <input ${seatMapViewPermission == "true" ? 'checked="checked"' : ''} data-val="true" data-val-required="The Value field is required." name="permission.seatMapViewPermission" type="radio" value="true">
                                <span class="radio-text">Yes</span>
                            </label>
                            <label class="control-label">
                                <input  ${seatMapViewPermission == "false" ? 'checked="checked"' : ''}  name="permission.seatMapViewPermission" type="radio" value="false">
                                <span class="radio-text">No</span>
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Routes View Permission</td>
                    <td>
                        <div>
                            <g:set var="routesViewPermission" value="${UIHelper.getUserPermissionStatus(permissionKey: "routesViewPermission", userId: userId)}"/>
                            <label class="control-label">
                                <input ${routesViewPermission == "true" ? 'checked="checked"' : ''} data-val="true" data-val-required="The Value field is required." name="permission.routesViewPermission" type="radio" value="true">
                                <span class="radio-text">Yes</span>
                            </label>
                            <label class="control-label">
                                <input  ${routesViewPermission == "false" ? 'checked="checked"' : ''}  name="permission.routesViewPermission" type="radio" value="false">
                                <span class="radio-text">No</span>
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Counters View Permission</td>
                    <td>
                        <div>
                            <g:set var="countersViewPermission" value="${UIHelper.getUserPermissionStatus(permissionKey: "countersViewPermission", userId: userId)}"/>
                            <label class="control-label">
                                <input ${countersViewPermission == "true" ? 'checked="checked"' : ''} data-val="true" data-val-required="The Value field is required." name="permission.countersViewPermission" type="radio" value="true">
                                <span class="radio-text">Yes</span>
                            </label>
                            <label class="control-label">
                                <input  ${countersViewPermission == "false" ? 'checked="checked"' : ''}  name="permission.countersViewPermission" type="radio" value="false">
                                <span class="radio-text">No</span>
                            </label>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
   </g:form>

    <div class="modal-footer">
        <div id="saveBtnModalContainer">
            <button type="button" class="btn btn-dropbox" id="btnCommonModalSave" onclick="saveRecord(this, 'user-access-form');">Save</button>
            <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">Close</button>
        </div>
    </div>

</div>
<script>
    $("#saveBtnContainer").hide();
</script>
