variable "disk_size" {
  type        = number
  default     = 40960 # 40 GB
  description = "in megabytes"
}

variable "cpus" {
  type    = number
  default = 2
}

variable "memory" {
  type        = number
  default     = 4096 # 4 GB
  description = "in megabytes"
}

variable "keep_registered" {
  type        = bool
  default     = true
  description = "Keep VM registered /w vbox for easy debugging, disable for CI"
}

variable "bootstrap_disk" {
  type        = string
  default     = "/dev/sda"
  description = "Disk name to be formatted inside VM."
}

variable "bootstrap_luks" {
  type        = string
  default     = "saltsugar"
  description = "LUKS password to unlock root partition."
}
