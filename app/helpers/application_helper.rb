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

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end  
  
  def gravatar_url(email, size)
    gravatar_id = Digest::MD5::hexdigest(email).downcase
    "http://www.gravatar.com/avatar/#{gravatar_id}?s=25&d=identicon&s=#{size}" 
  end

end
