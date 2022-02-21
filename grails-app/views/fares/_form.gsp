<%@ page import="com.tanvir.bsts.Counter; com.tanvir.bsts.SeatMap" %>

<div class="form-group">
    <label>Name</label>
    <g:textField name="name" class="form-control" value="${fares?.name}" placeholder="Please Enter Routes Name"/>
</div>
<div class="form-group">
    <label>From Stoppage</label>
    <UIHelper:domainSelect class="form-control" domain="${Counter}" name="fromStoppage" value="${fares?.fromStoppage ? fares?.fromStoppage?.id : null}"/>
</div>

<div class="form-group">
    <label>To Stoppage </label>
    <UIHelper:domainSelect class="form-control" domain="${Counter}" name="toStoppage" value="${fares?.toStoppage ? fares?.toStoppage?.id : null}"/>
</div>

<div class="form-group">
    <label>Seat Class</label>
    <UIHelper:seatClass name="seatClass" value="${fares?.seatClass}"/>
</div>

<div class="form-group">
    <label>Status</label>
    <UIHelper:status value="${fares?.status}"/>
</div>

<div class="form-group">
    <label>Fare Amount</label>
    <g:textField name="amount" class="form-control" value="${fares?.amount}" placeholder="Please Enter Fare Amount"/>
    <UIHelper:renderErrorMessage fieldName="amount" model="${fares}" errorMessage="please.enter.amount"/>
</div>
