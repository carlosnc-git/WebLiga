$(document).ready(function () {
    console.log('ready');
    init();
});
function init() {
    loadApuestas();
    apostar();
}

function apostar(){
      $('#modalApuesta').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var idpartido = button.data('id');
        var nombrepartido = button.data('whatever')
        
        var modal = $(this)
	modal.find('#partidomodal').text(nombrepartido)
        modal.find('#idoculto').val(idpartido)
        
    });
}

function loadApuestas() {
    $('#modalInfo').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var idpartido = button.data('id');
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






