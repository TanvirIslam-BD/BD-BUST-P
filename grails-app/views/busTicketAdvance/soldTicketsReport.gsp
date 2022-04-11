<g:if test="${success}">
    <div class="modal-header">
        <h5 class="modal-title">
            <span class="col-md-10">
                Trip No: ${busTicket.tripNo}-${busTicket.seatClass.toUpperCase()} Trip Date: ${date}
            </span>
        </h5>
        <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
    <div class="modal-body ${success ? "report-view" : "not-permission-view-alert"}">
        <div class="table-responsive">
              <table id="dataTable" class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th>Ticket#</th>
                            <th>Mobile#</th>
                            <th>Type</th>
                            <th>Seat No#</th>
                            <th>Departure</th>
                            <th>Seller</th>
                            <th>Counter</th>
                            <th>Qty</th>
                            <th>Total Fare</th>
                            <th>Disc</th>
                            <th>Comsn</th>
                            <th>Received</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${soldList}" var="soldTicket">
                            <tr class="dataItem">
                                <td>${soldTicket.id}</td>
                                <td>${soldTicket.mobile}</td>
                                <td>Sale</td>
                                <td>${soldTicket.seatBookedForDisplay}</td>
                                <td><UIHelper:parseTimeInFormat time="${soldTicket?.departureTime}"/> </td>
                                <td>${soldTicket?.saleBy.firstName} ${soldTicket?.saleBy?.lastName}</td>
                                <td>${soldTicket?.saleBy?.counter?.name}</td>
                                <td class="align-right">${soldTicket.totalBookedSeat}</td>
                                <td class="align-right">${soldTicket.totalPaid}</td>
                                <td class="align-right">${soldTicket.discount}</td>
                                <td class="align-right">${soldTicket.commission}</td>
                                <td class="align-right">${soldTicket.receivedAmountAfterCommission}</td>
                            </tr>
                        </g:each>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="7" class="align-right">Total =</td>
                            <td class="align-right">${totalSeatSold}</td>
                            <td class="align-right">${totalFare}</td>
                            <td class="align-right">${totalDiscount}</td>
                            <td class="align-right">${totalCommission}</td>
                            <td class="align-right">${totalReceived}</td>
                        </tr>
                        </tfoot>
                    </table>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">Close</button>
    </div>
</g:if>
<g:else>
    <div class="modal-header">
        <h5 class="modal-title" id="myModalLabel">
            <span class="col-md-10">
                ${message}
            </span>
        </h5>
        <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
</g:else>
