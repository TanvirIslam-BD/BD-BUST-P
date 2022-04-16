<%@ page import="com.tanvir.bsts.GlobalConfig" %>
%{--Include Main Layout--}%
<meta name="layout" content="main"/>
<div class="common-list-table-view-ui col-lg-13 mt-4">
    <div class="card">
        <div class="card-header pb-0">
            <div class="row">
                <div class="col-lg-6 col-7">
                    <h6>TRIPS (${currentDate})</h6>
                    <p class="text-sm mb-0">
                        <i class="fa fa-check text-info" aria-hidden="true"></i>
                        Activate/Deactivate the trip from the list
                    </p>
                </div>
                <div class="col-lg-6 col-5 my-auto text-end">
                    <div class="btn-group">
                        <g:form controller="busTicket" action="index" method="GET">
                            <div class="input-group" id="search-area">
                                <g:select name="colName" class="form-control" from="[boardingTime: 'Boarding Time']" value="${params?.colName}" optionKey="key" optionValue="value"/>
                                <input name="colValue" class="form-control" type="time" value="${params?.colValue}">
                                <span class="input-group-text text-body">
                                    <button class="btn btn-sm" type="submit"><i class="fas fa-search" aria-hidden="true"></i></button>
                                </span>
                            </div>
                        </g:form>
                    </div>

                    <div class="form-group">
                        <g:link controller="trips" action="index" class="btn bg-gradient-info btn-sm pull-end reload-trips"><g:message code="reload"/></g:link>
                    </div>

                </div>
            </div>
        </div>
        <div class="card-body px-0 pb-2">
            <div class="table-responsive" id="trip-list-table-to-operation">
                <input type="hidden" name="date" value="${currentDate}" id="schedule-id-date">
                <table class="table align-items-center mb-0">
                    <thead>
                    <tr>
                        <th  scope="col" class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">ROUTE</th>
                        <th  scope="col" class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">TRIP NO#</th>
                        <th  scope="col" class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">TRAVELING DATE & TIME</th>
                        <th  scope="col" class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">COACH TYPE</th>
                        <th  scope="col" class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">SEAT PLAN</th>
                        <th  scope="col" class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">FLAT FARE</th>
%{--                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">DRIVER</th>--}%
%{--                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">SUPERVISOR</th>--}%
%{--                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">HELPER</th>--}%
                        <th  scope="col" class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">DEPARTURE COUNTER</th>
                        <th  scope="col" class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">ARRIVAL COUNTER</th>
                        <th  scope="col" class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">VEHICLE</th>
                        <th  scope="col" class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">ACTIVE</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:if test="${busTickets}">
                        <g:each in="${busTickets}" var="ticket">
                            <tr class="${ticket?.isActive ? "active-row" : "de-active-row"}" >
                                <td class="align-middle text-center text-sm">
                                    <span class="d-flex px-2 py-1 flex-column justify-content-center" style="overflow: hidden;">${ticket?.route}</span>
                                </td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.tripNo} </span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold">
                                    <span id="ticket-date-schedule">${currentDate}</span>
                                    <span class="time-ticket-badge"><UIHelper:parseTimeInFormat time="${ticket?.boardingTime}"/></span>
                                </span>
                                </td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.seatClass} </span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.seatMap} </span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.flatFare} </span></td>

                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.fromStoppage} </span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.toStoppage}</span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"> ${ticket?.coachNumber} </span></td>
                                <td class="align-middle text-center">
                                    <div class="btn-group btn-radio" style="width:80px;">
                                        <span date="${currentDate}" active="${ticket?.isActive}" class="btn btn-default button-active btn-sm  ${ticket?.isActive ? "active" : ""} trip-active-de-active " data-value="true" data-id="${ticket?.id}">YES</span>
                                        <span date="${currentDate}" active="${ticket?.isActive}" class="btn btn-dropbox button-active btn-sm  ${ticket?.isActive ? "" : "active"} trip-active-de-active" data-value="false" data-id="${ticket?.id}">NO</span>
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

<script>

    $('.trip-active-de-active').on('click', function () {
        var _this = $(this);
        var tripId = _this.attr("data-id");
        var active = _this.attr("active");
        var date = _this.attr("date");

        var title = active == "true" ? "Deactivate" : "Activate"
        var content = active == "true" ? "deactivate?" : "activate?"

        jQuery.confirm({
            title: title +' Confirmation!',
            content: 'Are you sure want to '+ content,
            buttons: {
                confirm: {
                    text: 'Yes',
                    btnClass: 'btn-blue',
                    action: function () {
                        if(tripId !== undefined){
                            BSTS.ajax.call({
                                url: BSTS.baseURL + "trips/active",
                                data: {tripId: tripId, date: date},
                                success: function (content) {
                                    window.location = BSTS.baseURL + "trips/index"
                                }
                            });
                        }else{
                            _this.closest(".form-group").remove();
                        }
                    }
                },
                cancel: {
                    text: 'No'
                }
            }
        });

    });


</script>
