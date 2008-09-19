module ApplicationHelper

  def label *args, &block
    label_text, content, options = args
    (options ||= Hash.new).merge! :class => "form"
    content = capture(&block) if block_given?

    content_tag(:dl, options) do
      content_tag(:dt, content_tag(:label, "#{label_text}: ")) + content_tag(:dd, content.to_s || "")
    end
  end

end
