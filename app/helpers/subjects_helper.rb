require 'zlib'
module SubjectsHelper
  def subject_color(subject)
    tile_colors[Zlib::crc32(subject.name) % tile_colors.count]
  end
end
