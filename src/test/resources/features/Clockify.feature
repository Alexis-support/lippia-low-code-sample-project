@Clockify
Feature: clockify

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = YTdhMjY0MmQtZDhkZS00ZTZhLThiOGItYjBlMDNkZjIyOGU2


  @ListWorkSpace
  Scenario: Listar Espacios de trabajo
    Given base url https://api.clockify.me/api
    Given endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkSpace = $.[0].id

   @ListClients
   Scenario: Obetener Clientes de un espacio de trabajo
     Given call Clockify.feature@ListWorkSpace
     Given base url https://api.clockify.me/api
     And endpoint /v1/workspaces/{{idWorkSpace}}/clients
     When execute method GET
     Then the status code should be 200
     And the response array is empty

   @AddClienToWorkSpace
   Scenario: Agregar cliente a espacio de trabajo
     Given call Clockify.feature@ListWorkSpace
     And base url https://api.clockify.me/api
     And endpoint /v1/workspaces/{{idWorkSpace}}/clients
     And body AddClient.json
     When ejecutar metodo POST
     Then the status code should be 201
     And response should be name = newClient1
     * define idClient = $.id

    @DeleteClient
    Scenario: Eliminar Cliente del espacio de trabajo
      Given call Clockify.feature@AddClienToWorkSpace
      And base url https://api.clockify.me/api
      And endpoint /v1/workspaces/{{idWorkSpace}}/clients/{{idClient}}
      When execute method DELETE
      Then the status code should be 200