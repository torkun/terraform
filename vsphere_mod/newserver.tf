provider "vsphere" {
  user           = "administrator@vsphere.local"
  password       = var.adminpass  # Better use vault
  vsphere_server = "10.0.0.10"
#  insecure       = true
  allow_unverified_ssl = true
}

locals {
   dswitchname         = var.cluster == "another_cluster" ? "vDS-cluster" : "vDS-somecluster"
}

resource "vsphere_virtual_machine" "vm" {
  name                   = var.vmname
  resource_pool_id       = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id           = data.vsphere_datastore.datastore.id
  host_system_id         = data.vsphere_host.host.id
  num_cpus               = var.cpu
  cpu_hot_add_enabled    = var.cpu_hotplug 
  cpu_hot_remove_enabled = var.cpu_hotremove
  memory                 = var.mem
  memory_hot_add_enabled = var.mem_hotplug
  guest_id               = data.vsphere_virtual_machine.template.guest_id

  scsi_type              = data.vsphere_virtual_machine.template.scsi_type

  dynamic "network_interface" {
    for_each = keys(var.network) #data.vsphere_network.network[*].id #other option
    content {
      network_id   = data.vsphere_network.network[network_interface.key].id
      adapter_type = var.network_type != null ? var.network_type[network_interface.key] : data.vsphere_virtual_machine.template.network_interface_types[0]
    }
  }


  disk {
    label            = "disk0"
    size             = var.disksize 
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = var.vmname
        domain    = var.domain
      }
      dynamic "network_interface" {
        for_each = keys(var.network)
        content {
          ipv4_address = var.network[keys(var.network)[network_interface.key]][0]
          ipv4_netmask = "%{if length(var.ipv4submask) == 1}${var.ipv4submask[0]}%{else}${var.ipv4submask[network_interface.key]}%{endif}"
        }
      }
      ipv4_gateway    = var.netgateway["${keys(var.network)[0]}"]
      dns_server_list = var.dns
    }
  }
/* 
  provisioner "remote-exec" {
    inline = [
      "chmod +x /root/ipa",
      "/tmp/ipa",
    ]
    connection {
      type     ="ssh"
      host     = self.default_ip_address
      user     = "root"
      password = ""
  }
 }
*/
}
