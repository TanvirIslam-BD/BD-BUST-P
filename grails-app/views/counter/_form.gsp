
<div class="form-group">
    <label><g:message code="name"/></label>
    <g:textField name="name" class="form-control" value="${counter?.name}" placeholder="Please Enter Counter Name"/>
</div>
<div class="form-group">
    <label>Sequence</label>
    <g:textField name="sequence" class="form-control" value="${counter?.sequence}" placeholder="Please Enter Counter Sequence"/>
</div>
<div class="form-group">
    <label>Status</label>
    <UIHelper:status value="${counter}"/>
</div>