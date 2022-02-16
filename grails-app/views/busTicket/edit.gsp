
<meta name="layout" content="main"/>

<div class="card">
    <div class="card-header">
        <g:message code="Ticket" args="['Update']"/>
    </div>
    <div class="card-body">
        <g:form controller="busTicket" action="update">
            <g:hiddenField name="id" value="${busTicket.id}"/>
            <g:render template="form" model="[edit:'yes']"/>
            <div class="form-action-panel">
                <div class="form-group">
                    <g:submitButton class="btn bg-gradient-info pull-end" name="update" value="${g.message(code: "update")}"/>
                    <g:link controller="member" id="kanban-cancel-item" action="index" class="btn bg-gradient-light pull-end me-2"><g:message code="cancel"/></g:link>
                </div>
            </div>
        </g:form>
    </div>
</div>
