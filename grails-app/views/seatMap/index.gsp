<%@ page import="com.tanvir.bsts.GlobalConfig" %>
%{--Include Main Layout--}%
<meta name="layout" content="main"/>

<div class="common-list-table-view-ui col-lg-13 mt-4 col-13">
    <div class="card mb-4">
        <div class="card-header pb-0">
            <div class="row">
                <div class="col-lg-6 col-7">
                    <h6>Seat Plans</h6>
                    <p class="text-sm mb-0">
                        <i class="fa fa-check text-info" aria-hidden="true"></i>
                        Operate this section with the corresponding UI
                    </p>
                </div>
                <div class="col-lg-6 col-5 my-auto text-end">
                    <div class="btn-group">
                        <g:form controller="seatMap" action="index" method="GET">
                            <div class="input-group" id="search-area">
                                <g:select name="colName" class="form-control" from="[name: 'NAME']" value="${params?.colName}" optionKey="key" optionValue="value"/>
                                <g:textField  placeholder="search here" name="colValue" class="form-control" value="${params?.colValue}"/>
                                <span class="input-group-text text-body">
                                    <button class="btn btn-sm" type="submit"><i class="fas fa-search" aria-hidden="true"></i></button>
                                </span>
                            </div>
                        </g:form>
                    </div>

                    <div class="form-group">
                        <g:link controller="seatMap" action="create" class="btn bg-gradient-success btn-sm pull-end"><g:message code="create"/></g:link>
                        <g:link controller="seatMap" action="index" class="btn bg-gradient-info btn-sm pull-end"><g:message code="reload"/></g:link>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-body px-0 pb-2">
            <div class="table-responsive p-0">
                <table class="table align-items-center mb-0">
                    <thead>
                    <tr>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">SL.</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Name</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Rows</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Seat Format</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Status</th>
                        <th class="text-secondary opacity-7"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:if test="${seatMapList}">
                        <g:each in="${seatMapList}" var="seatMap">
                            <tr>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold"> ${seatMap?.id}</span></td>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold"> ${seatMap?.name}</span></td>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold"> ${seatMap?.seatRows}</span></td>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold">${GlobalConfig.SEAT_FORMAT[Integer.parseInt(seatMap?.seatColumns?.toString())]}</span></td>
                                <td class="text-center text-sm"><span class="badge badge-sm  bg-gradient-success">ACTIVE</span></td>
                                <td class="text-center">
                                    <div class="btn-group">
                                        <g:link data-bs-toggle="tooltip" data-bs-placement="top"  title="View Plan"  data-toggle="modal" data-target="#seatPlanModal" data-whatever="@getbootstrap"  id="${seatMap.id}" class="btn btn-secondary"><i class="fas fa-eye"></i></g:link>

                                        <div class="modal fade" id="seatPlanModal" tabindex="-1" role="dialog" aria-labelledby="seatPlanModalLabel" aria-hidden="true">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                    <asset:stylesheet src="jquery.seat-charts.css"/>
                                                    <asset:stylesheet src="booking.css"/>
                                                    <asset:stylesheet src="ticketBooking.css"/>
                                                    <asset:stylesheet src="seat.css"/>
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="exampleModalLabel">Seat Plan - ${seatMap?.name}</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                            <div class="seat-design-map-ui">
                                                                <g:if test="${seatMap}">
                                                                    <div id="seat-map" class="seat-panel"  extraseatinlastrow="${seatMap.extraSeatInLastRow}" rows="${seatMap.seatRows}" columns="${seatMap.seatColumns}" >

                                                                    </div>
                                                                </g:if>
                                                            </div>
                                                        <asset:javascript src="jquery.seat-charts.js"/>
                                                        <script>
                                                            $(document).ready(function() {
                                                                var seatMap = $('#seat-map');
                                                                var rows = parseInt(seatMap.attr("rows"));
                                                                var columns = parseInt(seatMap.attr("columns"));
                                                                var price = parseFloat(seatMap.attr("price"));
                                                                var extraSeatInLastRow = seatMap.attr("extraseatinlastrow");

                                                                var rowsCharacters = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
                                                                var threeColumnsDesignV1 = ['A_AA','B_BB','C_CC','D_DD','E_EE','F_FF','G_GG','H_HH','I_II','J_JJ','K_KK','L_LL','M_MM','N_NN','O_OO','P_PP','Q_QQ','R_RR','S_SS','T_TT','U_UU','V_VV','W_WW','X_XX','Y_YY','Z_ZZ']
                                                                var fourColumnsDesignV1 = ['AA_AA','BB_BB','CC_CC','DD_DD','EE_EE','FF_FF','GG_GG','HH_HH','II_II','JJ_JJ','KK_KK','LL_LL','MM_MM','NN_NN','OO_OO','PP_PP','QQ_QQ','RR_RR','SS_SS','TT_TT','UU_UU','VV_VV','WW_WW','XX_XX','YY_YY','ZZ_ZZ']

                                                                var seatDesign = []
                                                                var lastRow = rows - 1
                                                                var lastRowChar = rowsCharacters[lastRow]
                                                                if(columns == 3){
                                                                    seatDesign = threeColumnsDesignV1.slice(0, rows)
                                                                }else if(columns == 4){
                                                                    seatDesign = fourColumnsDesignV1.slice(0, rows)
                                                                }
                                                                if((extraSeatInLastRow == "true")){
                                                                    seatDesign[lastRow] = seatDesign[lastRow].replaceAll("_", lastRowChar)
                                                                }

                                                                seatMap.seatCharts({

                                                                    map: seatDesign,

                                                                    seats: {
                                                                        A: {
                                                                            price   : price,
                                                                        },
                                                                        B: {
                                                                            price   : price,
                                                                        }  ,
                                                                        C: {
                                                                            price   : price,
                                                                        },
                                                                        D: {
                                                                            price   : price,
                                                                        },
                                                                        E: {
                                                                            price   : price,
                                                                        },
                                                                        F: {
                                                                            price   : price,
                                                                        }  ,
                                                                        G: {
                                                                            price   : price,
                                                                        },
                                                                        H: {
                                                                            price   : price,
                                                                        }  ,
                                                                        I: {
                                                                            price   : price,
                                                                        },
                                                                        J: {
                                                                            price   : price,
                                                                        }  ,
                                                                        K: {
                                                                            price   : price,
                                                                        },
                                                                        L: {
                                                                            price   : price,
                                                                        },
                                                                        M: {
                                                                            price   : price,
                                                                        },
                                                                        N: {
                                                                            price   : price,
                                                                        }  ,
                                                                        O: {
                                                                            price   : price,
                                                                        },
                                                                        P: {
                                                                            price   : price,
                                                                        },
                                                                        Q: {
                                                                            price   : price,
                                                                        },
                                                                        R: {
                                                                            price   : price,
                                                                        },
                                                                        S: {
                                                                            price   : price,
                                                                        }  ,
                                                                        T: {
                                                                            price   : price,
                                                                        },
                                                                        U: {
                                                                            price   : price,
                                                                        },
                                                                        V: {
                                                                            price   : price,
                                                                        },
                                                                        W: {
                                                                            price   : price,
                                                                        },
                                                                        X: {
                                                                            price   : price,
                                                                        }  ,
                                                                        Y: {
                                                                            price   : price,
                                                                        },
                                                                        Z: {
                                                                            price   : price,
                                                                        }
                                                                    },
                                                                    naming : {
                                                                        top : true,
                                                                        left : true,
                                                                        getLabel : function (character, row, column) {
                                                                            if((extraSeatInLastRow == "true") && (character == lastRowChar)){
                                                                                return character + column;
                                                                            }
                                                                            if(columns == 3 && column == 3){
                                                                                column = column - 1
                                                                            }else if(columns == 4 && column == 4){
                                                                                column = column - 1
                                                                            }
                                                                            return character + column;
                                                                        },
                                                                    },
                                                                    legend : {
                                                                        node : $('#legend'),
                                                                        items : [
                                                                            [ 'f', 'available', 'Available' ],
                                                                            [ 'f', 'readytobook', 'Selected' ],
                                                                            [ 'f', 'unavailable', 'Booked']
                                                                        ]
                                                                    },
                                                                    click: function () {}
                                                                });

                                                            });
                                                        </script>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <g:link data-bs-toggle="tooltip" data-bs-placement="top"  title="Edit" controller="seatMap" action="edit" class="btn btn-secondary" id="${seatMap.id}"><i class="fas fa-edit"></i></g:link>
                                        <g:link data-bs-toggle="tooltip" data-bs-placement="top"  title="Delete" controller="seatMap" action="delete" id="${seatMap.id}" class="btn btn-secondary delete-confirmation"><i class="fas fa-trash"></i></g:link>
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


