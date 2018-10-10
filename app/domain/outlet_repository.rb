class OutletRepository
  def self.get_outlets
    outlets = Outlet.all
    sort_by_name(outlets.to_a)
  end

  def self.sort_by_name(outlets)

    outlets.sort! { |x,y| no_definite_article(x.name) <=> no_definite_article(y.name) }
  end

  def self.no_definite_article(text)
    text.sub /^The /, ''
  end
end
