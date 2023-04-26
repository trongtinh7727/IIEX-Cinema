function fillEditForm(btn) {
        $("#addCinemaModalLabel").val("Update Cinema");
        let tds = $(btn).closest('tr').find('td');
        let ID = tds[0].innerHTML;
        $("#action").val(ID);
        $.get("/api/cinemas/" + ID,  function(data, status) {
            var table = $('#table');
            console.log(data)
                $('#NAME').val(data.name)
                $('#PHONE').val(data.phone)
                $('#ADDRESS').val(data.address)
        }, "json");
    }
    $(document).ready(function() {
        var table = $('#dataTable').DataTable({
            ajax: "/api/cinemas",
            columns: [{
                    data: 'id'
                },
                {
                    data: 'name'
                },
                {
                    data: 'phone'
                },
                {
                    data: 'address'
                },
                {
                    data: null,
                    render: function(data, type, row) {
                        return '<button name="btn_delete_employee" class="btn btn-outline-danger" onclick="confirmRemoval(this)" > Delete </button> <button name="btn_edit_employee" class="btn btn-outline-secondary" onclick="fillEditForm(this)" data-bs-toggle="modal" data-bs-target="#addEmployeeModal" > Edit </button>';
                    }
                }
            ]
        });

        $('#addEmployeeModal').on('hidden.bs.modal', function() {
            clearForm()
        })


        $("#add").click(function() {
            let NAME = $('#NAME').val()
            let PHONE = $('#PHONE').val()
            let ADDRESS = $('#ADDRESS').val()
            let action = $("#action").val();

            if (action == "Add") {
                var settings = {
                    "url": "/api/cinemas",
                    "method": "POST",
                    "timeout": 0,
                    "headers": {
                        "Content-Type": "application/json"
                    },
                    "data": JSON.stringify({
                      "name": NAME,
                      "phone": PHONE,
                      "address": ADDRESS
                    }),
                  };
                  
                  $.ajax(settings).done(function (response) {
                    console.log(response);
                    if (response.status) {
                        console.log("Okee")
                        table.ajax.reload();
                        let msg = response.message;
                        console.log(msg)
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
                    "url": "/api/cinemas/"+ID,
                    "method": "PUT",
                    "timeout": 0,
                    "headers": {
                        "Content-Type": "application/json"
                    },
                    "data": JSON.stringify({
                      "id": ID,
                      "name": NAME,
                      "phone": PHONE,
                      "address": ADDRESS,
                    }),
                  };
                  
                  $.ajax(settings).done(function (response) {
                    console.log(response);
                    if (response.status) {
                        console.log("Okee")
                        table.ajax.reload();
                        let msg = response.message;
                        console.log(msg)
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
            clearForm()
        });


        $("#delete-button").on('click', function() {
            let uid = $('#delete-button').attr('uid');
            var settings = {
                "url": "/api/cinemas/"+uid,
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
        document.getElementById("student_name").innerHTML = tds[1].innerText;
        console.log(tds[2].innerText)
        $('#delete-button').attr('uid', tds[0].innerHTML)
        var myModal = new bootstrap.Modal(document.getElementById("confirm-removal-modal"), {});
        myModal.show();
    }

    function clearForm() {
        $('#NAME').val("");
        $("#PHONE").val("");
        $("#ADDRESS").val("");
    }