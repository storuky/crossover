["Work with Clients", "Get Paid", "Account", "Other"].each do |category|
  Request::Category.where(name: category).first_or_create
end