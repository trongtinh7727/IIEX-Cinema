function fillEditForm(btn) {
    $("#addCinemaModalLabel").val("Update Product");
    let tds = $(btn).closest('tr').find('td');
    let ID = tds[0].innerHTML;
    $("#action").val(ID);
    $.get("/api/products/"+ID, {
    }, function(data, status) {
        var table = $('#table');
        console.log(data)
        // data.data.forEach(function(object) {
            $('#NAME').val(data.name)
            $('#TYPE').val(data.type)
            $('#PRICE').val(data.price)
            $('#QUANTITY').val(data.quantity)
            $('#EXPIRY_DATE').val(moment(data.expiry_date).format("YYYY-MM-DD"))
        // });
    }, "json");
}
$(document).ready(function() {

    var table = $('#dataTable').DataTable({
        ajax: "/api/products",
        columns: [{
                data: 'id'
            },
            {
                data: 'name'
            },
            {
                data: 'type'
            },
            {
                data: 'price'
            },
            {
                data: 'quantity'
            },
            {
                data: null,
                render: function(data, type, row) {
                return moment(data.expiry_date).format('MM/DD/YYYY');
                }
            }
        ]
    });


    $("#add").click(function() {
        let NAME = $('#NAME').val()
        let TYPE = $('#TYPE').val()
        let PRICE = $('#PRICE').val()
        let QUANTITY = $('#QUANTITY').val()
        let EXPIRY_DATE = $('#EXPIRY_DATE').val()
        let action = $("#action").val();

        if (action == "Add") {
            var settings = {
                "url": "/api/products",
                "method": "POST",
                "timeout": 0,
                "headers": {
                    "Content-Type": "application/json"
                },
                "data": JSON.stringify({
                    "name": NAME,
                    "type": TYPE,
                    "price": PRICE,
                    "quantity": QUANTITY,
                    "expiry_date": EXPIRY_DATE
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
                "url": "/api/products/"+ID,
                "method": "PUT",
                "timeout": 0,
                "headers": {
                    "Content-Type": "application/json"
                },
                "data": JSON.stringify({
                    "name": NAME,
                    "type": TYPE,
                    "price": PRICE,
                    "quantity": QUANTITY,
                    "expiry_date": EXPIRY_DATE
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
            "url": "/api/products/"+uid,
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
$('#addEmployeeModal').on('hidden.bs.modal', function() {
    clearForm()
    $("#action").val("Add");
})

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
    $('#NAME').val("")
    $('#TYPE').val("")
    $('#PRICE').val("")
    $('#QUANTITY').val("")
    $('#EXPIRY_DATE').val("")
}
