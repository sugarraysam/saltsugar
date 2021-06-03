source "virtualbox-iso" "archsugar" {
  guest_os_type        = "ArchLinux_64" # $ VBoxManage list ostypes
  vm_name              = "archsugar_${local.today}"
  disk_size            = var.disk_size
  cpus                 = var.cpus
  memory               = var.memory
  guest_additions_mode = "disable"
  headless             = true
  keep_registered      = var.keep_registered

  iso_url      = "${local.iso_mirror}/archlinux/iso/${local.first_of_month}/archlinux-${local.first_of_month}-x86_64.iso"
  iso_checksum = "file:${local.iso_mirror}/archlinux/iso/${local.first_of_month}/md5sums.txt"

  http_directory   = "${path.root}/http"
  output_directory = "${path.cwd}/_build"

  # EFI enabled VM - https://www.packer.io/docs/builders/virtualbox/iso#creating-an-efi-enabled-vm
  hard_drive_interface = "sata"
  iso_interface        = "sata"
  vboxmanage = [
    ["modifyvm", "{{.Name}}", "--firmware", "EFI"]
  ]

  ssh_username = "root"
  ssh_password = "vagrant"
  ssh_timeout  = "1m"
  # initial boot wait needs to be > 1m
  boot_command = [
    "<enter><wait2m>",
    "/usr/bin/curl -O http://{{ .HTTPIP }}:{{ .HTTPPort }}/setup.sh<enter><wait5>",
    "/usr/bin/bash setup.sh<enter><wait5>",
  ]
  shutdown_command = "shutdown -P now"
}

build {
  sources = ["sources.virtualbox-iso.archsugar"]

  # Allow unprivileged user to write file in /root dir
  provisioner "shell" {
    inline = [
      "mkdir /root/scripts/",
      "chmod -R 0777 /root"
    ]
  }

  # Copy Makefile and bootstrap scripts
  provisioner "file" {
    sources     = ["${path.cwd}/Makefile"]
    destination = "/root/Makefile"
  }

  provisioner "file" {
    sources = [
      "${path.cwd}/scripts/bootstrap.sh",
      "${path.cwd}/scripts/chroot.sh",
    ]
    destination = "/root/scripts/"
  }

  # Bootstrap VM
  provisioner "shell" {
    inline            = ["cd /root && make bootstrap"]
    expect_disconnect = false # even though machine reboots, it will not come back online
    environment_vars = [
      "BOOTSTRAP_DISK=${var.bootstrap_disk}",
      "BOOTSTRAP_LUKS=${var.bootstrap_luks}",
      "BOOTSTRAP_TZ=${var.bootstrap_tz}",
      "BOOTSTRAP_HOSTNAME=${var.bootstrap_hostname}",
      "BOOTSTRAP_SWAP_SIZE_MB=${var.bootstrap_swap_size_mb}",
      "BOOTSTRAP_USER=${var.bootstrap_user}",
      "BOOTSTRAP_USER_PASSWD=${var.bootstrap_user_passwd}",
      "BOOTSTRAP_ROOT_PASSWD=${var.bootstrap_root_passwd}",
    ]
  }
}
