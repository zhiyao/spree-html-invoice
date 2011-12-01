module HtmlInvoice
  class Engine < Rails::Engine
    

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      Deface::Override.new(:virtual_path => "admin/shared/_order_tabs",
                           :name => "Add buttons to sidebar on order show",
                           :insert_after => ".sidebar",
                           :partial => "admin/orders/html_buttons",
                           :disabled => false)

    end

    # sets the manifests / assets to be precompiled
    initializer "spree.assets.precompile", :group => :assets do |app|
      app.config.assets.precompile += [ 'admin/html-invoice.css' , 'admin/html-receipt.css']
    end

    config.to_prepare &method(:activate).to_proc
  end
end
