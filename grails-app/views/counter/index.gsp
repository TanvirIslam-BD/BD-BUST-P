%{--Include Main Layout--}%
<meta name="layout" content="main"/>

<div class="bus-system-list-view card">
    <div class="card-header">
        <g:message code="Counters" args="['List']"/>

        %{--Actions--}%
        <span class="float-right">

            %{--Search Panel --}%
            <div class="btn-group">
                <g:form controller="counter" action="index" method="GET">
                    <div class="input-group" id="search-area">
                        <g:select name="colName" class="form-control" from="[name: 'Name']" value="${params?.colName}" optionKey="key" optionValue="value"/>
                        <g:textField name="colValue" class="form-control" value="${params?.colValue}"/>
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="submit">Search</button>
                        </span>
                    </div>
                </g:form>
            </div>

            %{--Create and Reload Panel--}%
            <div class="btn-group">
                <g:link controller="counter" action="create" class="btn btn-success"><g:message code="create"/></g:link>
                <g:link controller="counter" action="index" class="btn btn-primary"><g:message code="reload"/></g:link>
            </div>
        </span>
    </div>

    %{--Table Panel--}%
    <div class="card-body">
        <table class="table table-bordered">
            <thead class="thead-dark">
            <tr>
                <g:sortableColumn property="id" title="${g.message(code: "id")}"/>
                <g:sortableColumn property="id" title="${g.message(code: "sequence")}"/>
                <g:sortableColumn property="name" title="${g.message(code: "name")}"/>
                <th>STATUS</th>
                <th class="action-row"><g:message code="action"/></th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${counters}" var="counter">
                <tr>
                    <td>${counter?.id}</td>
                    <td>${counter?.sequence}</td>
                    <td>${counter?.name}</td>
                    <td><span class="badge ${(counter?.status == "ACTIVE") ?  "badge-success" :  "badge-secondary"}">${counter?.status}</span></td>

                    %{--Table Actions --}%
                    <td>
                        <div class="btn-group">
                            <g:link controller="seatMap" action="edit" class="btn btn-secondary" id="${counter.id}"><i class="fas fa-edit"></i></g:link>
                            <g:link controller="seatMap" action="delete" id="${counter.id}" class="btn btn-secondary delete-confirmation"><i class="fas fa-trash"></i></g:link>
                        </div>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
        %{--Pagination Area--}%
        <div class="paginate">
            <g:paginate total="${total ?: 0}" />
        </div>
    </div>
</div>
