$(document).ready(function() {

        foods = []
        $('.quantity').change(function() {
            var id = $(this).attr('id');
            const index = foods.findIndex(id);
            if (index > -1) {
                foods.splice(index, 1);
            }
 
            foods.push(id)
            console.log(foods)

        })

        $('#bookticket-prev').click(
            function() {
                $(location).attr('href', '/seatbooking');
            }
        )
        $('#bookticket-next').click(
            function() {
                $.ajax({
                    url: '/api/transactions/combobooking',
                    type: 'POST',
                    data: JSON.stringify({data: foods}),
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function(response) {
                        console.log(response);
                    }
                });
                
                $(location).attr('href', '/confirmbooking');
            }
        )
    })