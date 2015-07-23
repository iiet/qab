module QuestionSetsHelper
  def question_set_color(qs)
    tile_colors[Zlib::crc32(qs.name) % tile_colors.count]
  end
end
