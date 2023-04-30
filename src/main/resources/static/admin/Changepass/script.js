
$(document).ready(function () {
    $('#change-password-form').validate({
    rules: {
        // validation rules here
    },
    messages: {
        // error messages here
    },
    errorElement: 'small',
    errorClass: 'text-danger',
    highlight: function(element, errorClass, validClass) {
        $(element).addClass(errorClass).removeClass(validClass);
    },
    unhighlight: function(element, errorClass, validClass) {
        $(element).removeClass(errorClass).addClass(validClass);
    },
    submitHandler: function(form) {
        // submit form here
        var url = $(form).attr('action');
        var data = {
        currentPassword: $('#password').val(),
        newPassword:  $('#newpassword').val()
        };

        $.ajax({
        type: 'POST',
        url: url,
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function(response) {
            // handle success response
            console.log(response);
            $("#msg-success").css('display', 'flex').text(response)
            $("#msg-failed").css('display', 'none')
        },
        error: function(xhr) {
            // handle error response
            console.log(xhr.responseText);
            $("#msg-failed").css('display', 'flex').text("Có lỗi xảy ra! Vui lòng thử lại sau: " + xhr.responseText)
            $("#msg-success").css('display', 'none')
        }
        });
    },
    invalidHandler: function(form, validator) {
        // prevent form submission on validation failure
        return false;
    }
    });

})