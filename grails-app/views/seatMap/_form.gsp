<div class="form-group">
    <label><g:message code="rows"/> *</label>
    <g:select class="form-control" from="${2..26}" name="seatRows" value="${seatMap?.seatRows}"></g:select>
</div>

<div class="form-group">
    <label><g:message code="columns"/></label>
    <g:select class="form-control" from="${3..4}" name="seatColumns" value="${seatMap?.seatColumns}"></g:select>
</div>

<div class="form-group">
    <label><g:message code="name"/></label>
    <g:textField name="name" class="form-control" value="${seatMap?.name}" placeholder="Please Enter Columns"/>
</div>
