module Spree
  module HtmlInvoice
    class Engine < Rails::Engine
      isolate_namespace Spree
      engine_name 'spree_html_invoice'      
  
      def self.activate
        Dir.glob(File.join(File.dirname(__FILE__), '../../../app/**/*_decorator*.rb')) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end

        Dir.glob(File.join(File.dirname(__FILE__), '../../../app/overrides/*.rb')) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end

        Deface::Override.new(:virtual_path => "spree/admin/shared/_order_tabs",
                             :name => "Add buttons to sidebar on order show",
                             :insert_after => ".sidebar",
                             :partial => "spree/admin/orders/html_buttons",
                             :disabled => false)
  
      end

      config.autoload_paths += %W(#{config.root}/lib)
      config.to_prepare &method(:activate).to_proc

      initializer "spree_html_invoice.assets.precompile", :after => "spree.assets.precompile" do |app|
        app.config.assets.precompile += [ "admin/html-invoice.css", "admin/html-receipt.css" ]
      end
    end
  end
end
