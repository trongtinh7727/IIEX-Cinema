$('#addEmployeeModal').on('hidden.bs.modal', function() {
        clearForm()
    })

    function fillEditForm(btn) {
        $("#addEmployeeModal").val("Update");
        let tds = $(btn).closest('tr').find('td');
        let ID = tds[0].innerHTML;
        $("#action").val(ID);
        $.get("/api/theaters/"+ID, {
        }, function(data, status) {
            var table = $('#table');
            console.log(data)
            // data.data.forEach(function(object) {
                $('#THEATERNUM').val(data.theaterNumber)
                
            // });
        }, "json");
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
        $('#THEATERNUM').val("")
        $('#SEATCOUNT').val("")
    }

    $(document).ready(function() {
        var table = $('#dataTable').DataTable({
            ajax: "/api/theaters",
            columns: [{
                    data: 'id'
                },
                {
                    data: 'theaterNumber'
                },
                {
                    data: 'seatCount'
                },
                {
                    data: null,
                    render: function(data, type, row) {
                        return '<button name="btn_delete_employee" class="btn btn-outline-danger" onclick="confirmRemoval(this)" > Delete </button> <button name="btn_edit_employee" class="btn btn-outline-secondary" onclick="fillEditForm(this)" data-bs-toggle="modal" data-bs-target="#addEmployeeModal" > Edit </button>';
                    }
                }
            ]
        });


        $("#addStaff").click(function() {
            let THEATERNUM = $('#THEATERNUM').val();
            let action = $('#action').val();
            console.log(THEATERNUM);
            if (action == "Add") {
                var settings = {
                    "url": "/api/theaters",
                    "method": "POST",
                    "timeout": 0,
                    "headers": {
                        "Content-Type": "application/json"
                    },
                    "data": JSON.stringify({
                        "theaterNumber": THEATERNUM
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
                    "url": "/api/theaters/"+ID,
                    "method": "PUT",
                    "timeout": 0,
                    "headers": {
                        "Content-Type": "application/json"
                    },
                    "data": JSON.stringify({
                        "theaterNumber": THEATERNUM
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
            clearForm();
        });

      
        $("#delete-button").on('click', function() {
            let uid = $('#delete-button').attr('uid');
            var settings = {
                "url": "/api/theaters/"+uid,
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