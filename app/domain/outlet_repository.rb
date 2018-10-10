class OutletRepository
  def self.get_outlets
    Outlet.order(:name)
  end
end
