require 'prawn'

module ActionView
  class Template
    module Handlers
      class Prawn
        class << self
          def register
            Template.register_template_handler :prawn, self
          end
          alias_method :register!, :register

          def call(template)
            %(extend #{DocumentProxy}; #{template.source}; pdf.render)
          end
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
end

ActionView::Template::Handlers::Prawn.register!
