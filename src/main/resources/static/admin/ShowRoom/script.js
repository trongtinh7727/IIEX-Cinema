$('#addEmployeeModal').on('hidden.bs.modal', function() {
        clearForm()
    })

    function fillEditForm(btn) {
        $("#addEmployeeModal").val("Update");
        let tds = $(btn).closest('tr').find('td');
        let ID = tds[0].innerHTML;
        $("#action").val(ID);
        $("#SEATCOUNT").prop('disabled', true);
        $('#SHOWROOMNUM').val(tds[1].innerText)
        console.log("edit")
        console.log(tds[1].innerText)
    }

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
        $('#SHOWROOMNUM').val("")
        $('#SEATCOUNT').val("")
    }

    $(document).ready(function() {
        function load_cinema() {
            $.get("/api/cinemas", function(data, status) {

                console.log(data)
                data.data.forEach(function(object) {
                    var option = document.createElement('option');
                    option.value = object.id;
                    option.innerText = object.name;
                    $('#cinemaBox').append(option);
                });
            }, "json");
        }
        load_cinema();


        var table = $('#dataTable').DataTable({
            ajax: "/api/showrooms/getByCinema/0",
            columns: [{
                    data: 'id'
                },
                {
                    data: 'showroom_number'
                },
                {
                    data: 'seat_count'
                },
                {
                    data: null,
                    render: function(data, type, row) {
                        return '<button name="btn_delete_employee" class="btn btn-outline-danger" onclick="confirmRemoval(this)" > Delete </button> <button name="btn_edit_employee" class="btn btn-outline-secondary" onclick="fillEditForm(this)" data-bs-toggle="modal" data-bs-target="#addEmployeeModal" > Edit </button>';
                    }
                }
            ]
        });

        $('#cinemaBox').change(function() {
            let cinema_id = $('#cinemaBox').val();
            console.log(cinema_id);
            table.ajax.url("/api/showrooms/getByCinema/" + cinema_id).load();
        })
        $("#addStaff").click(function() {
            let SHOWROOMNUM = $('#SHOWROOMNUM').val();
            let CINEMA_ID = $('#cinemaBox').val();
            console.log(CINEMA_ID)
            let action = $("#action").val();
            if (action == "Add") {
                var settings = {
                    "url": "/api/showrooms",
                    "method": "POST",
                    "timeout": 0,
                    "headers": {
                      "Content-Type": "application/json",
                    },
                    "data": JSON.stringify({
                      "showroom_number": SHOWROOMNUM,
                      "cinema_id": CINEMA_ID
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
    
            } else {
                let ID = $("#action").val();
                var settings = {
                    "url": "/api/showrooms/"+ID,
                    "method": "PUT",
                    "timeout": 0,
                    "headers": {
                        "Content-Type": "application/json"
                    },
                    "data": JSON.stringify({
                        "id":ID,
                        "showroom_number" : SHOWROOMNUM
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
        });

        $("#delete-button").on('click', function() {
            let uid = $('#delete-button').attr('uid');
            var settings = {
                "url": "/api/showrooms/"+uid,
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


    })