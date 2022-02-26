<%@ page import="com.tanvir.bsts.Coach; com.tanvir.bsts.Route" %>

<div class="form-group">
    <label for="example-datetime-local-input" class="form-control-label">Date And Time</label>
    <input name="boardingDate" class="form-control" type="date" value="${busTicket?.boardingDate}" id="example-datetime-local-input" onfocus="focused(this)">
</div>
<div class="form-group">
    <label for="example-time-input" class="form-control-label">Boarding Time</label>
    <input name="boardingTime" class="form-control" type="time" value="10:30:00" id="example-time-input" onfocus="focused(this)">
</div>
<div class="form-group">
    <label>Fares</label>
    <UIHelper:domainSelect class="form-control" domain="${Route}" name="fares" value="${busTicket?.fares ? fares?.fares?.id : null}"/>
</div>

<div class="form-group">
    <label>Coach </label>
    <UIHelper:domainSelect class="form-control" domain="${Coach}" name="coach" value="${busTicket?.coach ? fares?.coach?.id : null}"/>
</div>

<script type="text/javascript">
    $(function () {


    });
</script>
