variable "kubernetes_version" {
  type        = string
  default     = "1.18"
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version is used"
}
variable "key_name" {
  default = "devops-training"
}
variable "image_id" {
  default = "ami-0afeae4543435bb1b"
}
variable "instance_type" {
  default = "t2.small"
}
variable "min_size" {
  type        = number
  description = "The minimum size of the autoscale group"
  default     = 2
}

variable "max_size" {
  type        = number
  description = "The maximum size of the autoscale group"
  default     = 5
}

variable "cluster_security_group_id" {
  type        = string
  description = "Security Group ID of the EKS cluster"
  default     = ""
}
variable "cluster_security_group_ingress_enabled" {
  type        = bool
  description = "Whether to enable the EKS cluster Security Group as ingress to workers Security Group"
  default     = false
}

