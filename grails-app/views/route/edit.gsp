<meta name="layout" content="main"/>
<div class="card">
    <div class="card-header">
        Update Routes
    </div>
    <div class="card-body">
        <g:form controller="route" action="update" enctype="multipart/form-data">
            <g:hiddenField name="id" value="${route.id}"/>
            <g:render template="form"/>
            <div class="form-action-panel">
                <g:submitButton class="btn bg-gradient-info pull-end" name="update" value="${g.message(code: "update")}"/>
                <g:link controller="route" id="kanban-cancel-item" action="index" class="btn bg-gradient-light pull-end me-2"><g:message code="cancel"/></g:link>
            </div>
        </g:form>
    </div>
</div>
