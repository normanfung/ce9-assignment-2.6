output "table_name" {
  value = aws_dynamodb_table.this.name
}

output "table_arn" {
  value = aws_dynamodb_table.this.arn
}

# output "books_output" {
#   value = { for book in var.books : book.ISBN => book }
# }

# output "books_output2" {
#   value = aws_dynamodb_table_item.book1["978-0134685009"].item
# }
