#!/usr/bin/env bash

terraform apply -auto-approve
terraform output -json > ni_ips.json
