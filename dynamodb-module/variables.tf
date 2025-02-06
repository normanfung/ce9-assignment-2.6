variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "hash_key" {
  description = "The hash key (partition key) for the table"
  type        = string
}

variable "billing_mode" {
  description = "Billing Mode"
  type        = string
}

variable "attributes" {
  description = "List of attribute definitions"
  type = list(object({
    name = string
    type = string
  }))
}

variable "tags" {
  description = "Tags to apply to the table"
  type        = map(string)
  default     = {}
}

variable "sort_key" {
  description = "The sort key (range key) for the table"
  type        = string
}

variable "books" {
  description = "Array of books"
  type = list(object({
    ISBN   = string
    Genre  = string
    Author = string
    Stock  = string
    Title  = string
  }))

}
