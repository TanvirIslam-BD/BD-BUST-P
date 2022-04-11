<%@ page import="com.tanvir.bsts.Route; com.tanvir.bsts.City; com.tanvir.bsts.Counter; com.tanvir.bsts.SeatMap" %>

<g:set var="route" value="${fares?.route}"/>
<div class="row">
 <div class="col-md-6">
        <div class="form-group">
            <label>Route</label>
            <UIHelper:domainSelect class="form-control" domain="${Route}" name="route" value="${route?.id}"/>
        </div>
        <div class="form-group">
            <label>District From</label>
            <UIHelper:domainSelect class="form-control" domain="${City}" name="districtFrom" value="${route?.districtFrom?.id}"/>
        </div>
        <div class="form-group">
            <label>District To</label>
            <UIHelper:domainSelect class="form-control" domain="${City}" name="districtTo" value="${route?.districtTo?.id}"/>
        </div>
        <div class="form-group">
            <label>Start Stoppage</label>
            <UIHelper:domainSelect class="form-control" domain="${Counter}" name="fromStoppage" value="${route?.fromStoppage?.id}"/>
        </div>
        <div class="form-group">
            <label>End Stoppage</label>
            <UIHelper:domainSelect class="form-control" domain="${Counter}" name="toStoppage" value="${route?.toStoppage?.id}"/>
        </div>
 </div>

  <div class="col-md-6">
        <div class="form-group">
          <label>Status</label>
          <UIHelper:status value="${fares?.status}"/>
      </div>
        <div class="form-group">
            <label>Seat Class</label>
            <UIHelper:seatClass name="seatClass" value="${fares?.seatClass}"/>
        </div>
        <div class="form-group">
            <label class="required">Fare</label>
            <g:textField name="amount" class="form-control" value="${fares?.amount}" placeholder="Please Enter Fare Amount"/>
            <UIHelper:renderErrorMessage fieldName="amount" model="${fares}" errorMessage="please.enter.amount"/>
        </div>
        <div class="form-group">
            <label class="required">Festival Fare</label>
            <input class="form-control" data-val-number="The field Festival Fare must be a number."
                   data-val-required="The Festival Fare field is required." name="festivalFare" type="text" value="${fares?.festivalFare}">
        </div>
        <div class="form-group">
            <label class="required">Commission Amount</label>
            <input class="form-control" data-val-number="The field Commission Amount must be a number."
                   data-val-required="The Commission Amount field is required." name="commissionAmount" type="text" value="${fares?.commissionAmount}">
        </div>
  </div>

</div>
