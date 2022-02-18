var firstSeatLabel = 1;
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

    var $cart = $('#selected-seats'),
        $counter = $('#counter'),
        $total = $('#total'),
        $totalPaidAmountInput = $('.total-paid-amount'),

        sc = seatMap.seatCharts({

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
            click: function () {
                if (this.status() == 'available') {
                    $('<li class="selected-book-seats-item"> <b>'+this.settings.label+'</b><a href="#" class="cancel-cart-item">[cancel]</a></li>')
                        .attr('id', 'cart-item-'+this.settings.id)
                        .attr('seatno', this.settings.id)
                        .data('seatId', this.settings.id)
                        .appendTo($cart);

                    $counter.text(sc.find('selected').length+1);
                    $total.text(recalculateTotal(sc)+this.data().price + " TK");
                    var totalPaidAmount = recalculateTotal(sc)+this.data().price
                    $('.total-amount-to-paid-to-calc').val(totalPaidAmount);
                    var totalPaidableAmount = totalPaidAmount - $(".booked-seat-discount-on-total").val()
                    $totalPaidAmountInput.val(totalPaidableAmount);
                    $(".booked-seat-map-numbers").append('<input type="hidden" name="seatBooked" value="'+this.settings.id+'">')

                    return 'selected';
                } else if (this.status() == 'selected') {

                    $counter.text(sc.find('selected').length-1);

                    $total.text(recalculateTotal(sc)-this.data().price);
                    var totalPaidAmount = recalculateTotal(sc) - this.data().price
                    $('.total-amount-to-paid-to-calc').val(totalPaidAmount);
                    var totalPaidableAmount = totalPaidAmount - $(".booked-seat-discount-on-total").val()
                    $totalPaidAmountInput.val(totalPaidableAmount);

                    $('#cart-item-'+this.settings.id).remove();
                    $(".booked-seat-map-numbers").find('input[value="'+this.settings.id+'"]').remove();


                    return 'available';
                } else if (this.status() == 'unavailable') {

                    return 'unavailable';
                } else {
                    return this.style();
                }
            }
        });


    $('#selected-seats').on('click', '.cancel-cart-item', function () {
        //let's just trigger Click event on the appropriate seat, so we don't have to repeat the logic here
        sc.get($(this).parents('li:first').data('seatId')).click();
    });

    var discountInput = $(".booked-seat-discount-on-total")
    discountInput.on("input", function (){
        var totalPaidAmount = $('.total-amount-to-paid-to-calc').val();
        var totalPaidableAmount = totalPaidAmount - discountInput.val()
        $totalPaidAmountInput.val(totalPaidableAmount);
    })



    //let's pretend some seats have already been booked
    // sc.get($("#seat-map").attr("bookedseats").replaceAll("[[", "").replaceAll("]]", "").replaceAll("]", "").replaceAll("[", "").split(",")).status('unavailable');
    sc.get($("#seat-map").attr("bookedseats").replaceAll("[[", "").replaceAll("]]", "").replaceAll("]", "").replaceAll("[", "").replaceAll(" ", "").split(",")).status('unavailable');

});

function recalculateTotal(sc) {
    var total = 0;

    //basically find every selected seat and sum its price
    sc.find('selected').each(function () {
        total += this.data().price;
    });

    return total;
}
