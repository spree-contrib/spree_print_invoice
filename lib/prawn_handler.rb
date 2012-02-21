require 'prawn'

module ActionView
  module TemplateHandlers
    class Prawn 
      def self.register!
        Template.register_template_handler :prawn, self
      end
            
      def self.call(template)
        %(extend #{DocumentProxy}; #{template.source}; pdf.render)
      end
      
      module DocumentProxy
        def pdf
          @pdf ||= ::Prawn::Document.new
        end
        
      private
      
        def method_missing(method, *args, &block)
          pdf.respond_to?(method) ? pdf.send(method, *args, &block) : super
        end
      end
    end
  end
end

ActionView::TemplateHandlers::Prawn.register!
