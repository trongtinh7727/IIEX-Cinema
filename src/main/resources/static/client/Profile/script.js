

$(document).ready(function() {
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

        const swiper = new Swiper("#toppartSwiper", {
            effect: "coverflow",
            grabCursor: true,
            centeredSlides: true,
            slidesPerView: "auto",
            coverflowEffect: {
                rotate: 50,
                stretch: 0,
                depth: 100,
                modifier: 1,
                slideShadows: true,
            },
            navigation: {
                nextEl: ".swiper-button-next",
                prevEl: ".swiper-button-prev",
            }
        });

        swiper.on('transitionEnd', function() {
            var newSrc = $('.swiper-slide-active .swiper-slide-inner-right-main input[type="hidden"]').val();
            $('#trailerswiper').attr('src', newSrc);
        });

        $("#swiper-slide-inner-movie-trailer-modal").on("hidden.bs.modal", function() {
            $('.swiper-trailer-video').attr('src', $('.trailer-video').attr('src'));
        });

        $('#bookingHistoryDataTable').DataTable();

        // When the modal is shown
        $('#historyItemModal').on('show.bs.modal', function (e) {
            // Get the booking ID from the trigger element
            var bookingId = $(e.relatedTarget).data('booking-id');
            
            // Make the AJAX call to get transaction details
            $.ajax({
                url: '/api/transactions/getbyid/' + bookingId,
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    // Fill the modal content with the transaction details
                    // var modalBody = $('#historyItemModal').find('.modal-body');
                    console.log(data)
                    $('#TITLE').text(data['title']);
                    var startTime = moment(data['startime']).format('HH:mm - DD/MM/YYYY');
                    $('#ySTARTTIME').text(startTime);
     
                    $('#CINEMA').text(data['cinema']);
                    $('#ADDRESS').text(data['address']);
                    $('#SHOWROOMNUM').text(data['showRoom']);
                    $('#SEATS').text(data['seats']);
                    var created_at = moment(data['created_at']).format('HH:mm - DD/MM/YYYY');
                    $('#yCREATED_AT').text(created_at);
                
                    $('#TICKET_PRICE').text(data['ticketPrice']);
                    $('#FOOD_PRICE').text(data['foodPrice']);
                    $('#Total').text(data['totalPrice']);
                },
                error: function() {
                    alert('Error getting transaction details');
                }
            });
        });
    });