# What did I do?

I used Terraform to create an Azure VM following the Microsoft documentation:

https://learn.microsoft.com/zh-cn/azure/virtual-machines/linux/quick-create-terraform?tabs=azure-cli

## My confusion / thinking

At first, I only used a single `main.tf` file to create a resource group.  
The structure was simple and easy to understand.

However, deploying a VM was much more complex, and I wanted to better understand:
- the Terraform project structure
- the purpose of each file
- how variables are shared across different files

During the practice, I also got confused about:
- providers
- resource types
- attributes

# What I learned

## Common Terraform Project Structure

A typical Terraform project is usually organized like this:

```text
project/
├── provider.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
```

File explanation

| File | Purpose |
|---|---|
| provider.tf | Provider configuration |
| main.tf | Core infrastructure resources |
| variables.tf | Input variable definitions |
| outputs.tf | Output values |
| terraform.tfvars | Actual variable values |

## Understanding Terraform Resources

```hcl
#providers.tf
terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}
```

```hcl
#variables.tf
variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}
```

```hcl
#main.tf
resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}
```
### Key Concepts

#### Provider

A provider allows Terraform to communicate with external platforms.

Examples:
- azurerm → Azure
- random → Random value generator

#### Resource Type

random_pet - This defines the type of resource Terraform should create.

#### Resource Name

rg-name - This is the local resource name used for referencing inside Terraform.

random_pet.rg-name to call this name.

#### Argument

prefex - Arguments configure the behavior of a resource. In this case, the prefix will be added before the generated random name.

#### Attribute

random_pet.rg_name.id - The `id` is an attribute returned by the provider after the resource is created.

## What Happens Internally

When Terraform runs:
1. Terraform creates: resource "random_pet" "rg_name"

2. The provider returns a generated value such as: rg-happy-lion

3. Terraform stores the returned attribute as: random_pet.rg_name.id. This value can then be referenced by other resources.

## Understanding `var`

```hcl
var.resource_group_location
```

At first, I was confused about why Terraform could find variables using only `var`.

I later learned that:

- `var` is Terraform's built-in variable namespace
- variables are defined in `variables.tf`
- Terraform automatically loads them into the `var` namespace

Example:

```hcl
variable "resource_group_location" {}
```

# Terraform Block Types

Terraform configuration is built using different block types.

| Block Type | Purpose |
|---|---|
| resource | Defines infrastructure resources |
| variable | Defines input variables |
| output | Defines output values |
| provider | Configures providers |
| module | Reusable infrastructure modules |
| locals | Local reusable values |
| data | Reads existing external resources |

## Breaking Down the Example

| Part | Meaning |
|---|---|
| resource | Block type |
| random_pet | Resource type |
| rg_name | Resource name |
| prefix | Argument |
| var.resource_group_name_prefix | Expression / reference |

