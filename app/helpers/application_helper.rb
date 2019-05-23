module ApplicationHelper
    def bootstrap_class_for(flash_type)
        {
          success: "alert-success",
          error: "alert-danger",
          alert: "alert-warning",
          notice: "alert-success"
        }[flash_type.to_sym] || flash_type.to_s
      end
    
      def flash_messages(_opts = {})
        flash.each do |msg_type, message|
          next if msg_type == :form_error
          concat(content_tag(:div, message.html_safe, {
            class: "alert #{bootstrap_class_for(msg_type)} fade in"}) do
              concat content_tag(:button, 'x', class: "close", data: {
                dismiss: 'alert'
              })
              concat message.html_safe
            end)
        end
          nil
      end    
end
