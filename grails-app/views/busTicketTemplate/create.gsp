<meta name="layout" content="main"/>

<div class="card">
    <div class="card-header">
         Ticket Template Create
    </div>
    <div class="card-body">
        <g:form controller="busTicketTemplate" action="save">
            <g:render template="form"/>
            <div class="form-action-panel">
               <div class="form-group col-md">
                    <g:submitButton class="btn bg-gradient-success pull-end" name="save" value="${g.message(code: "Add")}"/>
                    <g:link controller="busTicketTemplate" id="kanban-cancel-item" action="index" class="btn bg-gradient-light pull-end me-2"><g:message code="cancel"/></g:link>
                </div>
            </div>
        </g:form>
    </div>
</div>
