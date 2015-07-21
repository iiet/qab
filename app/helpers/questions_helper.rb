module QuestionsHelper
  def render_markdown(markdown)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(hard_wrap: true), autolink: true, tables: true)
    saved_groups = []
    @markdown.render(markdown.gsub(/\^\^(.*)\^\^/) do |s| # a dirty hack to disable markdown rendering between ^^
      saved_groups << s
      "##group-#{saved_groups.size - 1}##"
    end).gsub(/##group-(\d)##/) {|_| saved_groups[$1.to_i]}.html_safe
  end

end
