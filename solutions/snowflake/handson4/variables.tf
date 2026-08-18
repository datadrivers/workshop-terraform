variable "user_suffix" {
  description = "Short user-specific suffix used to make Snowflake object names unique."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9_]+$", var.user_suffix))
    error_message = "user_suffix may contain only letters, numbers, and underscores."
  }
}

variable "warehouse_size" {
  description = "Snowflake warehouse size for the workshop."
  type        = string
  default     = "XSMALL"

  validation {
    condition     = contains(["XSMALL", "SMALL", "MEDIUM"], upper(var.warehouse_size))
    error_message = "warehouse_size must be XSMALL, SMALL, or MEDIUM."
  }
}

variable "warehouse_auto_suspend" {
  description = "Seconds of inactivity before the warehouse suspends."
  type        = number
  default     = 60

  validation {
    condition     = var.warehouse_auto_suspend >= 60
    error_message = "warehouse_auto_suspend must be at least 60 seconds."
  }
}

variable "table_comment" {
  description = "Comment stored on the workshop table."
  type        = string
  default     = "Table created during the Terraform workshop"
}
