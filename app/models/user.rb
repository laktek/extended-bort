require 'digest/sha1'

class User < ActiveRecord::Base
  acts_as_authentic
  
  # Relationships
  has_and_belongs_to_many :roles

  # Check if a user has a role.
  def has_role?(role)
    list ||= self.roles.map(&:name)
    list.include?(role.to_s) || list.include?('admin')
  end
  
end
