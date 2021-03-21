# Deploy A Linux VM
module "vshpere_mod" {
  source        = "./vsphere_mod/"
#  version       = "X.X.X"
   vmtemp        = "template"          # Vm template name to clone
   cpu           = 4                   # Number of cpu core
   cpu_hotplug   = true                # Cpu Hotplug (True or False)
   cpu_hotremove = true                # Memory Hotremove (True or False)
   vmname        = "coretest1"         # New Vm name
   domain        = "somedomain.local"  # Domain
   mem           = 2048                # Memory size (MegaBytes)
   mem_hotplug   = true                # Memory Hotplug (True or False)
   disksize      = 30                  # VM Disk Size (GB) 
   dns           = ["8.8.8.8"]         # DNS server Ip Address
   network = {
    "1" = ["10.0.1.11"]                # Vlan from variable.tf = ["ip address"] - To use DHCP create Empty list ["",""]
    "2"  = ["10.0.2.11"]
  }

   datacenter = "SomeDC"             # Datacenter name
   datastore = "Vol_datastore"       # Datastore 
   cluster   = "cluster"             # Cluster
   host      = "10.0.3.11"           # ESX Hostname
}


# To use terraform only for creating VMs
{
resource "null_resource" "mv_state_file" {
  provisioner "local-exec" {
    command = "mv terraform.tfstate* ./tmp/"
  }
}
