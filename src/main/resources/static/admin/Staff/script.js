    function fillEditForm(btn) {
        $("#addEmployeeModalLabel").val("Update Staff");
        let tds = $(btn).closest('tr').find('td')
        let ID = tds[0].innerHTML;
        $("#action").val(ID);
        $.get("/api/staffs/"+ID, {
        }, function(data, status) {
            var table = $('#table');
            console.log(data)
            // data.data.forEach(function(object) {
                $('#USERNAME').val(data.email)
                $('.pass').hide();
                $('#NAME').val(data.name)
                $('#ADDRESS').val(data.address)
                // $('#SALARY').val(data.salary)
            // });

        }, "json");
    }
    $(document).ready(function() {
          $("#Staff").addClass("btn-dark")

        var table = $('#dataTable').DataTable({
            ajax: "/api/staffs",
            columns: [{
                    data: "id"
                },
                {
                    data: "email"
                },
                {
                    data: "name"
                },
                {
                    data: "address"
                },
                {
                    data: "created"
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
            let USERNAME  = $('#USERNAME').val()
            $('.pass').hide();
            // $('#FNAME').val(data.FIRSTNAME)
            // $('#LNAME').val(data.LASTNAME)
            let NAME =  $('#NAME').val()
            let ADDRESS = $('#ADDRESS').val()
            // let SALARY = $('#SALARY').val()
            let action = $("#action").val();
    
            if (action == "Add") {
                var settings = {
                    "url": "/api/staffs",
                    "method": "POST",
                    "timeout": 0,
                    "headers": {
                        "Content-Type": "application/json"
                    },
                    "data": JSON.stringify({
                       "email": USERNAME,
                       "name" : NAME,
                       "address" : ADDRESS,
                       "salary" : null
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
                    "url": "/api/staffs/"+ID,
                    "method": "PUT",
                    "timeout": 0,
                    "headers": {
                        "Content-Type": "application/json"
                    },
                    "data": JSON.stringify({
                        "id":ID,
                        "email": USERNAME,
                        "name" : NAME,
                        "address" : ADDRESS,
                        "salary" : null
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
            clearForm()
        });

        $("#delete-button").on('click', function() {
            let uid = $('#delete-button').attr('uid');
            var settings = {
                "url": "/api/staffs/"+uid,
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
        console.log(tds[1].innerText)
        $('#delete-button').attr('uid', tds[0].innerHTML)
        var myModal = new bootstrap.Modal(document.getElementById("confirm-removal-modal"), {});
        myModal.show();
    }
    $('#addEmployeeModal').on('hidden.bs.modal', function() {
        clearForm()
    })

    function clearForm() {
        $('#USERNAME').val("")
        $('#FNAME').val("")
        $('#LNAME').val("")
        $('#BIRTHDAY').val("")
        $('#PHONE').val("")
        $('#ADDRESS').val("")
        $('#SALARY').val("")
    }
    $(document).ready(function() {});