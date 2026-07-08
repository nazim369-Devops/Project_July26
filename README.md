# Terraform Azure Foundation – Generic Reusable Modules

A modular Terraform project for provisioning Azure Infrastructure using reusable child modules and environment-specific root modules.

This project follows Terraform best practices by separating infrastructure orchestration from resource implementation, resulting in reusable, scalable, and maintainable modules.

---

# Architecture

```
terraform-azure-foundation/
│
├── child_modules/
│   ├── azurerm_resource_group/
│   ├── azurerm_virtual_network/
│   ├── azurerm_subnet/
│   ├── azurerm_public_ip/
│   ├── azurerm_nic/
│   ├── azurerm_nsg/
│   ├── azurerm_nsg_subnet_association/
│   ├── azurerm_linux_virtual_machine/
│   └── azurerm_bastion/
│
└── environments/
    ├── dev/
    ├── test/
    └── prod/
```

---

# Design Principles

This project is designed around the following principles.

## 1. Root Module as the Orchestrator

The root module is responsible for:

- Creating multiple resources using `for_each`
- Resolving dependencies between modules
- Passing computed values to child modules
- Environment-specific configuration

The child modules never communicate with each other directly.

---

## 2. Child Modules Create a Single Resource

Each child module is responsible for creating **one logical Azure resource**.

Examples:

- One Resource Group
- One Virtual Network
- One Subnet
- One Network Security Group
- One Linux Virtual Machine
- One Bastion Host

The number of resources is controlled only by the root module using `for_each`.

---

## 3. Object-Based Module Inputs

Instead of passing many individual variables, each child module accepts a single object.

Example:

```hcl
variable "linuxvmdetails" {
  type = object({
    name                = string
    resource_group_name = string
    location            = string
    ...
  })
}
```

This keeps module interfaces clean and easier to maintain.

---

## 4. map(object) for Environment Configuration

The environment (`terraform.tfvars`) defines multiple resources using `map(object)`.

Example:

```hcl
vmdetails = {

  vm1 = {
    ...
  }

  vm2 = {
    ...
  }

}
```

The root module iterates over the map using:

```hcl
for_each = var.vmdetails
```

Each module instance receives one object (`each.value`).

---

## 5. Implicit Dependencies

Dependencies are created by passing outputs from one module into another.

Example:

```hcl
resource_group_name =
module.resource_group[each.value.rg_key].name
```

Terraform automatically builds the dependency graph without using explicit `depends_on`.

---

## 6. merge() for Object Enrichment

The root module enriches user input with computed values before passing it to child modules.

Example:

```hcl
linuxvmdetails = merge(
  each.value,
  {
    resource_group_name = module.resource_group[each.value.rg_key].name

    network_interface_id = module.network_interface[each.value.nic_key].id
  }
)
```

The child module receives only the values required to create the resource.

---

## 7. Dynamic Blocks

The Network Security Group module uses Terraform Dynamic Blocks to generate multiple inline security rules.

Example:

```hcl
dynamic "security_rule" {

  for_each = var.nsg.security_rules

  content {

    ...

  }

}
```

This avoids repetitive code while supporting any number of NSG rules.

---

## 8. Child Module Outputs

Every child module exposes only the required outputs.

Example:

```hcl
output "id" {
  value = azurerm_subnet.this.id
}

output "name" {
  value = azurerm_subnet.this.name
}
```

Other modules consume these outputs to establish implicit dependencies.

---

# Modules

Current reusable modules include:

- Azure Resource Group
- Azure Virtual Network
- Azure Subnet
- Azure Public IP
- Azure Network Interface
- Azure Network Security Group
- Azure NSG–Subnet Association
- Azure Linux Virtual Machine
- Azure Bastion Host

---

# Terraform Concepts Demonstrated

- Modular Architecture
- Root and Child Modules
- for_each on Module Blocks
- map(object)
- object Type Constraints
- merge() Function
- Dynamic Blocks
- Implicit Dependencies
- Module Outputs
- Optional Attributes
- Strong Variable Typing
- Nested Objects
- Reusable Infrastructure Modules

---

# Infrastructure Flow

```
terraform.tfvars
        │
        ▼
Root Module
        │
        ├── for_each
        │
        ├── Resolve Dependencies
        │
        ├── merge()
        │
        ▼
Child Module
        │
        ▼
Azure Resource
        │
        ▼
Outputs
        │
        ▼
Consumed by Other Modules
```

---

# Benefits of this Architecture

- Highly reusable modules
- Environment-specific deployments
- Strong type validation
- Minimal code duplication
- Automatic dependency graph
- Easy to extend
- Enterprise-ready module structure
- Clean separation of orchestration and implementation

---

# Future Enhancements

- Azure Key Vault integration
- Availability Sets
- Virtual Machine Scale Sets
- Azure Load Balancer
- Azure Application Gateway
- Azure NAT Gateway
- Azure Route Tables
- Azure Storage Account
- Azure Key Vault Secrets
- Azure Monitor
- GitHub Actions CI/CD
- Remote Backend with Azure Storage

# Engineering Decisions

- Root modules are responsible for orchestration.
- Child modules create one logical Azure resource.
- `for_each` is implemented only at the root module level.
- Child modules accept a single object as input.
- `merge()` is used in the root module to enrich objects with computed values.
- Dependencies are established using module outputs, allowing Terraform to build the execution graph through implicit dependencies.
- Dynamic blocks are used where nested repeatable blocks exist (for example, NSG security rules).
- Child modules expose only the outputs required by downstream modules, keeping module interfaces simple and reusable.