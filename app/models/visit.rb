class Visit
  validates :visitor_id, presence: true
  validates :visited_url, presence: true

  def self.record_visit!(user, shortened_url)
    Visit.new({ visitor_id: user.id,
                visited_url: shortened_url.id}
    )
  end

  belongs_to (
    :visitor,
    class_name: "User",
    foreign_key: :visitor_id,
    primary_key: :id
  )

  belongs_to (
    :visited_url,
    class_name: "ShortenedUrl",
    foreign_key: :visited_url,
    primary_key: :id
  )

end
