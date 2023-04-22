    function fillEditForm(btn) {
        $("#addEmployeeModalLabel").val("Update Staff");
        let tds = $(btn).closest('tr').find('td')
        let ID = tds[0].innerHTML;
        $("#action").val(ID);
        $.get("/api/users/"+ID, {
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

        var table = $('#dataTable').DataTable({
            ajax: "/api/users",
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
                // {
                //     data: "salary",
                //     render: $.fn.dataTable.render.number(',', '.', 0, '$')
                // },
                {
                    data: null,
                    render: function(data, type, row) {
                        return '<button name="btn_delete_employee" class="btn btn-outline-danger" onclick="confirmRemoval(this)" > Delete </button> <button name="btn_edit_employee" class="btn btn-outline-secondary" onclick="fillEditForm(this)" data-bs-toggle="modal" data-bs-target="#addEmployeeModal" > Edit </button>';
                    }
                }
            ]
        });


        $("#add").click(function() {
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
                    "url": "/api/users",
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
                    "url": "/api/users/"+ID,
                    "method": "PUT",
                    "timeout": 0,
                    "headers": {
                        "Content-Type": "application/json"
                    },
                    "data": JSON.stringify({
                        "title": TITLE,
                        "genre": GENRE,
                        "director": DIRECTOR,
                        "actors": ACTORS,
                        "duration": DURATION,
                        "rating": 5,
                        "story": STORY,
                        "poster": POSTER,
                        "opening_day": OPENING_DAY,
                        "closing_day": CLOSING_DAY,
                        "trailer": TRAILER
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
            $.post("/api/users", {
                id: uid
            }, function(data, status) {
                console.log(data)
                if (data.status) {
                    table.ajax.reload();
                    let msg = data.data;
                    console.log(msg)
                    $("#msg-success").css('display', 'flex').text(msg)
                    $("#msg-failed").css('display', 'none')
                } else {
                    let msg = data.data;
                    console.log(msg)
                    $("#msg-failed").css('display', 'flex').text("Có lỗi xảy ra! Vui lòng thử lại sau: " + msg)
                    $("#msg-success").css('display', 'none')
                    $('#confirm-removal-modal').modal({
                        show: false
                    });
                }
            }, "json")
        })
    });


    // hiện dialog xác nhận khi xóa
    function confirmRemoval(btn) {
        let tds = $(btn).closest('tr').find('td')
        document.getElementById("student_name").innerHTML = tds[2].innerText;
        console.log(tds[2].innerText)
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