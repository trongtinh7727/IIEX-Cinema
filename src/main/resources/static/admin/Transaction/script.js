    $(document).ready(function() {

        $('#btn_add_employee').hide();
        var table = $('#dataTable').DataTable({
            ajax: "/api/transactions",
            columns: [{
                    data: "id"
                }, 
                {
                    data: "cinema"
                },
                {
                    data: "username"
                },
                {
                    data: "name"
                },
                {
                    data: "title"
                },
                {
                    data: "startime"
                },
                {
                    data: "created_at"
                },
                {
                    data: "seats"
                },
                {
                    data: "ticketPrice",
                    render: $.fn.dataTable.render.number(',', '.', 0, '$')
                },
                {
                    data: "foodPrice",
                    render: $.fn.dataTable.render.number(',', '.', 0, '$')
                },
                {
                    data: "totalPrice",
                    render: $.fn.dataTable.render.number(',', '.', 0, '$')
                }
            ]
        });
    })