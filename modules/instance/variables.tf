variable "env" {
  default = "dev"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "allow_ports" {
  type    = list(any)
  default = ["80", "443","22"]
}

variable "ssh_public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDaeV+i/2722KXuknKoiSy0V4dYwWuO2AFeCxtiEKS2m/5LaAV+Gkhue5Uh+IF03QT6bzVXt5XQycBW7oCP4FuOY5PT7RlmGsCHSW9SM7tSlxodYNJenv5Rv26rD3NEhQVZll0PRm0wse1hAVONyWFbX2d2dRXlVDWZ1AxApb0uYrB5Nc6i8/PtEgA4gkUZZJYOjItxgSdQKsF7CrX66wzI3ZBnZWKL+Q7dEUDhiqu6wRYemIgJf2zXrDBP/C65Mg3RKW8E1xcMXcdIngcxU57zQnlQYvpI9d0Xw5hhbibg8Q8EPTS4zbIDdLgR02sHT7k0oKvNEeG4Y7TKfEgqJI5xEe4h2MLfyut5ZAThMbUw4l8uSS0h6fsMUAqpRIUKYFl3X0iLmT6yZd4v/PaJbKu/u40czeXcNmtsQVjlW/x0nnhHP4rknafhxf3Jm4MHnbeeComSAyk/wrzFrruEBrynE3s/8bqMAV2t1xWXh2B08Nsf49S9agpTSJx0FsCDlsU= user@DESKTOP-53AAPOU"
}
