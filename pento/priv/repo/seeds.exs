alias Pento.Catalog

products = [
  %{name: "TV", sku: "abc", unit_price: 1.00, description: "the first product"},
  %{name: "Apple", sku: "abcd", unit_price: 10.00, description: "the second product"}
]

Enum.each(products, fn product -> Catalog.create_product(product) end)
