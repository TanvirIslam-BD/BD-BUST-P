<%@ page import="com.tanvir.bsts.SeatMap" %>
<div class="form-group">
    <coachNumber>Coach No. *</coachNumber>
    <g:textField name="coachNumber" class="form-control" value="${coach?.coachNumber}" placeholder="Please Enter Coach No."/>
    <UIHelper:renderErrorMessage fieldName="coachNumber" model="${coach}" errorMessage="please.enter.name"/>
</div>

<div class="form-group">
    <label>Registration No. *</label>
    <g:textField name="registrationNumber" class="form-control" value="${coach?.registrationNumber}" placeholder="Please Enter Registration No."/>
    <UIHelper:renderErrorMessage fieldName="registrationNumber" model="${coach}" errorMessage="please.enter.name"/>
</div>

<div class="form-group">
    <label>Seat Plan</label>
    <UIHelper:domainSelect  class="form-control" domain="${SeatMap}" name="seatMap" value="${coach ? coach?.seatMap?.id : null}"/>
    <UIHelper:renderErrorMessage fieldName="name" model="${coach}" errorMessage="Seat Capacity"/>
</div>

<div class="form-group">
    <label>Seat Capacity</label>
    <g:textField name="seatCapacity" class="form-control" value="${coach?.seatCapacity}" placeholder="Please Enter Seat Capacity"/>
    <UIHelper:renderErrorMessage fieldName="seatCapacity" model="${coach}" errorMessage="please.enter.name"/>
</div>

<div class="form-group">
    <label>Status</label>
    <UIHelper:status value="${coach}"/>
    <UIHelper:renderErrorMessage fieldName="status" model="${coach}" errorMessage="please.enter.name"/>
</div>


