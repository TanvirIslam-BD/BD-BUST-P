<div class="form-group">
    <label><g:message code="rows"/> *</label>
    <g:textField name="rows" class="form-control" value="${seatMap?.rows}" placeholder="Please Enter Rows"/>
    <UIHelper:renderErrorMessage fieldName="rows" model="${seatMap?.rows}" errorMessage="Please Enter Rows"/>
</div>

<div class="form-group">
    <label><g:message code="columns"/></label>
    <g:textField name="columns" class="form-control" value="${seatMap?.columns}" placeholder="Please Enter Columns"/>
</div>

<div class="form-group">
    <label><g:message code="name"/></label>
    <g:textField name="name" class="form-control" value="${seatMap?.name}" placeholder="Please Enter Columns"/>
</div>
