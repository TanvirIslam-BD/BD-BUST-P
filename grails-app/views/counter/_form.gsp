<%@ page import="com.tanvir.bsts.Fares; com.tanvir.bsts.GlobalConfig" %>

<div class="form-group">
    <label><g:message code="name"/></label>
    <g:textField name="name" class="form-control" value="${counter?.name}" placeholder="Please Enter Counter Name"/>
</div>
<div class="form-group">
    <label>Sequence</label>
    <g:textField name="sequence" class="form-control" value="${counter?.sequence}" placeholder="Please Enter Counter Sequence"/>
</div>
<div class="form-group">
    <label>Type</label>
    <UIHelper:namedSelect class="form-control" name="type" key="${GlobalConfig.COUNTER_TYPE}" value="${counter?.type}"/>
</div>

<div class="form-group">
    <label>Status</label>
    <UIHelper:status value="${counter}"/>
</div>

<div class="form-group">
    <label>Routes</label>
    <UIHelper:domainSelect multiple="true" class="form-control" domain="${Fares}" name="fares" value="${counter?.fares ? counter?.fares?.id : null}"/>
</div>
