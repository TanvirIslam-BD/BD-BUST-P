
<meta name="layout" content="main"/>

<div class="card">
    <div class="card-header">
        Seat Plan Update
    </div>
    <div class="card-body">
        <g:form controller="seatMap" action="update">
            <g:hiddenField name="id" value="${seatMap.id}"/>
            <g:render template="form" model="[edit:'yes']"/>
            <div class="form-action-panel">
                <g:submitButton class="btn btn-primary" name="update" value="${g.message(code: "update")}"/>
                <g:link controller="seatMap" action="index" class="btn btn-primary"><g:message code="cancel"/></g:link>
            </div>
        </g:form>
    </div>
</div>
