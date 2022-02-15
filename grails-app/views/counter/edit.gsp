
<meta name="layout" content="main"/>

<div class="card">
    <div class="card-header">
        <g:message code="Counter" args="['Update']"/>
    </div>
    <div class="card-body">
        <g:form controller="counter" action="update">
            <g:hiddenField name="id" value="${counter.id}"/>
            <g:render template="form" model="[edit:'yes']"/>
            <div class="form-action-panel">
                <g:submitButton class="btn btn-primary" name="update" value="${g.message(code: "update")}"/>
                <g:link controller="member" action="index" class="btn btn-secondary"><g:message code="cancel"/></g:link>
            </div>
        </g:form>
    </div>
</div>
