module ApplicationHelper

  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-error"
      when :alert
        "alert-block"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end

  def truncate_with_hover(text, options = {})
    return if text.blank?

    options.reverse_merge!(length: 25)

    if text.length > options[:length]
      content_tag :span, truncate(text, options), title: text
    else
      text
    end
  end

end
