# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pento.Repo.insert!(%Pento.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Pento.Catalog
products = [
  %{description: "hello1", name: "bag1", sku: "12345", unit_price: 1},
  %{description: "hello1", name: "bag2", sku: "12345", unit_price: 2},
  %{description: "hello1", name: "bag3", sku: "12345", unit_price: 3}
]
Enum.each(products, fn product -> Catalog.create_product(product) end)
