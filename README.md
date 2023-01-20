# Terraform-prometheus-integration

- Using Terraform To Launch ec2-instance.
- e2-user data script to setup the promethues
- Passing Variables to User-Data uisng variables in Terraform.
- Creating A Prometheus.yml file(custom_config.yml) with cloud based and file based service Discovery setup
- Using null resource for provisioners to copy the config file in the prom server.
- user-data runs the prometheus --config.file="<CUSTOM_CONFIG.yml"
