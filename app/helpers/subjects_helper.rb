module SubjectsHelper
  def subject_color(subject)
    tile_colors[subject.name.hash % tile_colors.count]
  end
end
