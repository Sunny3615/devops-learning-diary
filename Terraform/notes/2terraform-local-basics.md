# What confused me

When I first started learning Terraform, I always thought Terraform was an Infrastructure as Code (IaC) tool for provisioning cloud resources.

For example:

- Azure Virtual Machines
- Azure Resource Groups
- AWS EC2
- Google Cloud Storage

Because of that, I was surprised to see that Terraform also provides a **Local Provider**.

My first question was:

> If Terraform is designed for cloud infrastructure, why does it need to manage local files?

# What I learned

I realized that Terraform itself does not know how to communicate with Azure, AWS, or even my local computer.

Terraform delegates this work to **providers**.

A provider is a plugin that knows how to interact with a specific platform.

For example:

- AzureRM Provider → Azure resources
- AWS Provider → AWS resources
- Local Provider → Local resources
- Random Provider → Random values

## Why Does Terraform Provide a Local Provider? What Can You Do with It?

The Local Provider allows Terraform to manage resources on the local machine.

The Terraform language stays the same regardless of which provider is used. The only thing that changes is the platform that Terraform manages.

However, from the [official website](https://registry.terraform.io/providers/hashicorp/local/latest/docs) there is a note:
"Terraform primarily deals with remote resources which are able to outlive a single Terraform run, and so local resources can sometimes violate its assumptions. The resources here are best used with care, since depending on local state can make it hard to apply the same Terraform configuration on many different local systems where the local resources may not be universally available. See specific notes in each resource for more information."

### My understanding

Terraform is primarily designed to manage shared infrastructure.
Local resources only exist on a specific computer, which makes Terraform configurations less portable and harder to reproduce across different environments.
For this reason, the Local Provider is mainly useful for learning, testing, or generating temporary local artifacts, rather than managing production infrastructure.