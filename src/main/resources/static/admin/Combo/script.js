$(document).ready(function () {

    var table = $('#dataTable').DataTable({
        ajax: "/api/combofoods",
        columns: [{
            data: 'id'
        },
        {
            data: 'images',
            render: function (data, type, row) {
                return '<img src=../assets/images/foodcombos/' + data + ' width="100" />';
            }
        },
        {
            data: 'name'
        },
        {
            data: 'price',
            render: $.fn.dataTable.render.number(',', '.', 0, '$')
        },
        {
            data: null,
            render: function (data, type, row) {
                return '<button name="btn_delete_employee" class="btn btn-outline-danger" onclick="confirmRemoval(this)"> Delete </button>';
            }
        }
        ]
    });

    $("#add").click(function () {
        let NAME = $('#NAME').val()
        let PRICE = $('#PRICE').val()
        let action = $("#action").val();

        if (action == "Add") {
            // Get the image file from the input element
            var imageFile = $('#Image')[0].files[0];
            // Create a new FormData object
            var formData = new FormData();
            // Append the form data to the FormData object
            formData.append('name', NAME);
            formData.append('price', PRICE);
            formData.append('images', imageFile);

            // Send the POST request with the form data
            $.ajax({
                url: '/api/combofoods',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function (data, status) {
                    console.log(data);
                    if (data.status) {
                        console.log('Okee');
                        table.ajax.reload();
                        let msg = data.message;
                        console.log(msg);
                        $('#msg-success').css('display', 'flex').text(msg);
                        $('#msg-failed').css('display', 'none');
                    } else {
                        let msg = data.message;
                        console.log(msg);
                        $('#msg-failed').css('display', 'flex').text('Có lỗi xảy ra! Vui lòng thử lại sau: ' + msg);
                        $('#msg-success').css('display', 'none');
                    }
                },
                error: function (xhr, status, error) {
                    console.log(xhr.responseText);
                },
                dataType: 'json'
            });
        } else {
            alert("Tính năng không hỗ trợ")
            console.log("Tính năng không hỗ trợ")
        }
        clearForm()
    });


    $("#delete-button").on('click', function () {
        let uid = $('#delete-button').attr('uid');
        var settings = {
            "url": "/api/combofoods/"+uid,
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
$('#addEmployeeModal').on('hidden.bs.modal', function () {
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
    $('#Expiry_Date').val("")
}