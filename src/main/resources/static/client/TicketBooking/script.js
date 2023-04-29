    $(document).ready(function() {
        function addCommas(str) {
            str += '';
            x = str.split('.');
            x1 = x[0];
            x2 = x.length > 1 ? '.' + x[1] : '';
            var rgx = /(\d+)(\d{3})/;
            while (rgx.test(x1)) {
                x1 = x1.replace(rgx, '$1' + ',' + '$2');
            }
            return x1 + x2;
        }

        function parseNumber(str) {
            return parseInt(str.replaceAll(',', ''));
        }
        $("#bookticket-ticket-main-number-regular-quantity").bind('keyup mouseup', function() {
            $regularPrice = parseNumber($("#bookticket-ticket-main-number-regular-price").html());
            $regularQuantity = $("#bookticket-ticket-main-number-regular-quantity").find("input").val();
            $couplePrice = parseNumber($("#bookticket-ticket-main-number-couple-price").html());
            $coupleQuantity = $("#bookticket-ticket-main-number-couple-quantity").find("input").val();
            $("#bookticket-ticket-main-number-regular-sum").html(addCommas($regularPrice * $regularQuantity))
            $("#bookticket-ticket-main-cart-regular-total").html(addCommas($regularPrice * $regularQuantity))
            $("#bookticket-ticket-main-cart-total-price").html(addCommas($regularPrice * $regularQuantity + $couplePrice * $coupleQuantity))
        });
        $("#bookticket-ticket-main-number-couple-quantity").bind('keyup mouseup', function() {
            $regularPrice = parseNumber($("#bookticket-ticket-main-number-regular-price").html());
            $regularQuantity = $("#bookticket-ticket-main-number-regular-quantity").find("input").val();
            $couplePrice = parseNumber($("#bookticket-ticket-main-number-couple-price").html());
            $coupleQuantity = $("#bookticket-ticket-main-number-couple-quantity").find("input").val();
            $("#bookticket-ticket-main-number-couple-sum").html(addCommas($couplePrice * $coupleQuantity))
            $("#bookticket-ticket-main-cart-couple-total").html(addCommas($couplePrice * $coupleQuantity))
            $("#bookticket-ticket-main-cart-total-price").html(addCommas($regularPrice * $regularQuantity + $couplePrice * $coupleQuantity))
        });

        $('#bookticket-next').click(
            function() {
                var total_regular = $('#bookticket-ticket-main-cart-regular-total').text()
                var total_couple = $('#bookticket-ticket-main-cart-couple-total').text()
                var quantity_regular = $('#regular-quantity').val()
                var quantity_couple = $('#couple-quantity').val()
                var settings = {
                            "url": "/api/transactions/ticketbooking",
                            "method": "POST",
                            "timeout": 0,
                            "headers": {
                                "Content-Type": "application/json",
                            },
                            "data": JSON.stringify({
                                "total_regular": parseNumber(total_regular),
                                "total_couple": parseNumber(total_couple),
                                "quantity_regular": parseNumber(quantity_regular),
                                "quantity_couple": parseNumber(quantity_couple)
                            }),
                        };  

                $.ajax(settings).done(function (response) {
                console.log(response);
                });
                $(location).attr('href', '/seatbooking');
            }
        )
    })