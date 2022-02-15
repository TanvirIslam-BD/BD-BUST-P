<meta name="layout" content="main"/>
<div class="card">
    <div class="card-header">
        Add Fares
    </div>
    <div class="card-body">
        <g:form controller="fares" action="save" enctype="multipart/form-data">
            <g:render template="form"/>
            <div class="form-action-panel">
                <g:submitButton class="btn btn-primary" name="login" value="ADD FARE"/>
                <g:link controller="coach" action="index" class="btn btn-secondary"><g:message code="cancel"/></g:link>
            </div>
        </g:form>
    </div>
</div>
