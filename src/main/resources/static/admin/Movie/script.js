function fillEditForm(btn) {
    $("#addCinemaModalLabel").val("Update Cinema");
    let tds = $(btn).closest('tr').find('td');
    let ID = tds[0].innerHTML;
    $("#action").val(ID);
    $.get("/api/movies/"+ID, {
    }, function(data, status) {
        var table = $('#table');
        console.log(data)
        // data.data.forEach(function(object) {
            $('#TITLE').val(data.title)
            $('#DIRECTOR').val(data.director)
            $('#ACTORS').val(data.actors)
            $('#GENRE').val(data.genre)
            $('#STORY').val(data.story)
            $('#DURATION').val(data.duration)
            $('#OPENING_DAY').val( moment(data.opening_day).format("YYYY-MM-DD"))
            $('#CLOSING_DAY').val( moment(data.closing_day).format("YYYY-MM-DD"))
            $('#POSTER').val(data.poster)
            $('#TRAILER').val(data.trailer)
        // });
    }, "json");
}
$(document).ready(function() {

    var table = $('#dataTable').DataTable({
        ajax: "/api/movies",
        columns: [{
                data: 'id'
            },
            {
                data: 'title'
            },
            {
                data: 'director'
            },
            {
                data: 'actors'
            },
            {
                data: 'genre'
            },
            {
                data: 'duration'
            },
            {
                data: null,
                render: function(data, type, row) {
                return moment(data.opening_day).format('MM/DD/YYYY');
                }
            },
            {   data: null,
                render: function(data, type, row) {
                return moment(data.closing_day).format('MM/DD/YYYY');
                }
            },
            {
                data: null,
                render: function(data, type, row) {
                    return '<button name="btn_delete_employee" class="btn btn-outline-danger" onclick="confirmRemoval(this)" > Delete </button> <button name="btn_edit_employee" class="btn btn-outline-secondary" onclick="fillEditForm(this)" data-bs-toggle="modal" data-bs-target="#addEmployeeModal" > Edit </button>';
                }
            }
        ]
    });


    $("#add").click(function() {
        let TITLE = $('#TITLE').val()
        let DIRECTOR = $('#DIRECTOR').val()
        let ACTORS = $('#ACTORS').val()
        let GENRE = $('#GENRE').val()
        let STORY = $('#STORY').val()
        let DURATION = $('#DURATION').val()
        let OPENING_DAY = $('#OPENING_DAY').val()
        let CLOSING_DAY = $('#CLOSING_DAY').val()
        let POSTER = $('#POSTER').val()
        let TRAILER = $('#TRAILER').val()

        let action = $("#action").val();

        if (action == "Add") {
            var settings = {
                "url": "/api/movies",
                "method": "POST",
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

        } else {
            let ID = $("#action").val();
            var settings = {
                "url": "/api/movies/"+ID,
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
        var settings = {
            "url": "/api/movies/"+uid,
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
    $('#TITLE').val("")
    $('#DIRECTOR').val("")
    $('#ACTORS').val("")
    $('#GENRE').val("")
    $('#STORY').val("")
    $('#DURATION').val("")
    $('#OPENING_DAY').val("")
    $('#CLOSING_DAY').val("")
    $('#POSTER').val("")
    $('#TRAILER').val("")
}
