<meta name="layout" content="main"/>
<div class="card">
    <div class="card-header">
        Vehicles Create
    </div>
    <div class="card-body">
        <g:form controller="coach" action="save" enctype="multipart/form-data">
            <g:render template="form"/>
            <div class="form-action-panel">
                <g:submitButton class="btn btn-primary" name="login" value="ADD VEHICLE"/>
                <g:link controller="coach" action="index" class="btn btn-primary"><g:message code="cancel"/></g:link>
            </div>
        </g:form>
    </div>
</div>