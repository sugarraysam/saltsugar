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

# Read BOOTSTRAP_* env vars
variable "bootstrap_disk" {
  type        = string
  default     = env("BOOTSTRAP_DISK")
  description = "Disk to be partitioned."
}

variable "bootstrap_luks" {
  type        = string
  default     = env("BOOTSTRAP_LUKS")
  description = "LUKS password to unlock root partition."
}

variable "bootstrap_tz" {
  type        = string
  default     = env("BOOTSTRAP_TZ")
  description = "Timezone for new system."
}

variable "bootstrap_hostname" {
  type        = string
  default     = env("BOOTSTRAP_HOSTNAME")
  description = "Hostname for new system."
}

variable "bootstrap_swap_size_mb" {
  type        = string
  default     = "16"
  description = "Size of /swapfile in MB. Use smaller size for faster testing."
}

variable "bootstrap_user" {
  type        = string
  default     = env("BOOOTSTRAP_USER")
  description = "Username for unprivileged user."
}

variable "bootstrap_user_passwd" {
  type        = string
  default     = env("BOOOTSTRAP_USER_PASSWD")
  description = "Password for unprivileged user."
}

variable "bootstrap_root_passwd" {
  type        = string
  default     = env("BOOOTSTRAP_ROOT_PASSWD")
  description = "Root password."
}
