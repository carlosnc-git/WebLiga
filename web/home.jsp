<%-- 
    Document   : home
    Created on : 11-feb-2019, 11:23:44
    Author     : carlos
--%>

<%@page import="java.util.List"%>
<%@page import="entities.Partido"%>
<%@page import="entities.Jornada"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="es" dir="ltr">

    <head>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Compiled and minified CSS -->
        <link rel="stylesheet" href="css/mycss.css">
        <title>Apuestas</title>
    </head>
    <%
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        List<Jornada> jornadas = (List<Jornada>) session.getAttribute("listaJornadas");
        short idJornada = (short) session.getAttribute("idJornada");
        List<Partido> partidos = (List<Partido>) session.getAttribute("partidos");
        Jornada j = new Jornada();

    %>
    <body>

        <!-- Contenedor principal-->
        <div class="container shadow">
            <div id="header">
                <nav class="navbar navbar-expand-md navbar-dark bg-primary cabecera">
                    <a class="navbar-brand" href="#"><img src="img/liga.png" alt=""></a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav ml-auto" id="menu">
                            <li class="nav-item active">
                                <%                                    if (usuario != null) {
                                %>
                                <form action="Controller?op=logout" method="post">
                                    <label class="text-white"><%=usuario.getNombre()%></label>                                
                                    <button type="submit" class="btn btn-danger" >LOGOUT</button>
                                </form>
                                <%
                                } else {
                                %>
                                <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#exampleModal">LOGIN & REGISTER</button>
                                <%}%>


                            </li>
                        </ul>
                    </div>
                </nav>
            </div>

            <!-- Buscador-->
            <div class="buscador">
                <form class="form-inline" action="Controller?op=dameJornada" method="post" style="display: inline;" >
                    <div class="form-group">
                        <select class="custom-select" id="inputGroupSelect04" name="comboJornada" onchange="this.form.submit()" style="width: 300px">
                            <%
                                if (idJornada == -1) {
                            %>
                            <option selected>Elija Jornada</option>
                            <%} else {%>
                            <option >Elija Jornada</option>
                            <%}
                                for (Jornada jornada : jornadas) {%>            
                            <option <%=(idJornada == jornada.getIdjornada()) ? "selected" : ""%> value="<%=jornada.getIdjornada()%>"><%="Jornada " + jornada.getFechainicio() + "   " + jornada.getFechafin()%></option>      
                            <%}%>
                        </select>
                    </div>
                </form>                
            </div>

            <%
                if (idJornada == -1) {
            %>
            <div id="contenedorprincipal">
                <img id="imagenprincipal" class="img-fluid" alt="Responsive image" src="img/bg.jpg">
            </div>
            <%} else {%>   

            <!-- Tabla-->
            <div id="tabla">
                <table class="w-100 table table-striped text-center table-responsive-xl">
                    <tbody>
                        <%
                            for (Partido partido : partidos) {
                        %>
                        <tr>
                            <%
                                if (usuario != null) {%>
                            <td><button type="button" class="btn btn-danger" data-toggle="modal" data-target="#modalInfo" data-id="<%=partido.getIdpartido()%>">Info</button></td>                       
                            <%}%>                        
                            <td><img alt="" src="<%=partido.getLocal().getEscudo()%>" height="75px"	width="75px"/></td>
                            <td><%=partido.getLocal().getNombre()%></td>
                            <td><%=partido.getGoleslocal()%></td>
                            <td>-</td>
                            <td><%=partido.getGolesvisitante()%></td>
                            <td><%=partido.getVisitante().getNombre()%></td>
                            <td><img alt="" src="<%=partido.getVisitante().getEscudo()%>" height="75px"	width="75px"/></td>
                                <%if (usuario != null) {%>
                            <td><button type="button" class="btn btn-danger" data-id="<%=partido.getIdpartido() %>" data-whatever="<%=partido.getLocal().getNombre()%> - <%=partido.getVisitante().getNombre()%>" data-toggle="modal" data-target="#modalApuesta">Apuesta</button></td>
                            <%}%>                        
                        </tr> 
                        <%}%>
                    </tbody>
                </table>

                <!-- Modal Informacion -->
                <div class="modal fade" id="modalInfo" tabindex="-1" role="dialog" aria-labelledby="modalInfo" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title bg-primary text-warning text-center" id="exampleModalLabel">Información apuestas actuales</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body text-center" id="modalinfoapuestas">
                                <!-- Rellenar con AJAX  -->
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn bg-danger text-black" data-dismiss="modal">Aceptar</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal Apuesta-->
                <div class="modal fade" id="modalApuesta" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel1" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Apuesta</h5>
                     
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            
                            
                            <div class="modal-body">
                                <form action="Controller?op=nuevaApuesta" method="post">
                                <h5 class="text-center" id="partidomodal"></h5>
                                <div class="col-l-2"><input type="text" id="golesLocal" name="golesLocal" class="form-control" placeholder="Gol Local"></div>
                                <div class="col-l-2"><input type="text" id="golesVisitante" name="golesVisitante" class="form-control" placeholder="Gol Visitante"></div>
                                <div class="col-l-2"><input type="hidden" id="idoculto" name="idoculto" class="form-control"></div>
                                <div class="modal-footer">
                                <button type="submit" class="btn">Apostar</button>
                                <button type="button" class="btn" data-dismiss="modal">Cancel </button>
                                </div>
                                </form>
                            </div>
                            
                        </div>
                    </div>
                </div>
                
            </div>

            <%}%> 

        </div>
        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Login & Register</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="Controller?op=login" method="post">
                        <div class="modal-body">                        
                            <div class="form-group">
                                <input type="text" class="form-control" id="dni" name="dni" aria-describedby="dniHelp" placeholder="DNI">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre">
                            </div>                        
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">LOGIN || REGISTER</button>
                            <button type="button" class="btn btn-danger" data-dismiss="modal">CANCEL</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="js/jquery-3.3.1.slim.min.js"></script>
        <script src="js/jquery-1.12.4.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/myjs.js"></script>
    </body>
</html>