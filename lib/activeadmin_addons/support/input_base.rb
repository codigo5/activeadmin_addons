module ActiveAdminAddons
  module InputBase
    include InputOptionsHandler
    include InputMethods
    include InputHtmlHelpers

    def to_html
      load_input_class
      load_control_attributes
      render_custom_input
      if parts.any?
        return input_wrapping { parts_to_html }
      else
        super
      end
    end

    def input_html_options
      super.merge(control_attributes)
    end

    def parts_to_html
      parts.flatten.join("\n").html_safe
    end

    def load_input_class
      load_class(self.class.to_s.underscore.dasherize)
    end

    def load_control_attributes
      # Override on child classes if needed
    end

    def render_custom_input
      # Override on child classes if needed
    end

    def parts
      @parts ||= []
    end

    def concat(part)
      parts << part
    end

    def input_html_model
      input_html_options[:id].chomp('_' + method.to_s)
    end
  end
end
