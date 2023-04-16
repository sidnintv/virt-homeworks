# Домашнее задание к занятию "7.4. Средства командной работы над инфраструктурой."

## Задача 1. Настроить terraform cloud (необязательно, но крайне желательно).

В это задании предлагается познакомиться со средством командой работы над инфраструктурой предоставляемым
разработчиками терраформа. 

1. Зарегистрируйтесь на [https://app.terraform.io/](https://app.terraform.io/).
(регистрация бесплатная и не требует использования платежных инструментов).
1. Создайте в своем github аккаунте (или другом хранилище репозиториев) отдельный репозиторий с
 конфигурационными файлами прошлых занятий (или воспользуйтесь любым простым конфигом).
1. Зарегистрируйте этот репозиторий в [https://app.terraform.io/](https://app.terraform.io/).
1. Выполните plan и apply. 

В качестве результата задания приложите снимок экрана с успешным применением конфигурации.

В настройках workspaces изменил исполнение на local, была проблема с доступом к aws, оставил так потом изучу где надо и как задать параметр доступа, по идее надо в облако добавить ключик или токен, но я этого не хочу.

вот ошибка:
``
Error: error configuring Terraform AWS Provider: no valid credential sources for Terraform AWS Provider found. Please see https://registry.terraform.io/providers/hashicorp/aws for more information about providing credentials. Error: NoCredentialProviders: no valid providers in chain caused by: EnvAccessKeyNotFound: failed to find credentials in the environment. SharedCredsLoad: failed to load profile, . EC2RoleRequestError: no EC2 instance role found caused by: RequestError: send request failed caused by: Get "http://169.254.169.254/latest/meta-data/iam/security-credentials/": context deadline exceeded (Client.Timeout exceeded while awaiting headers)
with provider["registry.terraform.io/hashicorp/aws"]
on main.tf line 1, in provider "aws":
provider "aws" {
``

 вот удачный старт:

<img width="1616" alt="Screenshot 2023-04-15 at 16 59 40" src="https://user-images.githubusercontent.com/43722443/232231016-39b325c2-26d5-4570-b77d-11c4eb3494dd.png">

<img width="1607" alt="Screenshot 2023-04-15 at 16 59 59" src="https://user-images.githubusercontent.com/43722443/232231027-fec5f3a0-800a-408b-88ed-e73da23e3f9a.png">

<img width="1590" alt="Screenshot 2023-04-15 at 17 00 12" src="https://user-images.githubusercontent.com/43722443/232231033-4c70e3e6-5d3c-4153-ac30-a117942b2a73.png">

<img width="1679" alt="Screenshot 2023-04-15 at 17 05 59" src="https://user-images.githubusercontent.com/43722443/232231041-3486b719-5485-44be-8943-71170a7db640.png">

<img width="1678" alt="Screenshot 2023-04-15 at 17 06 16" src="https://user-images.githubusercontent.com/43722443/232231046-39a8b9a7-0a58-4d42-b9ab-8837abbcafe7.png">

<img width="1680" alt="Screenshot 2023-04-15 at 17 06 30" src="https://user-images.githubusercontent.com/43722443/232231049-42fa8f34-f3f8-4ba3-8b61-4ed45b7f4f70.png">

<img width="1672" alt="Screenshot 2023-04-15 at 17 08 02" src="https://user-images.githubusercontent.com/43722443/232231051-a8faad4d-49f0-4adb-a3f4-e930ebf2000b.png">


## Задача 2. Написать серверный конфиг для атлантиса. 

Смысл задания – познакомиться с документацией 
о [серверной](https://www.runatlantis.io/docs/server-side-repo-config.html) конфигурации и конфигурации уровня 
 [репозитория](https://www.runatlantis.io/docs/repo-level-atlantis-yaml.html).

Создай `server.yaml` который скажет атлантису:
1. Укажите, что атлантис должен работать только для репозиториев в вашем github (или любом другом) аккаунте.
1. На стороне клиентского конфига разрешите изменять `workflow`, то есть для каждого репозитория можно 
будет указать свои дополнительные команды. 
1. В `workflow` используемом по-умолчанию сделайте так, что бы во время планирования не происходил `lock` состояния.

Создай `atlantis.yaml` который, если поместить в корень terraform проекта, скажет атлантису:
1. Надо запускать планирование и аплай для двух воркспейсов `stage` и `prod`.
1. Необходимо включить автопланирование при изменении любых файлов `*.tf`.

В качестве результата приложите ссылку на файлы `server.yaml` и `atlantis.yaml`.



`server.yaml`
```
---
atlantis:
  config:
    allow_repo_config: true
    repos:
      - id: sidnintv/.+
        allowed_overrides:
          - workflow
        workflow: default_workflow
    workflows:
      default_workflow:
        plan:
          steps:
            - init
            - plan:
                lock: false
        apply:
          steps:
            - apply
    apply_requirements:
      - approved
      - mergeable
    webhook_secrets:
      sidnintv/.+:
        secret: "your-webhook-secret"
    slack:
      url: "https://hooks.slack.com/services/your-webhook-url"
```

`atlantis.yaml`
```
---
version: 3
automerge: false
projects:
  - name: stage
    dir: .
    workflow: custom_workflow
    terraform_version: v1.4.5
    autoplan:
      enabled: true
      when_modified:
        - "*.tf"
    apply_requirements: []
  - name: prod
    dir: .
    workflow: custom_workflow
    terraform_version: v1.4.5
    autoplan:
      enabled: true
      when_modified:
        - "*.tf"
    apply_requirements: []

workflows:
  custom_workflow:
    plan:
      steps:
        - init
        - workspace
        - plan
    apply:
      steps:
        - workspace
        - apply
```


## Задача 3. Знакомство с каталогом модулей. 

1. В [каталоге модулей](https://registry.terraform.io/browse/modules) найдите официальный модуль от aws для создания
`ec2` инстансов. 
2. Изучите как устроен модуль. Задумайтесь, будете ли в своем проекте использовать этот модуль или непосредственно 
ресурс `aws_instance` без помощи модуля?
3. В рамках предпоследнего задания был создан ec2 при помощи ресурса `aws_instance`. 
Создайте аналогичный инстанс при помощи найденного модуля.   

В качестве результата задания приложите ссылку на созданный блок конфигураций. 

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
