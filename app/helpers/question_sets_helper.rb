module QuestionSetsHelper
  def question_set_color(qs)
    tile_colors[qs.id.to_s.hash % tile_colors.count]
  end
end
