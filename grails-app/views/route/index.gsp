<meta name="layout" content="main"/>

<div class="common-list-table-view-ui col-lg-13 mt-4 col-13">
    <div class="card mb-4">
        <div class="card-header pb-0">
            <div class="row">
                <div class="col-lg-6 col-7">
                    <h6>Routes</h6>
                    <p class="text-sm mb-0">
                        <i class="fa fa-check text-info" aria-hidden="true"></i>
                        Operate this section with the corresponding UI
                    </p>
                </div>
                <div class="col-lg-6 col-5 my-auto text-end">
                    <div class="btn-group">
                        <g:form controller="route" action="index" method="GET">
                            <div class="input-group" id="search-area">
                                <g:select name="colName" class="form-control" from="[status: 'STATUS']" value="${params?.colName}" optionKey="key" optionValue="value"/>
                                <UIHelper:status name="colValue" class="form-control" value="${params?.colValue}"/>
                                <span class="input-group-text text-body">
                                    <button class="btn btn-sm" type="submit"><i class="fas fa-search" aria-hidden="true"></i></button>
                                </span>
                            </div>
                        </g:form>
                    </div>

                    <div class="form-group">
                        <g:link controller="route" action="create" class="btn bg-gradient-success btn-sm pull-end"><g:message code="create"/></g:link>
                        <g:link controller="route" action="index" class="btn bg-gradient-info btn-sm pull-end"><g:message code="reload"/></g:link>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-body px-0 pb-2">
            <div class="table-responsive p-0">
                <table class="table align-items-center mb-0">
                    <thead>
                    <tr>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">SL.	</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">ROUTE</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">DISTRICT FROM</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">DISTRICT TO</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">FROM STOPPAGE</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">TO STOPPAGE</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">SEAT CLASS</th>
                        <th class="text-secondary opacity-7"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:if test="${routeList}">
                        <g:each in="${routeList}" var="route">
                            <tr>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold">${route?.id}</span></td>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold">${route?.name}</span></td>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold">${route?.districtFrom?.name}</span></td>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold">${route?.districtTo?.name}</span></td>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold">${route?.fromStoppage?.name}</span></td>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold">${route?.toStoppage?.name}</span></td>
                                <td class="text-center text-sm"><span class="badge badge-sm  ${(route?.status == "ACTIVE") ?  "bg-gradient-success" :  "bg-gradient-secondary"}">${route?.status}</span></td>
                                <td class="text-center">
                                    <div class="btn-group">
                                        <g:link data-bs-toggle="tooltip" data-bs-placement="top" title="Edit" controller="route" action="edit" class="btn btn-secondary" id="${route.id}"><i class="fas fa-edit"></i></g:link>
                                        <g:link data-bs-toggle="tooltip" data-bs-placement="top" title="Delete" controller="route" action="delete" id="${route.id}" class="btn btn-secondary delete-confirmation"><i class="fas fa-trash"></i></g:link>
                                    </div>
                                </td>
                            </tr>
                        </g:each>
                    </g:if>
                    <g:else>
                        <g:render template="noDataFound" />
                    </g:else>
                    </tbody>
                </table>
                <div class="paginate">
                    <g:paginate total="${total ?: 0}" />
                </div>
            </div>
        </div>
    </div>
</div>



