// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require underscore
//= require jquery.raty
//= require jquery.minicolors
//= require jquery.minicolors.simple_form
//= require bootstrap-sprockets
//= require gmaps/google
//= require_tree .

function toggleMenu() {
    var x = document.getElementById('slidemenu');
    if (x.style.display === 'none') {
 	    x.style.display = 'block';
    } else {
      x.style.display = 'none';
    }
}

function openNav(){
  var pagemargin = document.getElementById("page-content").style.marginLeft;

  if($(window).width()>767){
    document.getElementById("slidemenu").style.width = "250px";
    document.getElementById("page-content").style.marginLeft = "250px";
  }
  else{
    document.getElementById("slidemenu").style.width = "300px";
    document.getElementById("page-content").style.marginLeft = "auto";

  }
}

function closeNav() {
  document.getElementById("slidemenu").style.width = "0px";
  document.getElementById("page-content").style.marginLeft = "auto";
}

function toggleComment(button){
  var a = $(button).closest("#post").find("#comment-box");
  if(a.css("display") === "none"){
    a.slideDown();
  }else{
    a.slideUp();
  }
}
