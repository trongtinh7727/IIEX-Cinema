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
