<meta name="layout" content="main"/>

<div class="card">
    <div class="card-header">
        <g:message code="Ticket" args="['Create']"/>
    </div>
    <div class="card-body">
        <g:form controller="busTicket" action="save">
            <g:render template="form"/>
            <div class="form-action-panel">
                <g:submitButton class="btn btn-primary" name="save" value="${g.message(code: "save")}"/>
                <g:link controller="member" action="index" class="btn btn-secondary"><g:message code="cancel"/></g:link>
            </div>
        </g:form>
    </div>
</div>
