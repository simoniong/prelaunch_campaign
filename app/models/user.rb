class User < ActiveRecord::Base
  validates :email, presence: true,
                   uniqueness: { case_sensitive: false },
                   format: { :with => /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i, 
                             :message => "Invalid email format." }
  validates :status, inclusion: { in: %w(pending subscribed ) }
  validates :referral_code, :uniqueness => true

  scope :by_referral_code, ->(code) { where(:referral_code => code ) }

  before_create :setup_referral_code

  private

  def setup_referral_code
    referral_code = generate_referral_code
    while conflict_referral_code? referral_code
      referral_code = generate_referral_code
    end
    self.referral_code = referral_code
  end

  def conflict_referral_code?(referral_code)
    User.by_referral_code(referral_code).any?
  end

  def generate_referral_code
    SecureRandom.hex(5)
  end
end
