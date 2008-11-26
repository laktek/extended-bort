require 'digest/sha1'

class User < ActiveRecord::Base
  acts_as_authentic :login_field_validation_options => {:if => :openid_identifier_blank?},
  :password_field_validation_options => {:if => :openid_identifier_blank?}
  
  # Relationships
  has_and_belongs_to_many :roles
  
  #validations
  validate :normalize_openid_identifier
  validates_uniqueness_of :openid_identifier, :allow_blank => true

  # Check if a user has a role.
  def has_role?(role)
    list ||= self.roles.map(&:name)
    list.include?(role.to_s) || list.include?('admin')
  end
  
  #sends password reset instructions
  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.deliver_password_reset_instructions(self)
  end

  # For acts_as_authentic configuration
  def openid_identifier_blank?
    openid_identifier.blank?
  end

private
  def normalize_openid_identifier
    begin
      self.openid_identifier = OpenIdAuthentication.normalize_url(openid_identifier) if !openid_identifier.blank?
    rescue OpenIdAuthentication::InvalidOpenId => e
      errors.add(:openid_identifier, e.message)
    end
  end


  
end
