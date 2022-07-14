variable "project_id" {
  type        = string
  description = "The ID of the used google project"
}

variable "region" {
  type        = string
  description = "The region in which all resources are deployed"
}

variable "labels" {
  description = "A mapping of labels to assign to the resource"
  type        = map(string)
  default     = {}
}
