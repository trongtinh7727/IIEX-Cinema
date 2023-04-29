$(document).ready(function() {
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
    })
    $(document).ready(function() {
        $('#bookingHistoryDataTable').DataTable();

        $('form').submit(function(event) {
            event.preventDefault();

            var firstName = $('input[name="FIRSTNAME"]').val().trim();
            var lastName = $('input[name="LASTNAME"]').val().trim();
            var birthday = $('input[name="BIRTHDAY"]').val().trim();
            var address = $('input[name="ADDRESS"]').val().trim();
            var phone = $('input[name="PHONE"]').val().trim();

            // Perform validation checks
            var isValid = true;

            if (firstName.length == 0) {
                isValid = false;
                alert('Họ không được để trống');
            }

            if (lastName.length == 0) {
                isValid = false;
                alert('Tên không được để trống');
            }

            if (birthday.length == 0) {
                isValid = false;
                alert('Ngày sinh không được để trống');
            }

            if (address.length == 0) {
                isValid = false;
                alert('Địa chỉ không được để trống');
            }

            if (phone.length == 0) {
                isValid = false;
                alert('Số điện thoại không được để trống');
            }
            var phoneRegex = /^\d{10}$/;

            if (!phoneRegex.test(phone)) {
                isValid = false;
                alert('Số điện thoại không đúng');
            }

            if (!isValid) {
                return false;
            }

            // If all validation checks pass, submit the form
            this.submit();
        });
    });


    $(document).ready(function() {
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