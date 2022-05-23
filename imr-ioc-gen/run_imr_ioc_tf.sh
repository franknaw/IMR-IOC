#!/usr/bin/env bash

cat ./template/ec2-tf-ioc-template-header.txt > ../imr-ioc-tf/ec2-imr-ioc.tf
python3 ./imr_ioc_tf.py >> ../imr-ioc-tf/ec2-imr-ioc.tf
