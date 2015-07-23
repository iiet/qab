module QuestionSetsHelper
  def question_set_color(qs)
    tile_colors[qs.name.to_s.hash % tile_colors.count]
  end
end
