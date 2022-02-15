%{--Include Main Layout--}%
<meta name="layout" content="main"/>
<asset:stylesheet src="jquery.seat-charts.css"/>
<asset:stylesheet src="booking.css"/>

<div class="card">
    <div class="card-header">
        Seat Plan -  ${seatMap.name}
    </div>
    <div class="card-body">
        <g:if test="${seatMap}">
            <div id="seat-map" class="seat-panel" rows="${seatMap.seatRows}" columns="${seatMap.seatColumns}" >

            </div>
        </g:if>
        <div class="form-action-panel top-right-corner">
            <g:link controller="seatMap" action="index" class="btn btn-secondary">Back</g:link>
        </div>
    </div>
    <asset:javascript src="jquery.seat-charts.js"/>

    <script>
        var firstSeatLabel = 1;
        $(document).ready(function() {
            var seatMap = $('#seat-map');
            var rows = parseInt(seatMap.attr("rows"));
            var columns = parseInt(seatMap.attr("columns"));

            var threeColumnsDesignV1 = ['A_AA','B_BB','C_CC','D_DD','E_EE','F_FF','G_GG','H_HH','I_II','J_JJ','K_KK','L_LL','M_MM','N_NN','O_OO','P_PP','Q_QQ','R_RR','S_SS','T_TT','U_UU','V_VV','W_WW','X_XX','Y_YY','Z_ZZ']
            var fourColumnsDesignV1 = ['AA_AA','BB_BB','CC_CC','DD_DD','EE_EE','FF_FF','GG_GG','HH_HH','II_II','JJ_JJ','KK_KK','LL_LL','MM_MM','NN_NN','OO_OO','PP_PP','QQ_QQ','RR_RR','SS_SS','TT_TT','UU_UU','VV_VV','WW_WW','XX_XX','YY_YY','ZZ_ZZ']

            var seatDesign = []
            if(columns == 3){
                seatDesign = threeColumnsDesignV1.slice(0, rows)
            }else if(columns == 4){
                seatDesign = fourColumnsDesignV1.slice(0, rows)
            }

            var $cart = $('#selected-seats'),
                $counter = $('#counter'),
                $total = $('#total'),

                sc = seatMap.seatCharts({


                    map: seatDesign,


                    seats: {
                        f: {
                            price   : 100,
                            classes : 'first-class', //your custom CSS class
                            category: 'First Class'
                        }

                    },
                    naming : {
                        top : true,
                        left : true,
                        getLabel : function (character, row, column) {
                            return character + column;
                        },
                    },
                    legend : {
                        node : $('#legend'),
                        items : [
                            [ 'f', 'available',   'Available' ],
                            [ 'f', 'unavailable', 'Already Booked']
                        ]
                    },
                    click: function () {
                        if (this.status() == 'available') {
                            //let's create a new <li> which we'll add to the cart items
                            $('<li>'+this.data().category+' Seat # '+this.settings.label+': <b>$'+this.data().price+'</b> <a href="#" class="cancel-cart-item">[cancel]</a></li>')
                                .attr('id', 'cart-item-'+this.settings.id)
                                .data('seatId', this.settings.id)
                                .appendTo($cart);

                            /*
                             * Lets update the counter and total
                             *
                             * .find function will not find the current seat, because it will change its stauts only after return
                             * 'selected'. This is why we have to add 1 to the length and the current seat price to the total.
                             */
                            $counter.text(sc.find('selected').length+1);
                            $total.text(recalculateTotal(sc)+this.data().price);

                            return 'selected';
                        } else if (this.status() == 'selected') {
                            //update the counter
                            $counter.text(sc.find('selected').length-1);
                            //and total
                            $total.text(recalculateTotal(sc)-this.data().price);

                            //remove the item from our cart
                            $('#cart-item-'+this.settings.id).remove();

                            //seat has been vacated
                            return 'available';
                        } else if (this.status() == 'unavailable') {
                            //seat has been already booked
                            return 'unavailable';
                        } else {
                            return this.style();
                        }
                    }
                });

            //this will handle "[cancel]" link clicks
            $('#selected-seats').on('click', '.cancel-cart-item', function () {
                //let's just trigger Click event on the appropriate seat, so we don't have to repeat the logic here
                sc.get($(this).parents('li:first').data('seatId')).click();
            });

            //let's pretend some seats have already been booked
            // sc.get(['1_2', '4_1', '7_1', '8_2']).status('unavailable');

        });

        function recalculateTotal(sc) {
            var total = 0;

            //basically find every selected seat and sum its price
            sc.find('selected').each(function () {
                total += this.data().price;
            });

            return total;
        }

    </script>
</div>
