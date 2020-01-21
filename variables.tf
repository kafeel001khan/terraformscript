variable "access_key" {
     default = "AKIA2NLWRWMN3GNAWHFC"
}
variable "secret_key" {
     default = "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"
}
variable "region" {
     default = "us-east-1"
}
variable "availabilityZone" {
     default = "us-east-1a"
}
variable "availabilityZone1" {
     default = "us-east-1b"
}
variable "availabilityZone2" {
     default = "us-east-1c"
}
variable "instanceTenancy" {
    default = "default"
}
variable "dnsSupport" {
    default = true
}
variable "dnsHostNames" {
    default = true
}
variable "vpcCIDRblock" {
    default = "10.0.0.0/16"
}
variable "subnetCIDRblockPublic1" {
    default = "10.0.1.0/24"
}
variable "subnetCIDRblockPublic2" {
    default = "10.0.2.0/24"
}
variable "subnetCIDRblockPublic3" {
    default = "10.0.3.0/24"
}
variable "subnetCIDRblockPrivate1" {
    default = "10.0.4.0/24"
}
variable "subnetCIDRblockPrivate2" {
    default = "10.0.5.0/24"
}
variable "mapPublicIP" {
    default = true
}
variable "destinationCIDRblock" {
    default = "0.0.0.0/0"
}
variable "ingressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "egressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}


variable "PATH_TO_PRIVATE_KEY" {
  default = "lookforward"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "lookforward.pub"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-04b9e92b5572fa0d1"
  }
}

