    $(function() {
        console.log("run")
        $("#Client").addClass("btn-dark")
    })
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
                $('#EMAIL').val(data.email)
                $('.pass').hide();
                $('#NAME').val(data.name)
                $('#ADDRESS').val(data.address)
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
                    data : "name"
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
                        return ' <button name="btn_edit_employee" class="btn btn-outline-secondary" onclick="fillEditForm(this)" data-bs-toggle="modal" data-bs-target="#addEmployeeModal" > Edit </button>';
                    }
                }
            ]
        });
        $("#add").click(function() {
            let ADDRESS = $("#ADDRESS").val()
            let FIRSTNAME = $("#NAME").val();
            let EMAIL =  $("#EMAIL").val();
            let action = $("#action").val();
            console.log(action);
            if (action == "Add") {
                var settings = {
                    "url": "/api/users",
                    "method": "POST",
                    "timeout": 0,
                    "headers": {
                        "Content-Type": "application/json"
                    },
                    "data": JSON.stringify({
                      "name": FIRSTNAME,
                      "email": EMAIL,
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
                      "id": ID,
                      "name": FIRSTNAME ,
                      "email": EMAIL,
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
               
                $("#action").val("Add");
            }
            clearForm()
        });

        $("#delete-button").on('click', function() {
            let uid = $('#delete-button').attr('uid');
            var settings = {
                "url": "/api/users/"+uid,
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
        document.getElementById("student_name").innerHTML = tds[3].innerText;
        console.log(tds[2].innerText)
        $('#delete-button').attr('uid', tds[0].innerHTML)
        var myModal = new bootstrap.Modal(document.getElementById("confirm-removal-modal"), {});
        myModal.show();
    }
    $('#addEmployeeModal').on('hidden.bs.modal', function() {
        clearForm()
    })

    function clearForm() {
        $('#EMAIL').val("")
        $('#NAME').val("")
        $('#ADDRESS').val("")
    }
    