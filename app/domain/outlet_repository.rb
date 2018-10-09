class OutletRepository
  DEFAULT_TYPE = 'do not know'
  FROM_DATE = 1.weeks.ago

  class << self

    def get_outlets
      invoices = xero_client.Invoice.all(where: { type: 'ACCREC', date_is_greater_than: FROM_DATE})
      outlets = {}
      invoices.each do |invoice|
        if outlets[invoice.contact_id].present?
          outlet = outlets[invoice.contact_id]
        else
          outlet = build_outlet(invoice)
          outlets[invoice.contact_id] = outlet
        end
        build_stock(invoice).each { |i| outlet.add_stock_item(i) }
      end
      puts outlets.to_json
    end

    private

    def xero_client
      @@xero_client = Xeroizer::PrivateApplication.new(ENV['XERO_CONSUMER_KEY'], ENV['XERO_CONSUMER_SECRET'], ENV['XERO_PRIVATE_KEY_PATH'])
    end

    def build_outlet(invoice)
      full_address = invoice.contact.addresses.find { |a| a.type == "POBOX" }
      address = "#{full_address.line1}, #{full_address.city}"
      type = DEFAULT_TYPE
      Outlet.new(invoice.contact_name, address, full_address.postal_code, type)
    end

    def build_stock(invoice)
      invoice.line_items.map do |item|
        Stock.new(item.item_code, nil, item.item_code, invoice.date)
      end
    end
  end
end

# irb(main):003:0> OutletRepository.new.get_outlets.Invoice.all(where: date >= Date.today - 4.months
