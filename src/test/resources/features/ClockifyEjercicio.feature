Feature:Clockify Workspaces

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = YTdhMjY0MmQtZDhkZS00ZTZhLThiOGItYjBlMDNkZjIyOGU2

  @CreateWorkspace
  Scenario:Crear un Workspace
    Given base url env.base_url_clockify
    And endpoint /v1/workspaces
    And set value "NewWorkSpacesAcademy" of key name in body AddWorkSpaces.json
    When execute method POST
    Then the status code should be 201

  @ListWorkSpace
  Scenario: Listar Espacios de trabajo
    Given base url env.base_url_clockify
    Given endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkSpace = $.[1].id

  @CreateProject
  Scenario: Crear un proyecto para un workspace especifico
    Given call ClockifyEjercicio.feature@ListWorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkSpace}}/projects
    And set value "NewProjectAcademy2" of key name in body AddClient.json
    When execute method POST
    Then the status code should be 201

  @ListProject
  Scenario: Listar Espacios de proyectos
    Given call ClockifyEjercicio.feature@ListWorkSpace
    And base url env.base_url_clockify
    Given endpoint /v1/workspaces/{{idWorkSpace}}/projects
    When execute method GET
    Then the status code should be 200
    * define idProject = $.[0].id

  @ListProjectId
  Scenario: Consultar proyecto en workspace
    Given call ClockifyEjercicio.feature@ListProject
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkSpace}}/projects/{{idProject}}
    When execute method GET
    Then the status code should be 200
    * define idNewProjectAcademy = $.id

  @ListUserId
  Scenario: Consultar proyecto en workspace
    Given call ClockifyEjercicio.feature@ListProjectId
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkSpace}}/projects/{{idNewProjectAcademy}}
    When execute method GET
    Then the status code should be 200
    * define idUser = $.memberships[0].userId

  @EliminarProjecto
  Scenario: eliminar proyecto en workspace
    Given call ClockifyEjercicio.feature@ListProjectId
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkSpace}}/projects/{{idNewProjectAcademy}}
    When ejecutar metodo DELETE
    Then the status code should be 200


  @EditarCampoProyectoWorkspace
  Scenario Outline: agregar algo a la tienda
    Given call ClockifyEjercicio.feature@ListProjectId
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkSpace}}/projects/{{idNewProjectAcademy}}
    And body updateProjectonWorkspace.json
    When execute method PUT
    Then the status code should be 200
    And response should be archived = <public>

    Examples:
      | public |
      | true   |

  @updateProjectUserCostrate
  Scenario Outline: agregar algo a la tienda
    Given call ClockifyEjercicio.feature@ListProjectId
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkSpace}}/projects/{{idNewProjectAcademy}}/users/{{idUser}}/cost-rate
    And body updateProjectUserCostrate.json
    When execute method PUT
    Then the status code should be 200
    And response should be since = <since>

    Examples:
      | since                |
      | 2018-11-29T13:00:46Z |

    @ProjectUserBillablerate
  Scenario Outline: agregar algo a la tienda
    Given call ClockifyEjercicio.feature@ListUserId
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkSpace}}/projects/{{idNewProjectAcademy}}/users/{{idUser}}/hourly-rate
    And body updateProjectUserBillablerate.json
    When execute method PUT
    Then the status code should be 200
    And response should be $.memberships[0].hourlyRate.amount = <amount>

    Examples:
      | amount |
      | 30    |

  @updateProjectEstimate
  Scenario Outline: agregar algo a la tienda
    Given call ClockifyEjercicio.feature@ListProjectId
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkSpace}}/projects/{{idNewProjectAcademy}}/estimate
    And body updateProjectEstimate.json
    When execute method PATCH
    Then the status code should be 200
    And response should be timeEstimate.estimate = <estimate>

    Examples:
      | estimate |
      | PT5H     |

  @updateProjectMemberships
  Scenario Outline: agregar algo a la tienda
    Given call ClockifyEjercicio.feature@ListProjectId
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkSpace}}/projects/{{idNewProjectAcademy}}/memberships
    And body updateProjectMemberships.json
    When execute method PATCH
    Then the status code should be 200
    And response should be $.memberships[0].hourlyRate.amount = <amount>

    Examples:
      | amount |
      | 1190   |


  @updateProjectTemplate
  Scenario Outline: agregar algo a la tienda
    Given call ClockifyEjercicio.feature@ListProjectId
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkSpace}}/projects/{{idProject}}/template
    And body updateProjectTemplate.json
    When execute method PATCH
    Then the status code should be 200
    And response should be template = <template>

    Examples:
      | template |
      | false    |






