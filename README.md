### IMR IOC - Indicators of Compromise Security Training

This repo will generate the Terraform configuration needed to provision IMR IOC resources.


***
#### IMG IOC GEN - Generates IMR IOC Resources
- Bash script to execute the python script that generates the IOC EC2 instances.  This script also prepends the Terraform header file to the output from the python script, this generates a runnable Terraform file.
  - [run_imr_ioc_tf.sh](./imr-ioc-gen/run_imr_ioc_tf.sh)


- Terraform template file that represents the header of the IOC Terraform configuration.
  - [ec2-tf-ioc-template-header.txt](./imr-ioc-gen/template/ec2-tf-ioc-template-header.txt)


- Terraform template file that represents the body of the IOC Terraform configuration.
  - [ec2-tf-ioc-template.txt](./imr-ioc-gen/template/ec2-tf-ioc-template.txt)


- The final Terraform generated for provisioning IOC resources.
  - [ec2-imr-ioc.tf](./imr-ioc-tf/ec2-imr-ioc.tf)

***
#### IMR IOC NI - Provision Elastic Network Interfaces

- Bash script for applying the Terraform that provisions elastic network interfaces, it also runs the Terraform "output" to produce the details of the provisioned resources "in Json" that is used by "imr_ioc_tf.py" for provisioning IOC resources.
  - [run_imr_ioc_ni.sh](./imr-ioc-ni/run_imr_ioc_ni.sh)


- The Terraform that provisions elastic network interfaces.  A local variable called `eni_count = 2` specifies the number of ENI resources to be created.
  - [imr_ioc_ni.tf](./imr-ioc-ni/imr_ioc_ni.tf)


- The Json output file from the generated ENI resources.
  - [ni_ips.json](./imr-ioc-ni/ni_ips.json)

***
#### IMR IOC GUAC - Proof of Concept work for using a Python API for RESTFUL calls to Apache Guacamole. 
- POC work that utilizes an existing Python API for RESTFULL calls to Apache Guacamole.
  - [imr_ioc_guac.py](./imr-ioc-guac/imr_ioc_guac.py)

- Actual source file of the Python API for the Apache Guacamole RESTFULL endpoints.
  - [guacapy_source.py](./imr-ioc-guac/guacapy_source.py)

***

#### Steps to Provision IOC for Students
* Step 1
   * Set the `eni_count` local variable in the TF file `imr_ioc_ni.tf`.  IOC requires 2 network interfaces per student. 
   * Run the `run_imr_ioc_ni.sh` bash script to execute the TF and get the Json output.
* Step 2
  * Run the `run_imr_ioc_tf.sh` bash script, this executes the `imr_ioc_tf.py` Python script that generates the IOC Terraform file.
* Step 3
  * Run `terraform apply` to the generated IOC TF file `ec2-imr-ioc.tf`, this will provision IOC student resources. 

***
