#!/bin/bash -e

echo "Simulate Pipeline"

echo "make format"
make format

echo "make lint"
make lint

echo "make tflint"
make tflint

echo "make init-all"
make init-all

echo "make validate"
make validate

echo "make clean"
make clean

echo "make docs"
make docs

# echo "make tfsec"
# make tfsec

echo "pre-commit run -a"
pre-commit run -a
