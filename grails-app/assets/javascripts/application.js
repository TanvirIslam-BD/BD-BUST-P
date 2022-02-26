// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better
// to create separate JavaScript files as needed.
//
//= require jquery-3.3.1.min
//= require bootstrap
//= require popper.min
//= require jquery-confirm.min
//= require OBTS
//= require OBTS.message.box
//= require OBTS.ajax
//= require OBTS.init
//= require_self



function createModal(url, page, modalPrefix) {
    var modalContent = 'myModalContent';
    var modalName = "myModal";
    if (typeof (modalPrefix) != 'undefined') {
        modalName = modalPrefix + 'Modal';
        modalContent = modalPrefix + 'ModalContent';
    }
    if (typeof (page) == 'undefined') {
        page = 1;
    }
    $.ajax({
        url: url,
        type: 'GET',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            $('#' + modalContent).html(data);
            $('#' + modalName).modal('show');
            $('#page').val(page);
        },
        error: function (data) {

        }
    });
}
