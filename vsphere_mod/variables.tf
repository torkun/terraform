#############################------------Vcenter Username------------##############################
variable "username" {
  type = string
   default = "administrator@vsphere.local"
}

#############################------------Vcenter Password------------##############################
variable "adminpass" {
  type = string
   default = "better to use vault"
}

############################----------New Vm Name From main.tf-------##############################
variable "vmname" {
  type = string
}

############################--------New Domain Name From main.tf-----##############################
variable "domain" {
  type = string
}

############################-----------Datastore From main.tf--------##############################
variable "datastore" {
  type = string
}

############################-----------Datacenter From main.tf-------##############################
variable "datacenter" {
  type = string
}

############################------------Cluster From main.tf---------##############################
variable "cluster" {
  type = string
}

############################-------------Host From main.tf-----------##############################
variable "host" {
  type = string
}

############################------------Vmtemp From main.tf----------##############################
variable "vmtemp" {
  type = string
}

############################-------------Cpu From main.tf------------##############################
variable "cpu" {
  type = string
}

############################-------------Mem From main.tf------------##############################
variable "mem" {
  type = string
}

############################---------Cpu Hotplug From main.tf--------##############################
variable "cpu_hotplug" {
  type = string
}

############################--------Cpu Hotremove From main.tf-------##############################
variable "cpu_hotremove" {
  type = string
}

############################---------Mem Hotplug From main.tf--------##############################
variable "mem_hotplug" {
  type = string
}

############################----------Disksize From main.tf----------##############################
variable "disksize" {
  type = string
  default = "data.vsphere_virtual_machine.template.disks.0.size"
}

############################-------------Dns From main.tf------------##############################
variable "dns" {
  type = list(any)
}

#############################------Network Vlan&IP From main.tf------##############################
variable "network" {
  description = "Define PortGroup and IPs for each VM"
  type        = map(list(string))
  default     = {}
}

#############################---Network Card Type(Null for cloned)---##############################
variable "network_type" {
  description = "Define network type for each network interface."
  type        = list(any)
  default     = null
}

#############################---------------Subnet Mask--------------##############################
variable "ipv4submask" {
  description = "ipv4 Subnet mask."
  type        = list(any)
  default     = ["24"]
}

#############################-----------Vlans from Dswitch-----------##############################
variable "vlans" {
  type = "map" 
  default = {
   "1" = "-Vlan1"
   "2" = "-Vlan2"
   "3" = "-Vlan3" 
   "4" = "-Vlan4"
   "5" = "-Vlan5" 
 } 
}

variable "netgateway" {
  type = "map" 
  default = {
   "1" = "10.0.1.1"
   "2" = "10.0.2.1"
   "3" = "10.0.3.1"
   "4" = "10.0.4.1"
   "5" = "10.0.5.1" 
 } 
}
