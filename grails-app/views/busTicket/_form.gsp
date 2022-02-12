<%@ page import="com.tanvir.bsts.Coach; com.tanvir.bsts.Fares" %>

<div class="form-group">
    <label>Date And Time</label>
    <div class='input-group date' id='datetimepicker1'>
        <input  name="boardingTimeAndDate" type='date' class="form-control" />
        <span class="input-group-addon">
            <span class="glyphicon glyphicon-calendar"></span>
        </span>
    </div>
</div>
<div class="form-group">
    <label>Fares</label>
    <UIHelper:domainSelect class="form-control" domain="${com.tanvir.bsts.Fares}" name="fares" value="${busTicket?.fares ? fares?.fares?.id : null}"/>
</div>

<div class="form-group">
    <label>Coach </label>
    <UIHelper:domainSelect class="form-control" domain="${com.tanvir.bsts.Coach}" name="coach" value="${busTicket?.coach ? fares?.coach?.id : null}"/>
</div>

<script type="text/javascript">
    $(function () {


    });
</script>
