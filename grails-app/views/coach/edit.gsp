<meta name="layout" content="main"/>
<div class="card">
    <div class="card-header">
        <g:message code="coach" args="['Update']"/>
    </div>
    <div class="card-body">
        <g:form controller="coach" action="update" enctype="multipart/form-data">
            <g:hiddenField name="id" value="${coach.id}"/>
            <g:render template="form"/>
            <div class="form-action-panel">
                <g:submitButton class="btn btn-primary" name="login" value="${g.message(code: "update")}"/>
                <g:link controller="coach" action="index" class="btn btn-primary"><g:message code="cancel"/></g:link>
            </div>
        </g:form>
    </div>
</div>