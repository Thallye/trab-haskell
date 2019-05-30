$(evento);

function sendReqPost(obj) {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 201) {
         alert("Produto cadastrado");
         window.location.reload();
      }
    };
  xhttp.open("POST", "https://yesod-tycosta.c9users.io/produto", true);
  xhttp.setRequestHeader("Content-Type","application/json");
  //necessario converter objeto para string
  xhttp.send(JSON.stringify(obj));
}



function evento(){
    $("button").click(function(){
        var nome = $("#nome").val();
        var preco = parseFloat($("#preco").val());
        var estoque = parseInt($("#estoque").val());
        sendReqPost({"nome":nome,"preco":preco,"qtEstoque":estoque});
    });
    sendReq();
}

function montaPagina(obj){
    var tabela = "<table> <thead> <tr> <th> NOME </th> <th> PRECO </th> <th> QT </th> </tr> </thead> <tbody>";
    obj.resp.forEach(function(reg){
        tabela = tabela + "<tr> <td> " + reg.nome + "</td> <td> " + reg.preco +  "</td> <td> " + reg.qtEstoque + "</td> </tr>";
    });
    tabela += "</tbody> </table>";
    $(".lista").append(tabela);
}

function sendReq() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
         var objResp = JSON.parse(this.responseText);
         montaPagina(objResp);
      }
    };
  xhttp.open("GET", "https://yesod-tycosta.c9users.io/produtos", true);
  xhttp.setRequestHeader("Content-Type","application/json");
  xhttp.send();
}