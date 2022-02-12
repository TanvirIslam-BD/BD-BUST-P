<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>
<div class="bus-system-list-view card">
    <div class="card-header">
        Fares
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
                <g:link controller="fares" action="create" class="btn btn-success"><g:message code="create"/></g:link>
                <g:link controller="fares" action="index" class="btn btn-primary"><g:message code="reload"/></g:link>
            </div>
        </span>
    </div>
    <div class="card-body">
        <table class="table table-bordered table-striped">
            <thead class="thead-dark">
            <tr>
                <th>FROM STOPPAGE </th>
                <th>TO STOPPAGE</th>
                <th>SEAT CLASS</th>
                <th>FARE AMOUNT</th>
                <th>STATUS</th>
                <th class="action-row"><g:message code="action"/></th>
            </tr>
            </thead>
            <tbody>
            <g:if test="${faresList}">
                <g:each in="${faresList}" var="fares">
                    <tr>
                        <td>${fares?.fromStoppage?.name}</td>
                        <td>${fares?.toStoppage?.name}</td>
                        <td>${fares?.seatClass}</td>
                        <td><span class="badge badge-primary">${fares?.amount}</span></td>
                        <td><span class="badge ${(fares?.status == "ACTIVE") ?  "badge-success" :  "badge-secondary"}">${fares?.status}</span></td>
                        <td>
                            <div class="btn-group">
                                <g:link controller="coach" action="edit" class="btn btn-secondary" id="${fares.id}"><i class="fas fa-edit"></i></g:link>
                                <g:link controller="coach" action="delete" id="${fares.id}" class="btn btn-secondary delete-confirmation"><i class="fas fa-trash"></i></g:link>
                            </div>
                        </td>
                    </tr>
                </g:each>
            </g:if>
           <g:else>
               <tr>
                  No Fares Found!
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
