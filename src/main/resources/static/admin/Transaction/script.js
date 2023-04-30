    $(document).ready(function() {
    $("#Transaction").addClass("btn-dark")

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
                    data: "startime",
                    render: function (data, type, row) {
                        let date = moment.utc(data).local();
                        let formattedDate = date.format('HH:mm - DD/MM/YYYY');
                        return formattedDate;
                    }
                },
                {
                    data: "created_at",
                    render: function (data, type, row) {
                        let date = moment.utc(data).local();
                        let formattedDate = date.format('HH:mm - DD/MM/YYYY');
                        return formattedDate;
                    }
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