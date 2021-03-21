####################################--------DATACENTER--------######################################

data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

####################################---------DATASTORE--------######################################

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

####################################----------CLUSTER---------######################################

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

####################################-----------HOST-----------######################################

/* Use to let Vcenter decide
data "vsphere_host" "hosts" {
  count         = "${length(var.hosts)}"
  name          = "${var.hosts[count.index]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
*/

data "vsphere_host" "host" {
  name          = var.host
  datacenter_id = data.vsphere_datacenter.dc.id
}

####################################--------DistSWITCH--------######################################
## If you're not using more than one distrubuted switch assignet to clusters, delete condition(delete everything from name line after == ) 
data "vsphere_distributed_virtual_switch" "dvs" {
  name          = var.cluster == "another_cluster" ? "vDS-cluster" : "vDS-somecluster"
  datacenter_id = data.vsphere_datacenter.dc.id
}

####################################---------TEMPLATE---------######################################

data "vsphere_virtual_machine" "template" {
  name          = var.vmtemp
  datacenter_id = data.vsphere_datacenter.dc.id
}

####################################---------NETWORK----------######################################

data "vsphere_network" "network" {
  count         = length(var.network)
  name          = "${local.dswitchname}${var.vlans["${keys(var.network)[count.index]}"]}"
  datacenter_id = data.vsphere_datacenter.dc.id
}

/*
data "vsphere_network" "network" {
  name          = var.vlans["${var.networkvlan}"]
  datacenter_id = data.vsphere_datacenter.dc.id
}
*/
