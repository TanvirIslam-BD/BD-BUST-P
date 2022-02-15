%{--Include Main Layout--}%
<meta name="layout" content="main"/>
<div class="row">
    <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
        <div class="card">
            <div class="card-body p-3">
                <div class="row">
                    <div class="col-8">
                        <div class="numbers">
                            <p class="text-sm mb-0 text-capitalize font-weight-bold">Today's Money</p>
                            <h5 class="font-weight-bolder mb-0">
                                $53,000
                                <span class="text-success text-sm font-weight-bolder">+55%</span>
                            </h5>
                        </div>
                    </div>
                    <div class="col-4 text-end">
                        <div class="icon icon-shape bg-gradient-primary shadow text-center border-radius-md">
                            <i class="ni ni-money-coins text-lg opacity-10" aria-hidden="true"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
        <div class="card">
            <div class="card-body p-3">
                <div class="row">
                    <div class="col-8">
                        <div class="numbers">
                            <p class="text-sm mb-0 text-capitalize font-weight-bold">Today's Users</p>
                            <h5 class="font-weight-bolder mb-0">
                                2,300
                                <span class="text-success text-sm font-weight-bolder">+3%</span>
                            </h5>
                        </div>
                    </div>
                    <div class="col-4 text-end">
                        <div class="icon icon-shape bg-gradient-primary shadow text-center border-radius-md">
                            <i class="ni ni-world text-lg opacity-10" aria-hidden="true"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
        <div class="card">
            <div class="card-body p-3">
                <div class="row">
                    <div class="col-8">
                        <div class="numbers">
                            <p class="text-sm mb-0 text-capitalize font-weight-bold">New Bookings</p>
                            <h5 class="font-weight-bolder mb-0">
                                +3,462
                                <span class="text-danger text-sm font-weight-bolder">-2%</span>
                            </h5>
                        </div>
                    </div>
                    <div class="col-4 text-end">
                        <div class="icon icon-shape bg-gradient-primary shadow text-center border-radius-md">
                            <i class="ni ni-paper-diploma text-lg opacity-10" aria-hidden="true"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-sm-6">
        <div class="card">
            <div class="card-body p-3">
                <div class="row">
                    <div class="col-8">
                        <div class="numbers">
                            <p class="text-sm mb-0 text-capitalize font-weight-bold">Sales</p>
                            <h5 class="font-weight-bolder mb-0">
                                $103,430
                                <span class="text-success text-sm font-weight-bolder">+5%</span>
                            </h5>
                        </div>
                    </div>
                    <div class="col-4 text-end">
                        <div class="icon icon-shape bg-gradient-primary shadow text-center border-radius-md">
                            <i class="ni ni-cart text-lg opacity-10" aria-hidden="true"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="common-list-table-view-ui col-lg-13 mt-4">
    <div class="card">
        <div class="card-header pb-0">
            <div class="row">
                <div class="col-lg-6 col-7">
                    <h6>Tickets</h6>
                    <p class="text-sm mb-0">
                        <i class="fa fa-check text-info" aria-hidden="true"></i>
                        Operate this section with the corresponding UI
                    </p>
                </div>
                <div class="col-lg-6 col-5 my-auto text-end">
                    <div class="btn-group">
                        <g:form controller="busTicket" action="index" method="GET">
                            <div class="input-group" id="search-area">
                                <g:select name="colName" class="form-control" from="[name: 'Name']" value="${params?.colName}" optionKey="key" optionValue="value"/>
                                <g:textField name="colValue" class="form-control" value="${params?.colValue}"/>
                                <span class="input-group-text text-body"><i class="fas fa-search" aria-hidden="true"></i></span>
                            </div>
                        </g:form>
                    </div>

                    <div class="btn-group">
                        <g:link controller="busTicket" action="create" class="btn btn-success"><g:message code="create"/></g:link>
                        <g:link controller="busTicket" action="index" class="btn btn-secondary"><g:message code="reload"/></g:link>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-body px-0 pb-2">
            <div class="table-responsive">
                <table class="table align-items-center mb-0">
                    <thead>
                    <tr>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">BOARDING TIME & DATE</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">COACH NO.</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">STARTING COUNTER</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">END COUNTER</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">REGISTRATION NUMBER</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">COACH TYPE</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">BOOKED</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">AVAILABLE</th>
                        <th class="text-secondary opacity-7"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${busTickets}" var="ticket">
                        <tr>
                        <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.boardingTimeAndDate} </span></td>
                        <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.coach?.coachNumber} </span></td>
                        <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.fares?.fromStoppage?.name} </span></td>
                        <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.fares?.toStoppage?.name}</span></td>
                        <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold">${ticket?.coach?.registrationNumber}</span></td>
                        <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.fares?.seatClass} </span></td>
                        <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${52} </span></td>
                        <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${0} </span></td>
                        <td>
                            <div class="btn-group">
                                <g:link controller="busTicket" action="details" class="btn btn-secondary" id="${ticket.id}"><i class="fas fa-baby-carriage"></i></g:link>
                                <g:link controller="busTicket" action="edit" class="btn btn-secondary" id="${ticket.id}"><i class="fas fa-edit"></i></g:link>
                                <g:link controller="busTicket" action="delete" id="${ticket.id}" class="btn btn-secondary delete-confirmation"><i class="fas fa-trash"></i></g:link>
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
    </div>
</div>


