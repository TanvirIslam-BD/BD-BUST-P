%{--Include Main Layout--}%
<meta name="layout" content="main"/>

<div class="bus-system-list-view card">
    <div class="card-header">
        <g:message code="Tickets" args="['List']"/>

        %{--Actions--}%
        <span class="float-right">

            %{--Search Panel --}%
            <div class="btn-group">
                <g:form controller="busTicket" action="index" method="GET">
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
                <g:link controller="busTicket" action="create" class="btn btn-success"><g:message code="create"/></g:link>
                <g:link controller="busTicket" action="index" class="btn btn-primary"><g:message code="reload"/></g:link>
            </div>
        </span>
    </div>

    %{--Table Panel--}%
    <div class="card-body">
        <table class="table table-bordered">
            <thead class="thead-dark">
            <tr>
                <g:sortableColumn property="id" title="BOARDING TIME & DATE"/>
                <g:sortableColumn property="id" title="COACH NO."/>
                <g:sortableColumn property="name" title="STARTING COUNTER"/>
                <th>END COUNTER</th>
                <th>REGISTRATION NUMBER</th>
                <th>COACH TYPE</th>
                <th>BOOKED</th>
                <th>AVAILABLE</th>
                <th class="action-row"><g:message code="action"/></th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${busTickets}" var="ticket">
                <tr>
                    <td>${ticket?.boardingTimeAndDate}</td>
                    <td>${ticket?.coach?.coachNumber}</td>
                    <td>${ticket?.fares?.fromStoppage?.name}</td>
                    <td>${ticket?.fares?.toStoppage?.name}</td>
                    <td>${ticket?.coach?.registrationNumber}</td>
                    <td>${ticket?.fares?.seatClass}</td>
                    <td>${52}</td>
                    <td>${0}</td>

                    %{--Table Actions --}%
                    <td>
                        <div class="btn-group">
                            <g:link controller="busTicket" action="details" class="btn btn-secondary" id="${ticket.id}"><i class="fas fa-eye"></i></g:link>
                            <g:link controller="busTicket" action="edit" class="btn btn-secondary" id="${ticket.id}"><i class="fas fa-edit"></i></g:link>
                            <g:link controller="busTicket" action="delete" id="${ticket.id}" class="btn btn-secondary delete-confirmation"><i class="fas fa-trash"></i></g:link>
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
