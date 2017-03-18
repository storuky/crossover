["Work with Clients", "Get Paid", "Account", "Other"].each do |category|
  Request::Category.where(name: category).first_or_create
end

@admin = User.where(email: "admin@crossover.com").first_or_create(name: "Admin", password: "123123123")
@admin.add_role :admin

@support_agent = User.where(email: "support@crossover.com").first_or_create(name: "Admin", password: "123123123")
@support_agent.add_role :support_agent