module WebsitesHelper
    def render_diff(diff)
      return content_tag(:p, "No changes detected") if diff.blank?

      content_tag :div, class: 'diff-container' do
        diff.each_line.map do |line|
            line_type = case line[0]
                        when '+' then 'diff-added'
                        when '-' then 'diff-removed'
                        else 'diff-unchanged'
                        end
            content_tag :div, h(line.chomp), class: line_type
        end.join.html_safe
      end
    end
end