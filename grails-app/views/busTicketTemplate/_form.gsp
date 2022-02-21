<%@ page import="com.tanvir.bsts.Coach; com.tanvir.bsts.Fares" %>

<div class="form-group">
    <label for="example-time-input" class="form-control-label">Boarding Time</label>
    <input name="boardingTime" class="form-control" type="time" value="${busTicketTemplate?.boardingTime}" id="example-time-input" onfocus="focused(this)">
</div>
<div class="form-group">
    <label>Routes</label>
    <UIHelper:domainSelect class="form-control" domain="${Fares}" name="fares" value="${busTicketTemplate?.fares ? busTicketTemplate?.fares?.id : null}"/>
</div>

<div class="form-group">
    <label>Coach </label>
    <UIHelper:domainSelect class="form-control" domain="${Coach}" name="coach" value="${busTicketTemplate?.coach ? busTicketTemplate?.coach?.id : null}"/>
</div>

<script type="text/javascript">
    $(function () {


    });
</script>
