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
        var dni = button.data('whatever');
        $.ajax({
            type: "GET",
            url: "Controller?op=apuestas&partido=" + idpartido +"&dniUsuario=" + dni,
            success: function (info) {
                $("#modalinfoapuestas").html(info);
            }
        });
    });
}





