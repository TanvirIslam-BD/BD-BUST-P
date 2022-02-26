<%@ page import="com.tanvir.bsts.Counter; com.tanvir.bsts.GlobalConfig" %>
<div class="form-group">
    <label><g:message code="first.name"/> *</label>
    <g:textField name="firstName" class="form-control" value="${member?.firstName}" placeholder="Please Enter First Name"/>
    <UIHelper:renderErrorMessage fieldName="firstName" model="${member}" errorMessage="please.enter.first.name"/>
</div>

<div class="form-group">
    <label><g:message code="last.name"/></label>
    <g:textField name="lastName" class="form-control" value="${member?.lastName}" placeholder="Please Last Name"/>
</div>

<div class="form-group">
    <label><g:message code="mobile"/></label>
    <g:textField name="mobile" class="form-control" value="${member?.mobile}" placeholder="Please  Mobile"/>
    <UIHelper:renderErrorMessage fieldName="firstName" model="${member}" errorMessage="please.enter.mobile"/>
</div>

<div class="form-group">
    <label><g:message code="address"/></label>
    <g:textField name="address" class="form-control" value="${member?.address}" placeholder="Please Address"/>
</div>

<div class="form-group">
    <label><g:message code="email.address"/> *</label>
    <g:field type="email" name="email" class="form-control" value="${member?.email}" placeholder="Please Enter Email"/>
    <UIHelper:renderErrorMessage fieldName="email" model="${member}" errorMessage="Your Email Address is not Valid / Already Exist in System"/>
</div>

<div class="form-group">
    <label>Role</label>
    <UIHelper:namedSelect class="form-control" name="memberType" key="${GlobalConfig.USER_TYPE}" value="${member?.memberType}"/>
</div>

<div class="form-group">
    <label class="required">Counter</label>
    <UIHelper:domainSelect class="form-control" domain="${Counter}" name="counter" value="${member?.counter?.id}"/>
</div>

<g:if test="${!edit}">
    <div class="form-group">
        <label><g:message code="password"/> *</label>
        <g:passwordField name="password" class="form-control" value="${member?.password}" placeholder="Please Enter Password"/>
        <UIHelper:renderErrorMessage fieldName="password" model="${member}" errorMessage="Please Enter a Password."/>
    </div>
</g:if>
