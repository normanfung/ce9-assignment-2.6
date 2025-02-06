module "dynamodb_table" {
  source       = "./dynamodb-module"
  table_name   = "norman-bookinventory-terraform"
  hash_key     = "ISBN"
  sort_key     = "Genre"
  billing_mode = "PAY_PER_REQUEST"


  attributes = [
    {
      name = "ISBN"
      type = "S"
    },
    {
      name = "Genre"
      type = "S"
    }
  ]

  books = [{
    ISBN   = "978-0134685991"
    Genre  = "Technology"
    Title  = "Effective Java"
    Author = "Joshua Bloch"
    Stock  = 1
    }, {
    ISBN   = "978-0134685009"
    Genre  = "Technology"
    Title  = "Learning Python"
    Author = "Mark Lutz"
    Stock  = 2
  }]

  tags = {
    Environment = "dev"
    Application = "norman-dynamoDB"
  }
}
