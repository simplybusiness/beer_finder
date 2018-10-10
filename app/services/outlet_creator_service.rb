class OutletCreatorService
  FROM_DATE = 1.weeks.ago

  def self.create_from_xero(from_date: FROM_DATE)
    invoices = xero_client.Invoice.all(
      where: { type: 'ACCREC', date_is_greater_than: FROM_DATE}
    )
    invoices.select { |invoice| invoice.contact_name != "iZettle AB" }.each do |invoice|
      invoice_address = address(invoice.contact)
      outlet = Outlet.find_or_create_by(
        xero_contact_id: invoice.contact_id,
        name: invoice.contact_name,
        address: "#{invoice_address.line1}, #{invoice_address.city}",
        postcode: invoice_address.postal_code
      )
      invoice.line_items.each do |item|
        outlet.stock_items.find_or_create_by(
          invoice_id: invoice.id,
          name: Utils.get_beer_name(item.item_code),
          style: 'beer',
          serving_style: Utils.serving_style(item.item_code),
          delivery_date: invoice.date
        )
      end
    end
  end


  def self.xero_client
    Xeroizer::PrivateApplication.new(
      ENV['XERO_CONSUMER_KEY'], ENV['XERO_CONSUMER_SECRET'], ENV['XERO_PRIVATE_KEY_PATH']
    )
  end

  def self.address(contact)
    contact.addresses.find { |a| a.type == "POBOX" }
  end
end
