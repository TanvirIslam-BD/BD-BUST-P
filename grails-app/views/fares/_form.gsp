<%@ page import="com.tanvir.bsts.Route; com.tanvir.bsts.City; com.tanvir.bsts.Counter; com.tanvir.bsts.SeatMap" %>

<div class="form-group">
    <label>Route</label>
    <UIHelper:domainSelect class="form-control" domain="${Route}" name="route" value="${fares?.route ? route?.route?.id : null}"/>
</div>

<div class="form-group">
    <label>District From</label>
    <UIHelper:domainSelect class="form-control" domain="${City}" name="districtFrom" value="${fares?.districtFrom ? route?.districtFrom?.id : null}"/>
</div>
<div class="form-group">
    <label>District To</label>
    <UIHelper:domainSelect class="form-control" domain="${City}" name="districtTo" value="${fares?.districtTo ? route?.districtTo?.id : null}"/>
</div>

<div class="form-group">
    <label>Start Stoppage</label>
    <UIHelper:domainSelect class="form-control" domain="${Counter}" name="fromStoppage" value="${fares?.fromStoppage ? route?.fromStoppage?.id : null}"/>
</div>

<div class="form-group">
    <label>End Stoppage</label>
    <UIHelper:domainSelect class="form-control" domain="${Counter}" name="toStoppage" value="${fares?.toStoppage ? route?.toStoppage?.id : null}"/>
</div>

<div class="form-group">
    <label>Status</label>
    <UIHelper:status value="${fares?.status}"/>
</div>

<div class="form-group">
    <label>Seat Class</label>
    <UIHelper:seatClass name="seatClass" value="${fares?.seatClass}"/>
</div>


<div class="form-group">
    <label>Fare Amount</label>
    <g:textField name="amount" class="form-control" value="${fares?.amount}" placeholder="Please Enter Fare Amount"/>
    <UIHelper:renderErrorMessage fieldName="amount" model="${fares}" errorMessage="please.enter.amount"/>
</div>
