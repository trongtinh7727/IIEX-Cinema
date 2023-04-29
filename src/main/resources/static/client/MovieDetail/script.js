function bookTicket(btn) {
        let tds = $(btn).closest('tr').find('td')
        let ID = tds[0].innerHTML;
        window.location.href = '/ticketbooking/'+ID;

    }
$(document).ready(function () {
    $("#Schedule").addClass("btn-dark")

    function load_cinema() {
        $.get("/api/cinemas", function (data, status) {
            console.log(data)
            data.data.forEach(function (object) {
                var option = document.createElement('option');
                option.value = object.id;
                option.innerText = object.name;
                $('#cinemaBox').append(option);
            });
        }, "json");
    }
    load_cinema();


    function load_showroom(cinema_id) {
        $('#showroomBox').empty()
        var option = document.createElement('option');
        option.value = -1;
        option.innerText = "Chọn phòng chiếu";
        $('#showroomBox').append(option);
        $.get("/api/showrooms/getByCinema/" + cinema_id, function (data, status) {
            console.log(data)
            data.data.forEach(function (object) {
                var option = document.createElement('option');
                option.value = object.id;
                option.innerText = "Phòng số " + object.showroom_number;
                $('#showroomBox').append(option);
            });
        }, "json");
    }
    $('#cinemaBox').change(function () {
        load_showroom($('#cinemaBox').val());
    })
    let movie_id = $('#movieID').val();

    let table = $('#dataTable').DataTable({
        ajax: "/api/schedules/getByShowroom/0/"+movie_id,
        columns: [{
            data: 'id'
        },
        {
            data: 'startTime',
            render: function (data, type, row) {
                let date = moment.utc(data).local();
                let formattedDate = date.format('HH:mm - DD/MM/YYYY');
                return formattedDate;
            }
        }
        ,
        {
            data: null,
            render: function (data, type, row) {
                return data.seatCount - data.emptySeat + "/" + data.seatCount;
            }
        },
        {
            data: 'price',
             render: function (data, type, row) {
                let price = parseFloat(data);
                let formattedPrice = price.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
                return formattedPrice;
            }
        },
        {
            data: null,
            render: function (data, type, row) {
                return '<button name="book" class="btn btn-outline-secondary" onclick="bookTicket(this)" > Đặt vé </button>';
            }
        }
        ]
    });
    $('#showroomBox').change(function () {
        let showroom_id = $('#showroomBox').val();
        let movie_id = $('#movieID').val();
        table.ajax.url("/api/schedules/getByShowroom/" + showroom_id + "/" + movie_id).load();
    })
});

