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
  boot_command = [
    "<enter><wait1m>",
    "/usr/bin/curl -O http://{{ .HTTPIP }}:{{ .HTTPPort }}/setup.sh<enter><wait5>",
    "/usr/bin/bash setup.sh<enter><wait5>",
  ]
  shutdown_command = "shutdown -P now"
}

build {
  sources = ["sources.virtualbox-iso.archsugar"]

  # Copy bootstrap.sh script to /root/bootstrap.sh
  /*provisioner "file" {*/
  /*sources = [*/
  /*"${path.cwd}/scripts/bootstrap.sh",*/
  /*]*/
  /*destination = "/root/"*/
  /*}*/

  # Upload and execute script
  provisioner "shell" {
    script            = "scripts/bootstrap.sh"
    expect_disconnect = false # TODO set to true
    environment_vars = [
      "BOOTSTRAP_DISK=${var.bootstrap_disk}",
    ]
  }

  /*post-processor "vagrant" {*/
  /*provider_override = "virtualbox"*/
  /*output            = "archsugar_${local.today}.box"*/
  /*}*/
}
