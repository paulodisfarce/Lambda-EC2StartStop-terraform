variable "handler" {
  type    = string
  default = "index" # Nome da função lambda_handler em seu código Python
}

variable "lambda_handler" {
  type    = string
  default = "lambda_handler" # Nome do arquivo Python sem a extensão .py
}

variable "python_ver" {
  type    = string
  default = "python3.11"
}

variable "source_dir" {
  type    = string
  default = "data_python"
}

variable "output_path" {
  type    = string
  default = "index.zip"
}

variable "type" {
  type    = string
  default = "zip"
}

variable "lambda_function_name" {
  type    = string
  default = "EC2STOPSTART_Lambda_Function"
}

variable "timeout" {
  type    = number
  default = 10
}