
<meta name="layout" content="main"/>

<div class="card">
    <div class="card-header">Ticket Template Update</div>
    <div class="card-body">
        <g:form controller="busTicketTemplate" action="update">
            <g:hiddenField name="id" value="${busTicketTemplate.id}"/>
            <g:render template="form" model="[edit:'yes']"/>
            <div class="form-action-panel">
                <div class="form-group col-md">
                    <g:submitButton class="btn bg-gradient-info pull-end" name="update" value="${g.message(code: "update")}"/>
                    <g:link controller="busTicketTemplate" id="kanban-cancel-item" action="index" class="btn bg-gradient-light pull-end me-2"><g:message code="cancel"/></g:link>
                </div>
            </div>
        </g:form>
    </div>
</div>
