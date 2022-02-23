%{--Include Main Layout--}%
<meta name="layout" content="main"/>
<asset:stylesheet src="jquery.seat-charts.css"/>
<asset:stylesheet src="booking.css"/>
<asset:stylesheet src="ticketBooking.css"/>
<asset:stylesheet src="seat.css"/>

<div class="card">
    <div class="card-header">
        Seat Plan -  ${seatMap.name}
    </div>
    <div class="card-body">
        <div class="seat-design-map-ui">
        <div class="row">
            <div class="col-md-offset-7 col-md-4 col-sm-offset-7 col-sm-4 col-xs-offset-7 col-xs-4 bus-steering-wheel">
                <i class="fa fa-steering-wheel"></i>
            </div>
        </div>
        <g:if test="${seatMap}">
            <div id="seat-map" class="seat-panel"  extraseatinlastrow="${seatMap.extraSeatInLastRow}" rows="${seatMap.seatRows}" columns="${seatMap.seatColumns}" >

            </div>
        </g:if>
        </div>
        <div class="form-action-panel top-right-corner">
            <g:link controller="seatMap" action="index" class="btn btn-secondary">Back</g:link>
        </div>
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
