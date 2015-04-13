class Link < ActiveRecord::Base
  validates :original_url, presence: true

  default_scope -> { order('original_url DESC') }

  before_create :generate_code

  def generate_code
    self.code = SecureRandom.hex[0..3]
  end
end
