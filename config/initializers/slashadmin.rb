SlashAdmin.configure do |c|
  c.authentication_method = :authenticate_user!
  c.current_user_method   = :current_user
  c.compatibility         = :active_admin
end

