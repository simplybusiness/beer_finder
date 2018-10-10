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
      assign_geolocation(outlet)
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
    BeerFinderPrivateApplication.new(
      ENV['XERO_CONSUMER_KEY'], ENV['XERO_CONSUMER_SECRET'], ENV['XERO_PRIVATE_KEY']
    )
  end

  def self.address(contact)
    contact.addresses.find { |a| a.type == "POBOX" }
  end

  def self.assign_geolocation(outlet)
    coords = CoordinatesQuery.for_postcode(outlet.postcode)
    if coords.empty?
      puts "Could not get geolocation for #{outlet.postcode}"
      return
    end
    outlet.lat = coords.first
    outlet.long = coords.last
    outlet.save
  end
end

class BeerFinderPrivateApplication < Xeroizer::PrivateApplication
  def initialize(consumer_key, consumer_secret, path_to_private_key, options = {})
    options[:signature_method] = 'RSA-SHA1'
    options[:private_key] = path_to_private
    super(consumer_key, consumer_secret, options)
    @client.authorize_from_access(consumer_key, consumer_secret)
  end
end
