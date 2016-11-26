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
//= require turbolinks
//= require_tree .


$(function(){initialize()});

function initialize(){
    $("#editCVButton").on("click", onCickCVButton);
    $("#saveButton").on("click", onClickSaveButton);
    
}

function onSubjectMouseOver(e){
    $(this).toggleClass("over_subject");
    if (requisitos[$(this).data("code")]) {
        requisitos[$(this).data("code")].forEach(function(req) {
            $("[data-code="+req+"]").addClass("requisite");
        });
    }
}

function onCickCVButton(e){
    $(".subject_inactive").removeClass("subject_inactive").addClass("subject");
    $(".subject").on("mouseover", onSubjectMouseOver);
    $(".subject").on("mouseout", onSubjectMouseOut);
    $(".subject").on("click", onClickSubject);
    
    $(this).css("display", "none");
    $("#saveButton").css("display", "inline-block");
    $(".selectSubjectsHelp").css("display", "block");
}

function onClickSaveButton(e){
    $(".subject").off("mouseover");
    $(".subject").off("mouseout");
    $(".subject").off("click", onClickSubject);
    
    $(".subject").removeClass("subject").addClass("subject_inactive");
    
    $(this).css("display", "none");
    $("#editCVButton").css("display", "inline-block");
    $(".selectSubjectsHelp").css("display", "none");
    
}

function onSubjectMouseOut(e){
    $(this).toggleClass("over_subject");
    $(".subject").removeClass("requisite");
}

function onClickSubject(e){
    $(this).toggleClass("coursed");
}