<%-- 
    Document   : amortizacao-americana
    Created on : 30/03/2018, 05:30:26
    Author     : Andrey Antunes
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
    <%@include file="WEB-INF/jspf/header.jspf" %>
    <%@include file="WEB-INF/jspf/menu.jspf" %>
    <body id="bodyamericana">
        <br/><br/><br/><br/><br/><h1>Amortização Americana</h1>
        <hr/>
        <%
            //inicialização das variaveis
            double divida = 0;
            double juros = 0;
            int tempo = 0;
            //tratamento de erro da variavel divida
            try{
                if(request.getParameter("divida")!= null){
                divida = Double.parseDouble(request.getParameter("divida"));
                }
            }
            catch(Exception ex){
                out.println("<span style='color:red;'>Você entrou com um número no formato inválido no campo de Divida. Tente novamente: </span><br>");
            }
            //tratamento de erro da variavel juros
            try{
                if(request.getParameter("juros")!= null){
                juros = Double.parseDouble(request.getParameter("juros"));
                }
            }
            catch(Exception ex){
                out.println("<span style='color:red;'>Você entrou com um número no formato inválido no campo de Juros. Tente novamente: </span><br>");
            }
            //tratamento de erro da variavel tempo
            try{
                if(request.getParameter("tempo")!= null){
                tempo = Integer.parseInt(request.getParameter("tempo"));
                }
            }
            catch(Exception ex){
                out.println("<span style='color:red;'>Você entrou com um número no formato inválido no campo de Tempo. Tente novamente: </span><br>");
            }
        %>
        <center><form>
           <h5>Dívida:</h5> <input type='number' step='0.01' min='1' name = 'divida' value = '<%=divida%>'/><br/><br>
           <h5>Juros:</h5> <input type='number' step='0.01' min='1' name = 'juros' value = '<%=juros%>'/><br/><br>
           <h5>Tempo*:</h5> <input type='number' step='0.01' min='1' name = 'tempo' value = '<%=tempo%>'/><br/>
           <h6>*Tempo em meses</h6>
           <input type='submit' value ='Gerar'/><br/><br>
        </form></center>
           <table border='1' class="table table-striped table-bordered table-hover">
               <tr>
                   <th>Período<hr></th>
                   <th>Amortização<hr></th>
                   <th>Parcela<hr></th>
                   <th>Juros<hr></th>
                   <th>Dívida<hr></th>
               </tr>
           <%
               DecimalFormat arredonda = new DecimalFormat ("#.00");
               double indiceJ = juros/100;
               double parcela = 0;
               double amortizacao = 0;
               double jurosP = 0;
               double parcelaShow = 0;
               double totalA = 0;
               double totalP = 0;
               double totalJ = 0;
               for(int i=0;i<=tempo;i++){
                   if(i == tempo){
               amortizacao = divida;
               divida = divida - amortizacao;
               }
               parcelaShow = jurosP + amortizacao;
           %>
            <tr>
                <td><%=i%><hr></td>
                <td><%=arredonda.format(amortizacao)%><hr></td>
                <td><%=arredonda.format(parcelaShow)%><hr></td>
                <td><%=arredonda.format(jurosP)%><hr></td>
                <td><%=arredonda.format(divida)%><hr></td>
            </tr>
           <%
               jurosP = divida*indiceJ;
               totalJ = jurosP + totalJ;
               if(i>=1){
               totalA = amortizacao + totalA;
               totalP = parcelaShow + totalP;
                } }%>
                <tr>
                <td><b>∑ →</b></td>    
                <td><%=arredonda.format(totalA)%><hr></td>
                <td><%=arredonda.format(totalP)%><hr></td>
                <td><%=arredonda.format(totalJ)%><hr></td>
                <td>-<hr></td>
                </tr>
           </table>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
    </body>
</html>