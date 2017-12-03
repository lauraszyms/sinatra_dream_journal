class User < ActiveRecord::Base
  has_secure_password
  has_many :dreams

  def slug
    self.username.strip.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
   self.all.find { |s| s.slug == slug }
  end
end
