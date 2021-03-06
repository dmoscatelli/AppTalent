// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require typed
//= require jquery-ui
//= require twitter/bootstrap
//= require jquery_ujs
//= require turbolinks
//= require jquery.turbolinks
//= require_tree .



// For generating a random key for each company


function makeid()
{
    var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    for( var i=0; i < 10; i++ )
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    return text.toUpperCase();
}



$(document).ready(function() {
     $("#mybutton").click( function()
           {
             $("#key").val("");
             $("#key").val( $("#key").val() + makeid());
           }
        );
});


//This is for the homepage key verification

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});


jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

$(document).ready(function() {
  $("#verify-key").submitWithAjax();
});

// End of Key verification


//This is for typed plugin


jQuery(document).ready(function () {
 // jquery typed plugin
    $(".typed").typed({
        stringsElement: $('.typed-strings'),
        typeSpeed: 100,
        backDelay: 1500,
        loop: true,
        contentType: 'html', // or text
        // defaults to false for infinite loop
        loopCount: false,
        callback: function () { null; },
        resetCallback: function () { newTyped(); }
    });
});  
// End of typed plugin


//----------------------------------

// This is for scroll to anchor on homepage 
jQuery(document).ready(function () {
    function scrollToAnchor(aid){
        var aTag = $("a[name='"+ aid +"']");
        $('html,body').animate({scrollTop: aTag.offset().top},'slow');
    }

    scrollToAnchor('anchor-point');


    $("#js-anchor").click(function() {
       scrollToAnchor('anchor-point');
    });
});
// End of scroll to anchor on home page


