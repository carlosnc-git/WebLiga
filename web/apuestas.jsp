<%-- 
    Document   : apuestas
    Created on : 11-feb-2019, 21:15:11
    Author     : carlos
--%>

<%@page import="java.util.List"%>
<%@page import="model.PorraInfo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
List<PorraInfo> listado = (List<PorraInfo>) request.getAttribute("listadoApuestas");
if (listado.size() == 0) {%>
    <h5 class="bg-primary text-white text-center"> Sin apuestas...</h5>
<%} else {%>
<table class="table table-borderless">
    <thead>
        <%for (PorraInfo pi : listado) {%>
        <tr>
            <th scope="col"><%=pi.getGolesLocal()+"-"+pi.getGolesVisitante()+"  ->  "+pi.getApuestas()+" Apuestas"%></h5></th>
        </tr>
        <%}%>
    </thead>
</table>
<%}
%>
