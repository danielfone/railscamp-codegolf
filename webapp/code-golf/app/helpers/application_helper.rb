module ApplicationHelper

  def render_score(score)
    score or content_tag :span, '-', class: 'text-muted'
  end

end
