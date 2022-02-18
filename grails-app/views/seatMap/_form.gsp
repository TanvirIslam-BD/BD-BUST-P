<div class="form-group">
    <label><g:message code="Name"/></label>
    <g:textField name="name" class="form-control" value="${seatMap?.name}" placeholder="Example: 52 seats"/>
</div>

<div class="form-group">
    <label><g:message code="Columns"/></label>
    <g:select class="form-control" from="${3..4}" name="seatColumns" value="${seatMap?.seatColumns}"></g:select>
</div>

<div class="form-group">
    <label><g:message code="Rows"/> *</label>
    <g:select class="form-control" from="${2..26}" name="seatRows" value="${seatMap?.seatRows}"></g:select>
</div>

<div class="form-group">
    <div class="form-check form-switch ps-0">
        <input uncheck-value="false" value="true" class="form-check-input ms-auto" name="extraSeatInLastRow" type="checkbox" id="extraSeatInLastRow" ${seatMap?.extraSeatInLastRow ? "checked" : ""}>
        <label class="form-check-label text-body ms-3 text-truncate w-80 mb-0" for="extraSeatInLastRow">Extra Seat in Last Row</label>
    </div>
</div>


