<%@ page import="com.tanvir.bsts.GlobalConfig" %>
%{--Include Main Layout--}%
<meta name="layout" content="main"/>


<div class="common-list-table-view-ui col-lg-13 mt-4 col-13">
    <div class="card mb-4">
        <div class="card-header pb-0">
            <div class="row">
                <div class="col-lg-6 col-7">
                    <h6>Hold Tickets</h6>
                    <p class="text-sm mb-0">
                        <i class="fa fa-check text-info" aria-hidden="true"></i>
                        Operate this section with the corresponding UI
                    </p>
                </div>
                <div class="col-lg-6 col-5 my-auto text-end">
                    <div class="btn-group">
                        <g:form controller="holdTicket" action="index" method="GET">
                            <div class="input-group" id="search-area">
                                <g:select name="colName" class="form-control" from="[tripNo: 'NAME']" value="${params?.colName}" optionKey="key" optionValue="value"/>
                                <g:textField placeholder="search here" name="colValue" class="form-control" value="${params?.colValue}"/>
                                <span class="input-group-text text-body">
                                    <button class="btn btn-sm" type="submit"><i class="fas fa-search" aria-hidden="true"></i></button>
                                </span>
                            </div>
                        </g:form>
                    </div>

                    <div class="form-group">
                        <g:link controller="holdTicket" action="index" class="btn bg-gradient-info btn-sm pull-end"><g:message code="reload"/></g:link>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-body px-0 pb-2">
            <div class="table-responsive p-0">
                <table class="table align-items-center mb-0">
                    <thead>
                    <tr>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">SL</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">SEAT NO</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">TRIP#</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">FULL NAME</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">PHONE</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">COUNTER</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">TIME</th>
                        <th class="text-secondary opacity-7"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:if test="${holdTickets}">
                        <g:each in="${holdTickets}" var="holdTicket">
                            <tr>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold">${holdTicket?.id} </span></td>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold">${holdTicket?.seatNo} </span></td>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold">${holdTicket?.tripNo}</span></td>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold">${holdTicket?.fullName}</span></td>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold">${holdTicket?.phone}</span></td>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold">${holdTicket?.counter}</span></td>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold">${holdTicket?.time}</span></td>
                                <td class="text-center">
                                    <div class="btn-group">
                                        <g:link data-bs-toggle="tooltip" data-bs-placement="top"  title="Delete" controller="holdTicket" action="delete" id="${holdTicket.id}" class="btn btn-secondary delete-confirmation"><i class="fas fa-trash"></i></g:link>
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


