<%@ page import="com.tanvir.bsts.Coach; com.tanvir.bsts.Fares" %>

<div class="form-group">
    <label for="example-datetime-local-input" class="form-control-label">Date And Time</label>
    <input  name="boardingTimeAndDate" class="form-control" type="datetime-local" value="${busTicket?.boardingTimeAndDate}" id="example-datetime-local-input" onfocus="focused(this)">
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
