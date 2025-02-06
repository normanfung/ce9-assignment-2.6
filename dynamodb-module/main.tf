resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  hash_key     = var.hash_key
  range_key    = var.sort_key
  billing_mode = var.billing_mode

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }
  tags = var.tags
}

resource "aws_dynamodb_table_item" "book1" {
  table_name = aws_dynamodb_table.this.name
  hash_key   = var.hash_key
  range_key  = var.sort_key
  for_each   = { for book in var.books : book.ISBN => book }
  item       = <<ITEM
  {
    "ISBN": {"S": "${each.value.ISBN}"},
    "Genre": {"S": "${each.value.Genre}"},
    "Title": {"S": "${each.value.Title}"},
    "Author": {"S": "${each.value.Author}"},
    "Stock": {"N": "${each.value.Stock}"}
  }
  ITEM
}
