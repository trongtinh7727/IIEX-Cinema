function fillEditForm(btn) {
    $("#addModalLabel").text = "Update";
    let tds = $(btn).closest('tr').find('td')
    let ID = tds[0].innerHTML;
    $("#action").val(ID);
    $.get("/api/schedules/" + ID, function (data, status) {
        console.log(data)
        $('#movieBox').val(data.movie_Id);
        var formattedDate = new Date(data.startTime).toISOString().slice(0, 16);
    
        $('#startTimne').val(formattedDate);

        $('#price').val(data.price);
    }, "json");
}
$('#addEmployeeModal').on('hidden.bs.modal', function () {
    clearForm()
})

$(document).ready(function () {

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


    var table = $('#dataTable').DataTable({
        ajax: "/api/schedules/getByShowroom/0",
        columns: [{
            data: 'id'
        },
        {
            data: 'title'
        },
        {
            data: 'duration'
        },
        {
            data: 'startTime'
        },
        {
            data: 'endTime'
        },
        {
            data: null,
            render: function (data, type, row) {
                return data.seatCount - data.emptySeat + "/" + data.seatCount;
            }
        },
        {
            data: 'price'
        },
        {
            data: null,
            render: function (data, type, row) {
                return '<button name="btn_delete_employee" class="btn btn-outline-danger" onclick="confirmRemoval(this)" > Delete </button> <button name="btn_edit_employee" class="btn btn-outline-secondary" onclick="fillEditForm(this)" data-bs-toggle="modal" data-bs-target="#addEmployeeModal" > Edit </button>';
            }
        }
        ]
    });


    function load_ongoing_movie() {
        $.get("/api/movies/ongoing",
            function (data, status) {
                console.log(data)
                data.data.forEach(function (object) {
                    var option = document.createElement('option');
                    option.value = object.id;
                    option.dataset.duration = object.duration;
                    option.innerText = object.title;
                    $('#movieBox').append(option);
                });
            }, "json");
    }
    load_ongoing_movie();
    let jsonArrayObj = [{}];
    $('#showroomBox').change(function () {
        let showroom_id = $('#showroomBox').val();
        table.ajax.url("/api/schedules/getByShowroom/" + showroom_id).load();
    })


    $("#addStaff").click(function () {

        let SHOWROOM_ID = $('#showroomBox').val();
        if (SHOWROOM_ID == '-1') {
            $("#msg-failed").css('display', 'flex').text("Vui lòng chọn rạp và phòng chiếu!")
            $("#msg-success").css('display', 'none')
        } else {
            $("#msg-failed").css('display', 'none')
            let MOV_ID = $('#movieBox').val();
            let STARTTIME = $('#startTimne').val();
            let duration = $('#movieBox option:selected').data('duration');
            const start = new Date(STARTTIME);
            const end = new Date(start.getTime() + (duration + 15) * 60000 + 7 * 60 * 60 * 1000);
            const ENDTIME = end.toISOString();
            let PRICE = $('#price').val();
            let action = $("#action").val();

            if (action == "Add") {

                var settings = {
                    "url": "http://localhost:8080/api/schedules",
                    "method": "POST",
                    "timeout": 0,
                    "headers": {
                        "Content-Type": "application/json"
                    },
                    "data": JSON.stringify({
                        "price": PRICE,
                        "startTime": STARTTIME,
                        "endTime": ENDTIME,
                        "movie_Id": MOV_ID,
                        "showRoom_Id": SHOWROOM_ID
                    }),
                };

                // Tao lich chieu
                $.ajax(settings).done(function (response) {
                    console.log(response);
                    table.ajax.reload();
                    if (response.status) {
                        let msg = response.message;
                        $("#msg-success").css('display', 'flex').text(msg)
                        $("#msg-failed").css('display', 'none')
                    } else {
                        let msg = response.message;
                        console.log(msg)
                        $("#msg-failed").css('display', 'flex').text("Có lỗi xảy ra! Vui lòng thử lại sau: " + msg)
                        $("#msg-success").css('display', 'none')
                    }
                });

            } else {
                let ID = $("#action").val();
                var settings = {
                    "url": "http://localhost:8080/api/schedules/"+ID,
                    "method": "PUT",
                    "timeout": 0,
                    "headers": {
                        "Content-Type": "application/json"
                    },
                    "data": JSON.stringify({
                        "price": PRICE,
                        "startTime": STARTTIME,
                        "endTime": ENDTIME,
                        "movie_Id": MOV_ID,
                        "showRoom_Id": SHOWROOM_ID
                    }),
                };

                $.ajax(settings).done(function (response) {
                    console.log(response);
                    table.ajax.reload();
                    if (response.status) {
                        let msg = response.message;
                        $("#msg-success").css('display', 'flex').text(msg)
                        $("#msg-failed").css('display', 'none')
                    } else {
                        let msg = response.message;
                        console.log(msg)
                        $("#msg-failed").css('display', 'flex').text("Có lỗi xảy ra! Vui lòng thử lại sau: " + msg)
                        $("#msg-success").css('display', 'none')
                    }
                });

                $("#action").val("Add");
            }
        }
        clearForm()
    });

    $("#delete-button").on('click', function () {
        let uid = $('#delete-button').attr('uid');
        var settings = {
            "url": "/api/schedules/" + uid,
            "method": "DELETE",
            "timeout": 0
        };
        $.ajax(settings).done(function (response) {
            console.log(response);
            table.ajax.reload();
            if (response.status) {
                let msg = response.message;
                $("#msg-success").css('display', 'flex').text(msg)
                $("#msg-failed").css('display', 'none')
            } else {
                let msg = response.message;
                console.log(msg)
                $("#msg-failed").css('display', 'flex').text("Có lỗi xảy ra! Vui lòng thử lại sau: " + msg)
                $("#msg-success").css('display', 'none')
            }

        });
    })
});


// hiện dialog xác nhận khi xóa
function confirmRemoval(btn) {
    let tds = $(btn).closest('tr').find('td')
    let msg = `Lịch chiếu của phim ${tds[1].innerText} (ID = ${tds[0].innerText})`;
    document.getElementById("student_name").innerHTML = msg;
    console.log(tds[2].innerText)
    $('#delete-button').attr('uid', tds[0].innerHTML)
    var myModal = new bootstrap.Modal(document.getElementById("confirm-removal-modal"), {});
    myModal.show();
}

function clearForm() {
    $('#name').val("");
    $("#email").val("");
    $("#phone").val("");
}