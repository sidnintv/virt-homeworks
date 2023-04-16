# Домашнее задание к занятию "7.3. Основы и принцип работы Терраформ"

## Задача 1. Создадим бэкэнд в S3 (необязательно, но крайне желательно).

Если в рамках предыдущего задания у вас уже есть аккаунт AWS, то давайте продолжим знакомство со взаимодействием
терраформа и aws. 

1. Создайте s3 бакет, iam роль и пользователя от которого будет работать терраформ. Можно создать отдельного пользователя,
а можно использовать созданного в рамках предыдущего задания, просто добавьте ему необходимы права, как описано 
[здесь](https://www.terraform.io/docs/backends/types/s3.html).
1. Зарегистрируйте бэкэнд в терраформ проекте как описано по ссылке выше. 

Сделано

все файлы здесь:

```
https://github.com/sidnintv/virt-homeworks/tree/virt-11/07-terraform-03-basic/terraform_AWS
```

<img width="1678" alt="Screenshot 2023-04-17 at 00 52 57" src="https://user-images.githubusercontent.com/43722443/232344664-58cc9fe9-1849-4f50-a72b-223c7b622d93.png">


## Задача 2. Инициализируем проект и создаем воркспейсы. 

1. Выполните `terraform init`:
    * если был создан бэкэнд в S3, то терраформ создат файл стейтов в S3 и запись в таблице 
dynamodb.
    * иначе будет создан локальный файл со стейтами.  
1. Создайте два воркспейса `stage` и `prod`.
1. В уже созданный `aws_instance` добавьте зависимость типа инстанса от вокспейса, что бы в разных ворскспейсах 
использовались разные `instance_type`.
1. Добавим `count`. Для `stage` должен создаться один экземпляр `ec2`, а для `prod` два. 
1. Создайте рядом еще один `aws_instance`, но теперь определите их количество при помощи `for_each`, а не `count`.
1. Что бы при изменении типа инстанса не возникло ситуации, когда не будет ни одного инстанса добавьте параметр
жизненного цикла `create_before_destroy = true` в один из рессурсов `aws_instance`.
1. При желании поэкспериментируйте с другими параметрами и рессурсами.

В виде результата работы пришлите:
* Вывод команды `terraform workspace list`.

<img width="1598" alt="Screenshot 2023-04-17 at 00 18 16" src="https://user-images.githubusercontent.com/43722443/232343566-25be9f11-940c-4d8c-8a8f-496b19362a21.png">

* Вывод команды `terraform plan` для воркспейса `prod`.  

```
➜  terraform_AWS git:(virt-11) ✗ terraform plan -out=s3.tfplan
data.aws_region.current: Reading...
data.aws_caller_identity.current: Reading...
data.aws_region.current: Read complete after 0s [id=us-east-1]
data.aws_ami.ubuntu: Reading...
data.aws_caller_identity.current: Read complete after 1s [id=126591494765]
data.aws_ami.ubuntu: Read complete after 1s [id=ami-0aa2b7722dc1b5612]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.vmubuntu[0] will be created
  + resource "aws_instance" "vmubuntu" {
      + ami                                  = "ami-0aa2b7722dc1b5612"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = true
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_termination              = false
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = "stop"
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.small"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "stv"
      + monitoring                           = true
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + subnet_id                            = "subnet-0dcdedcf7497aadb8"
      + tags                                 = {
          + "Name" = "vmubuntu-instance"
        }
      + tags_all                             = {
          + "Name" = "vmubuntu-instance"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + vpc_security_group_ids               = [
          + "sg-05f3f7b4af3361e8d",
        ]
    }

  # aws_instance.vmubuntu[1] will be created
  + resource "aws_instance" "vmubuntu" {
      + ami                                  = "ami-0aa2b7722dc1b5612"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = true
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_termination              = false
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = "stop"
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.small"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "stv"
      + monitoring                           = true
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + subnet_id                            = "subnet-0dcdedcf7497aadb8"
      + tags                                 = {
          + "Name" = "vmubuntu-instance"
        }
      + tags_all                             = {
          + "Name" = "vmubuntu-instance"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + vpc_security_group_ids               = [
          + "sg-05f3f7b4af3361e8d",
        ]
    }

  # aws_instance.vmubuntu_foreach["0"] will be created
  + resource "aws_instance" "vmubuntu_foreach" {
      + ami                                  = "ami-0aa2b7722dc1b5612"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = true
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_termination              = false
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = "stop"
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.small"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "stv"
      + monitoring                           = true
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + subnet_id                            = "subnet-0dcdedcf7497aadb8"
      + tags                                 = {
          + "Name" = "vmubuntu-instance"
        }
      + tags_all                             = {
          + "Name" = "vmubuntu-instance"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + vpc_security_group_ids               = [
          + "sg-05f3f7b4af3361e8d",
        ]
    }

  # aws_instance.vmubuntu_foreach["1"] will be created
  + resource "aws_instance" "vmubuntu_foreach" {
      + ami                                  = "ami-0aa2b7722dc1b5612"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = true
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_termination              = false
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = "stop"
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.small"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "stv"
      + monitoring                           = true
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + subnet_id                            = "subnet-0dcdedcf7497aadb8"
      + tags                                 = {
          + "Name" = "vmubuntu-instance"
        }
      + tags_all                             = {
          + "Name" = "vmubuntu-instance"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + vpc_security_group_ids               = [
          + "sg-05f3f7b4af3361e8d",
        ]
    }

Plan: 4 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + aws_account_id      = "126591494765"
  + aws_region          = "us-east-1"
  + aws_user_id         = "AIDAR26LQ5JWSSWY7ILPC"
  + instance_id         = [
      + null,
      + null,
    ]
  + instance_private_ip = [
      + null,
      + null,
    ]
  + instance_public_ip  = [
      + null,
      + null,
    ]
  + instance_subnet_id  = [
      + "subnet-0dcdedcf7497aadb8",
      + "subnet-0dcdedcf7497aadb8",
    ]

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Saved the plan to: s3.tfplan

To perform exactly these actions, run the following command to apply:
    terraform apply "s3.tfplan"
```

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
