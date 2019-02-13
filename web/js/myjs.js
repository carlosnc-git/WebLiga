$(document).ready(function () {
    console.log('ready');
    init();
});
function init() {
    loadApuestas();
}
function loadApuestas() {
    $('#modalInfo').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var idpartido = button.data('id');
        console.log('partido' + idpartido);
        $.ajax({
            type: "GET",
            url: "Controller?op=apuestas&partido=" + idpartido,
            success: function (info) {
                $("#modalinfoapuestas").html(info);
            }
        });
    });
}
function apostar() {
    $('#modalApuesta').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var idpartido = button.data('id');
        console.log('partido' + idpartido);
        $.ajax({
            type: "GET",
            url: "Controller?op=menuapuestas&partido=" + idpartido,
            success: function (info) {
                $("#modalinfoapuestas").html(info);
            }
        });
    });
}






