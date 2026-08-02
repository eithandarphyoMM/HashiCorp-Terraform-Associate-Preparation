locals {
  #  doubles_map = { for key, value in var.numbers_map : key => value * 2 }
}

locals {
  doubles_map = { for key, value in var.numbers_map : key => value * 2 }
  even_map = { for key, value in var.numbers_map : key =>
    value * 2 if value % 2 == 0
  }
}
