module SubjectsHelper
  def subject_color(subject)
    tile_colors[subject.id.to_s.hash % tile_colors.count]
  end
end
