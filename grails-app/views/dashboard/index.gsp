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
                        <g:select name="colName" class="form-control" from="[coachNumber:'Coach Number', registrationNumber:'Registration Number', seatCapacity:'Seat Capacity']" value="${params?.colName}" optionKey="key" optionValue="value"/>
                        <g:textField name="colValue" class="form-control" value="${params?.colValue}"/>
                        <span class="input-group-btn">
                        <button type="submit" class="search-button btn btn-outline-secondary">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"></path>
                            </svg>
                        </button>

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
        <table class="table table-bordered table-striped">
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
            <g:if test="${coach}">
                <g:each in="${coach}" var="info">
                    <tr>
                        <td>${info?.coachNumber}</td>
                        <td>${info?.registrationNumber}</td>
                        <td>${info?.seatCapacity}</td>
                        <td>${info?.seatPlan}</td>
                        <td><span class="badge ${(info?.status == "ACTIVE") ?  "badge-success" :  "badge-secondary"}">${info?.status}</span></td>
                        <td>
                            <div class="btn-group">
                                <g:link controller="coach" action="edit" class="btn btn-secondary" id="${info.id}"><i class="fas fa-edit"></i></g:link>
                                <g:link controller="coach" action="delete" id="${info.id}" class="btn btn-secondary delete-confirmation"><i class="fas fa-trash"></i></g:link>
                            </div>
                        </td>
                    </tr>
                </g:each>
            </g:if>
            <g:else>
                <tr>
                    <td>No Coach Found!</td>
                </tr>
            </g:else>
            </tbody>
        </table>
        <div class="paginate">
            <g:paginate total="${total ?: 0}" />
        </div>
    </div>
  </div>
</body>
</html>
