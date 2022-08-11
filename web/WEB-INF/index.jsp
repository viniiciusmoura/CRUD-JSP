<%-- 
    Document   : index
    Created on : 25 de jul. de 2022, 15:08:00
    Author     : Vinícius Moura
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="pt">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Usuários</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js" integrity="sha384-Xe+8cL9oJa6tN/veChSP7q+mnSPaj5Bcu9mPX5F5xIGE0DVittaqT5lorf0EI7Vk" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.min.js" integrity="sha384-ODmDIVzN+pFdexxHEHFBQH3/9/vQ9uori45z4JjnFsRydbmQbmL5t1tQ0culUzyK" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs5/dt-1.12.1/datatables.min.css"/>
    <script type="text/javascript" src="https://cdn.datatables.net/v/bs5/dt-1.12.1/datatables.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
  </head>
  <body>
    <div class="container" style="max-width: 50%;">
        <div class="text-center mt-5 mb-4">
            <h1>Lista de usuários</h1>
        </div>
        <div class="row mb-4">
            <div class="col-md-2 ms-md-auto">
                <button type="button" class="btn btn-success">+Adicionar</button>
            </div>
        </div>
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Sobrenome</th>
                    <th>Idade</th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
        
    </div>
    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel"></h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
              <div id="msg"></div>
              <form class="row g-3" action="create" method="post">
                <div class="col-md-6">
                  <label for="inputNome" class="form-label">Nome:</label>
                  <input type="text" name="nome" class="form-control" id="inputNome">
                </div>
                <div class="col-md-6">
                  <label for="inputSobre" class="form-label">Sobrenome:</label>
                  <input type="text" name="sobrenome" class="form-control" id="inputSobre">
                </div>
                <div class="col-md-12">
                  <label for="inputIdade" class="form-label">Idade:</label>
                  <input type="text" name="idade" class="form-control" id="inputIdade">
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary"></button>
                </div>
                  
            </form>
          </div>

        </div>
      </div>
    </div>
      
    <script>
        
    $(document).ready(function (){
        
        //Carregando os dados
        var table = $('.table-hover').DataTable({
            //serverSide: true,
            ajax:  'CRUD-JSP/read',
            columns: [
                { data: 'id' },
                { data: 'nome' },
                { data: 'sobrenome' },
                { data: 'idade' },
                {
                    data: null,
                    className: "dt-center editor-edit",
                    defaultContent: '<i class="bi bi-pencil"/>',
                    orderable: false
                },
                {
                    data: null,
                    className: "dt-center editor-delete",
                    defaultContent: '<i class="bi bi-trash"/>',
                    orderable: false
                }
            ],
            language:{
                url: "https://cdn.datatables.net/plug-ins/1.12.1/i18n/pt-BR.json"
            }
        });

      
      //Abrir modal de cadastrar usuário
      $(".btn-success").click(function(){
        $("#exampleModalLabel").html("Cadastrar Usuário");
        $(".btn-primary").html("Cadastrar");
        $("#msg").html("");
        $("#exampleModal").modal("show");
      })
      
      //Abrir modal de editar usuário
      $(".btn-warning").click(function(){
        $("#exampleModalLabel").html("Editar Usuário");
        $(".btn-primary").html("Salvar");
        $("#exampleModal").modal("show");
      })
      
      //Cadastrar usuário no banco
      $(".btn-primary").click(function (e){
          e.preventDefault();
          $.ajax({
              url: "CRUD-JSP/create",
              method: "post",
              data: $("form").serialize(),
              success: function (data){
                  table.ajax.reload();
                  $("#msg").html("<div class='alert alert-success' role='alert'>"+JSON.parse(data).nome+" cadastrado com sucesso</div>");
                  $("form").trigger("reset");
              },
              error: function(erro){
                  console.log("Ocorreu um erro: "+erro)
              }
              
          })
      })
      
      
    })  
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
  </body>
</html>
