variable "user_suffix" {
  description = "Short user-specific suffix used to make Snowflake object names unique."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9_]+$", var.user_suffix))
    error_message = "user_suffix may contain only letters, numbers, and underscores."
  }
}
