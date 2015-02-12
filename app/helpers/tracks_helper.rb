module TracksHelper

  def ugly_lyrics(lyrics)
    lines = lyrics.split("\n")

    lines.map! do |line|
      "&#9835; " + h(line) unless line.blank?
    end
    lyrics = lines.join("\n")

    lyrics = "<pre>" + lyrics + "</pre>"

    lyrics.html_safe
  end

end
