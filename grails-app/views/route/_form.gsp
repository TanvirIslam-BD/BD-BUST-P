<%@ page import="com.tanvir.bsts.City; com.tanvir.bsts.Counter; com.tanvir.bsts.SeatMap" %>

<div class="form-group">
    <label>Name</label>
    <g:textField name="name" class="form-control" value="${route?.name}" placeholder="Please Enter Routes Name"/>
</div>

<div class="form-group">
    <label>District From</label>
    <UIHelper:domainSelect class="form-control" domain="${City}" name="districtFrom" value="${route?.districtFrom ? route?.districtFrom?.id : null}"/>
</div>

<div class="form-group">
    <label>Start Stoppage</label>
    <UIHelper:domainSelect class="form-control" domain="${Counter}" name="fromStoppage" value="${route?.fromStoppage ? route?.fromStoppage?.id : null}"/>
</div>

<div class="form-group">
    <label>District To</label>
    <UIHelper:domainSelect class="form-control" domain="${City}" name="districtTo" value="${route?.districtTo ? route?.districtTo?.id : null}"/>
</div>
<div class="form-group">
    <label>End Stoppage</label>
    <UIHelper:domainSelect class="form-control" domain="${Counter}" name="toStoppage" value="${route?.toStoppage ? route?.toStoppage?.id : null}"/>
</div>

<div class="form-group">
    <label>Status</label>
    <UIHelper:status value="${route?.status}"/>
</div>
