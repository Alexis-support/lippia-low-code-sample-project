Feature:Clockify Workspaces

  Background:
    Given header Content-Type = application/json
    And header Accept = */*


  @CreateWorkspacefallido
  Scenario:Crear un Workspace fallido
    Given base url env.base_url_clockify
    And endpoint /v1/workspaces
    And header x-api-key = YTdhMjY0MmQtZDhkZS00ZTZhLThiOGItYjBlMDNkZjIyOGU2123
    And set value "NewWorkSpacesAcademy" of key asd in body AddWorkSpaces.json
    When execute method GET
    Then the status code should be 401
    And validate schema ClockifyUnauthorized.json

  @CreateWorkspacefallidos
  Scenario:Crear un Workspace fallido
    Given base url env.base_url_clockify
    And endpoint /v1/workspaces
    And header x-api-key = YTdhMjY0MmQtZDhkZS00ZTZhLThiOGItYjBlMDNkZjIyOGU2
    When execute method POST
    Then the status code should be 400
    And validate schema ClockifyBadRequest.json

  @CreateWorkspaceNoEncontrado
  Scenario:Crear un Workspace fallido
    Given base url env.base_url_clockify
    And endpoint /v1/workspacesqweqw
    And header x-api-key = YTdhMjY0MmQtZDhkZS00ZTZhLThiOGItYjBlMDNkZjIyOGU2
    When execute method POST
    Then the status code should be 404
    And validate schema ClockifyNotFound.json