json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :start, :end, :total, :company
  json.url invoice_url(invoice, format: :json)
end
