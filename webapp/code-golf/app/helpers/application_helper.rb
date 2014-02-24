module ApplicationHelper

  def render_score(score)
    score or content_tag :span, '-', class: 'text-muted'
  end

  def leaderboard_header
    html = []
    html << content_tag(:th)
    html << 1.upto(9).map { |hole| content_tag :th, hole }
    html << content_tag(:th, 'OUT')
    html << 10.upto(18).map { |hole| content_tag :th, hole }
    html << content_tag(:th, 'IN')
    html << content_tag(:th, 'TOTAL')
    html.join.html_safe
  end

end
