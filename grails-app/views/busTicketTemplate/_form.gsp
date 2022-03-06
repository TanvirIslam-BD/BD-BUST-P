<%@ page import="com.tanvir.bsts.Coach; com.tanvir.bsts.Route" %>

<div class="form-group col-md">
    <label for="example-time-input" class="form-control-label">Boarding Time</label>
    <input name="boardingTime" class="form-control" type="time" value="${busTicketTemplate?.boardingTime}" id="example-time-input" onfocus="focused(this)">
</div>
<div class="form-group col-md">
    <label>Routes</label>
    <UIHelper:domainSelect class="form-control" domain="${Route}" name="route" value="${busTicketTemplate?.route ? busTicketTemplate?.route?.id : null}"/>
</div>

<div class="form-group col-md">
    <label>Coach </label>
    <UIHelper:domainSelect class="form-control" domain="${Coach}" name="coach" value="${busTicketTemplate?.coach ? busTicketTemplate?.coach?.id : null}"/>
</div>

<div class="form-group">
    <label class="control-label col-md" for="ScheduleStartDateStr">Start Date</label>
    <div class="col-md">
        <div class="input-group dp " id="dtp_ScheduleStartDateStr"> <input class="form-control readonly" id="ScheduleStartDateStr" name="scheduleStartDateStr" type="text" value="${busTicketTemplate?.scheduleStartDateStr}"> <span class="input-group-addon"><span class="fa fa-calendar"></span></span></div>
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



<script type="text/javascript">
    $(function () {


    });
</script>
