$(function() {
    'use strict'; // Start of use strict
    /*------------------------------------------------------------------
            Header Navigation
     ------------------------------------------------------------------*/
    var windowSize = $(window).width();

    if (windowSize >= 767) {
        $('ul.nav li.dropdown').hover(function() {
            $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeIn(500);
        }, function() {
            $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeOut(500);
        });
    }
    /*------------------------------------------------------------------
    	Scrool Top
    ------------------------------------------------------------------*/
    $.scrollUp({
        scrollText: '<i class="fa fa-angle-up"></i>',
        easingType: 'linear',
        scrollSpeed: 900,
        animation: 'fade'
    });
    /*------------------------------------------------------------------
     Loader + Animation Numbers
    ------------------------------------------------------------------*/
    jQuery(window).on("load scroll", function() {
        'use strict'; // Start of use strict
        // Loader 
        $("#dvLoading").fadeOut("fast");

    });
    /*------------------------------------------------------------------
          Submit Property
    ------------------------------------------------------------------*/
    $('.submit-property').find('a').on('click', function() {
        $('.submit-property-popup').show();
    });
    $('.login').find('a').on('click', function() {
        $('.login-popup').show();
    });
    $('.register').find('a').on('click', function() {
        $('.register-popup').show();
    });
    $('.popup').find('.fa-times').on('click', function() {
        $('.popup').hide();
    });
    /*------------------------------------------------------------------
         Price Range for others
    ------------------------------------------------------------------*/
    $(function() {
        $("#slider-range").slider({
            range: true,
            min: 0,
            max: 5000,
            values: [1000, 4000],
            slide: function(event, ui) {
                $("#amount").val("$" + ui.values[0] + " - $" + ui.values[1]);
            }
        });
        $("#amount").val("$" + $("#slider-range").slider("values", 0) +
            " - $" + $("#slider-range").slider("values", 1));
    });
    /*------------------------------------------------------------------
         Price Range for Rent
    ------------------------------------------------------------------*/
    $(function() {
        $("#slider-range1").slider({
            range: true,
            min: 0,
            max: 5000,
            values: [1000, 4000],
            slide: function(event, ui) {
                $("#amount1").val("$" + ui.values[0] + " - $" + ui.values[1]);
            }
        });
        $("#amount1").val("$" + $("#slider-range1").slider("values", 0) +
            " - $" + $("#slider-range1").slider("values", 1));
    });
    /*------------------------------------------------------------------
         Price Range for Buy
    ------------------------------------------------------------------*/
    $(function() {
        $("#slider-range2").slider({
            range: true,
            min: 0,
            max: 5000,
            values: [1000, 4000],
            slide: function(event, ui) {
                $("#amount2").val("$" + ui.values[0] + " - $" + ui.values[1]);
            }
        });
        $("#amount2").val("$" + $("#slider-range2").slider("values", 0) +
            " - $" + $("#slider-range2").slider("values", 1));
    });
    /*------------------------------------------------------------------
         Price Range for popup
    ------------------------------------------------------------------*/
    $(function() {
        $("#slider-range3").slider({
            range: true,
            min: 0,
            max: 5000,
            values: [1000, 4000],
            slide: function(event, ui) {
                $("#amount3").val("$" + ui.values[0] + " - $" + ui.values[1]);
            }
        });
        $("#amount3").val("$" + $("#slider-range3").slider("values", 0) +
            " - $" + $("#slider-range3").slider("values", 1));
    });

    /*------------------------------------------------------------------
        Animation Numbers
    ------------------------------------------------------------------*/
    jQuery('.animateNumber').each(function() {
        var num = jQuery(this).attr('data-num');

        var top = jQuery(document).scrollTop() + (jQuery(window).height());
        var pos_top = jQuery(this).offset().top;
        if (top > pos_top && !jQuery(this).hasClass('active')) {
            jQuery(this).addClass('active').animateNumber({
                number: num
            }, 2000);
        }
    });
});
/*------------------------------------------------------------------
     Testimonials
------------------------------------------------------------------*/
var owl = $('#testimonials');
owl.owlCarousel({
    nav: true,
    margin: 10,
    loop: true,
    responsive: {
        0: {
            items: 1
        },
        450: {
            items: 2
        },
        600: {
            items: 2
        },
        700: {
            items: 2
        },
        1000: {
            items: 2
        },
        1200: {
            items: 2
        },
        1400: {
            items: 3
        },
        1600: {
            items: 2
        }
    }
})
/*------------------------------------------------------------------
     Properites
------------------------------------------------------------------*/
var owl = $("#properties");
owl.owlCarousel({

    nav: true,
    margin: 10,
    loop: true,
    responsive: {
        0: {
            items: 1
        },
        450: {
            items: 1
        },
        600: {
            items: 2
        },
        700: {
            items: 2
        },
        1000: {
            items: 3
        },
        1200: {
            items: 3
        },
        1400: {
            items: 3
        },
        1600: {
            items: 3
        }
    }
});
/*------------------------------------------------------------------
    Villas
------------------------------------------------------------------*/
var owl = $("#villass");
owl.owlCarousel({
    nav: true,
    margin: 10,
    loop: true,
    responsive: {
        0: {
            items: 1
        },
        450: {
            items: 1
        },
        600: {
            items: 2
        },
        700: {
            items: 2
        },
        1000: {
            items: 2
        },
        1200: {
            items: 3
        },
        1400: {
            items: 3
        },
        1600: {
            items: 3
        }
    }

});
/*------------------------------------------------------------------
    Homes
------------------------------------------------------------------*/
var owl = $("#home");
owl.owlCarousel({
    nav: true,
    margin: 10,
    loop: true,
    responsive: {
        0: {
            items: 1
        },
        450: {
            items: 1
        },
        600: {
            items: 2
        },
        700: {
            items: 2
        },
        1000: {
            items: 2
        },
        1200: {
            items: 3
        },
        1400: {
            items: 3
        },
        1600: {
            items: 3
        }
    }

});
/*------------------------------------------------------------------
    Plots
------------------------------------------------------------------*/
var owl = $("#plot");
owl.owlCarousel({
    nav: true,
    margin: 10,
    loop: true,
    responsive: {
        0: {
            items: 1
        },
        450: {
            items: 1
        },
        600: {
            items: 2
        },
        700: {
            items: 2
        },
        1000: {
            items: 2
        },
        1200: {
            items: 3
        },
        1400: {
            items: 3
        },
        1600: {
            items: 3
        }
    }

});
/*------------------------------------------------------------------
    Team
------------------------------------------------------------------*/
var owl = $("#team");
owl.owlCarousel({

    nav: true,
    margin: 10,
    loop: true,
    responsive: {
        0: {
            items: 1
        },
        450: {
            items: 1
        },
        600: {
            items: 2
        },
        700: {
            items: 2
        },
        1000: {
            items: 2
        },
        1200: {
            items: 3
        },
        1400: {
            items: 3
        },
        1600: {
            items: 3
        }
    }

});
/*------------------------------------------------------------------
     Testimonials Page 2 coloum
------------------------------------------------------------------*/
var owl = $("#testimonials2");
owl.owlCarousel({
    nav: true,
    margin: 10,
    loop: true,
    responsive: {
        0: {
            items: 1
        },
        450: {
            items: 2
        },
        600: {
            items: 2
        },
        700: {
            items: 2
        },
        1000: {
            items: 2
        },
        1200: {
            items: 2
        },
        1400: {
            items: 2
        },
        1600: {
            items: 2
        }
    }

});
/*------------------------------------------------------------------
     Testimonials Page 3 coloum
------------------------------------------------------------------*/
var owl = $("#testimonials3");
owl.owlCarousel({
    nav: true,
    margin: 10,
    loop: true,
    responsive: {
        0: {
            items: 1
        },
        450: {
            items: 2
        },
        600: {
            items: 2
        },
        700: {
            items: 2
        },
        1000: {
            items: 3
        },
        1200: {
            items: 3
        },
        1400: {
            items: 3
        },
        1600: {
            items: 3
        }
    }
});
/*------------------------------------------------------------------
     Similar Properites
------------------------------------------------------------------*/
var owl = $("#similar-properties");
owl.owlCarousel({
    nav: true,
    margin: 10,
    loop: true,
    responsive: {
        0: {
            items: 1
        },
        450: {
            items: 1
        },
        600: {
            items: 2
        },
        700: {
            items: 2
        },
        1000: {
            items: 2
        },
        1200: {
            items: 4
        },
        1400: {
            items: 4
        },
        1600: {
            items: 4
        }
    }

});
/*------------------------------------------------------------------
Count Down
------------------------------------------------------------------*/
$('#jcountdown').countdown('2018/06/13 00:00:00', function(event) {
    var $this = $(this).html(event.strftime('' +
        '<span class="countdown-row countdown-show4"><span class="countdown-section"><span class="countdown-amount">%-D</span> <span class="countdown-period">days</span></span>' +
        '<span class="countdown-section"><span class="countdown-amount">%H</span> <span class="countdown-period">Hours</span></span>' +
        '<span class="countdown-section"><span class="countdown-amount">%M</span> <span class="countdown-period">Minutes</span></span>' +
        '<span class="countdown-section"><span class="countdown-amount">%S</span> <span class="countdown-period">Seconds</span></span></span>'));
});
/*------------------------------------------------------------------
	theme color change
------------------------------------------------------------------*/
var theme_settings = $(".theme-settings").find(".theme-color");
theme_settings.on('click', function() {
    var val = $(this).attr('data-color');
    $('#style_theme').attr('href', 'css/' + val + '.css');
    $(".logo-change").attr('src', 'images/logo-' + val + '.png');
    $(".footer-logo-change").attr('src', 'images/footer-logo-' + val + '.png');
    theme_settings.removeClass('theme-active');
    theme_settings.addClass('theme-active');
    return false;
});
$(".theme-click").on('click', function() {
    $("#switcher").toggleClass("active");
    return false;
});