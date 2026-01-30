# terraform-module-postgres

Terraform module to manage OVH PostgreSQL instance and resources.

## Description

This module creates and configures an OVH Cloud PostgreSQL database instance with user management. It provisions:
- A managed PostgreSQL database on OVH Cloud
- An admin user with generated credentials

## Prerequisites

- Terraform >= 1.0.0
- OVH provider ~> 2.8.0
- OVH credentials configured (via environment variables or configuration file)
- An existing OVH Cloud project with a private network

## Required environment variables

```bash
export OVH_ENDPOINT=ovh-eu
export OVH_APPLICATION_KEY=your_application_key
export OVH_APPLICATION_SECRET=your_application_secret
export OVH_CONSUMER_KEY=your_consumer_key
```

## Usage

### Basic example

```hcl
module "postgres" {
  source = "git::https://github.com/ansforge/terraform-module-postgres.git?ref=ovh/v1.0.0"

  service_name     = "my-instance-name"
  description      = "Instance user for project-xxxx"
  region           = "eu-west-rbx"
  plan             = "essential"
  flavor           = "db1-4"
  postgres_version = "15"
  network_id       = "your-network-id"
  subnet_id        = "your-subnet-id"
  disk_size        = 20
  node_count       = 1
  admin_username   = "admin"
}
```

### Production example

```hcl
module "postgres" {
  source = "git::https://github.com/ansforge/terraform-module-postgres.git//ovh?ref=v1.0.0"

  service_name        = "your-ovh-project-id"
  description         = "Production PostgreSQL database"
  region              = "eu-west-rbx"
  plan                = "business"
  flavor              = "db1-15"
  postgres_version    = "15"
  network_id          = "your-network-id"
  subnet_id           = "your-subnet-id"
  disk_size           = 100
  node_count          = 3
  admin_username      = "prod_admin"
  deletion_protection = true
}

output "database_uri" {
  value     = module.postgres.database_uri
  sensitive = true
}

output "admin_password" {
  value     = module.postgres.admin_password
  sensitive = true
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `service_name` | OVH Cloud project service name | `string` | n/a | yes |
| `description` | Description of the PostgreSQL instance | `string` | n/a | yes |
| `region` | OVH region for the PostgreSQL instance | `string` | `"eu-west-rbx"` | no |
| `plan` | Plan for the PostgreSQL instance (essential, business, enterprise) | `string` | n/a | yes |
| `flavor` | Flavor for the PostgreSQL instance (e.g., db1-4, db1-7, db1-15) | `string` | n/a | yes |
| `postgres_version` | PostgreSQL version | `string` | n/a | yes |
| `network_id` | Network ID for the PostgreSQL instance | `string` | n/a | yes |
| `subnet_id` | Subnet ID for the PostgreSQL instance | `string` | n/a | yes |
| `disk_size` | Disk size in GB for the PostgreSQL instance | `number` | n/a | yes |
| `node_count` | Number of nodes for the PostgreSQL instance | `number` | n/a | yes |
| `admin_username` | Admin username for the PostgreSQL instance | `string` | n/a | yes |
| `deletion_protection` | Whether to enable deletion protection for the PostgreSQL instance | `bool` | `true` | no |

## Outputs

| Name | Description | Sensitive |
|------|-------------|:---------:|
| `database_uri` | Connection URI for the PostgreSQL database | no |
| `admin_username` | Admin username for the database | no |
| `admin_password` | Admin password for the database | yes |

## Connecting to the database

Once the database is created, you can connect using the generated credentials:

```bash
# Using psql
psql "$(terraform output -raw database_uri)"

# Or with explicit credentials
psql -h <host> -p <port> -U <admin_username> -d defaultdb
```

## License

See [LICENSE](LICENSE) in the parent repository.
