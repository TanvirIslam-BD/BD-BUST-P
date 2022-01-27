<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>
<div class="bus-system-list-view card">
    <div class="card-header">
        COACH
        <span class="float-right">
            <div class="btn-group">
                <g:form controller="coach" action="index" method="GET">
                    <div class="input-group" id="search-area">
                        <g:select name="colName" class="form-control" from="[name:'Name']" value="${params?.colName}" optionKey="key" optionValue="value"/>
                        <g:textField name="colValue" class="form-control" value="${params?.colValue}"/>
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="submit">Search</button>
                        </span>
                    </div>
                </g:form>
            </div>

            <div class="btn-group">
                <g:link controller="coach" action="create" class="btn btn-success"><g:message code="create"/></g:link>
                <g:link controller="coach" action="index" class="btn btn-primary"><g:message code="reload"/></g:link>
            </div>
        </span>
    </div>
    <div class="card-body">
        <table class="table table-bordered">
            <thead class="thead-dark">
            <tr>
                <th>COACH NUMBER</th>
                <th>REGISTRATION NUMBER</th>
                <th>SEAT CAPACITY</th>
                <th>SEAT PLAN</th>
                <th>STATUS</th>
                <th class="action-row"><g:message code="action"/></th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${contact}" var="info">
                <tr>
                    <td>${info?.coachNumber}</td>
                    <td>${info?.registrationNumber}</td>
                    <td>${info?.seatCapacity}</td>
                    <td>${info?.seatPlan}</td>
                    <td><span class="badge badge-success">${info?.status}</span></td>
                    <td>
                        <div class="btn-group">
                            <g:link controller="coach" action="edit" class="btn btn-secondary" id="${info.id}"><i class="fas fa-edit"></i></g:link>
                            <g:link controller="coach" action="delete" id="${info.id}" class="btn btn-secondary delete-confirmation"><i class="fas fa-trash"></i></g:link>
                        </div>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
        <div class="paginate">
            <g:paginate total="${total ?: 0}" />
        </div>
    </div>
</div>
</body>
</html>
