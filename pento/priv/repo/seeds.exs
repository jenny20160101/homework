alias Pento.Catalog

products = [
  %{name: "TV", sku: 123_456, unit_price: 1.00, description: "the first product"},
  %{name: "Apple", sku: 112_233, unit_price: 10.00, description: "the second product"}
]

Enum.each(products, fn product -> Catalog.create_product(product) end)
