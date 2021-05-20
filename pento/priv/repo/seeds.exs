alias Pento.Catalog

products = [
  %{name: "TV", sku: 123456, unit_price: 1.00, description: "the first product"},
  %{name: "Apple", sku: 112233, unit_price: 10.00, description: "the second product"}
]

Enum.each(products, fn product -> Catalog.create_product(product) end)
