Spree::AppConfiguration.class_eval do
  preference :html_invoice_logo_path, :string
  preference :print_buttons, :string
  preference :suppress_anonymous_address, :boolean, :default => true
end

