class Goal < ActiveRecord::Base
    belongs_to :user
    validate :deadline_valid?
    
  def deadline_valid?
      if deadline <= Time.zone.now
        errors.add(:deadline, " invalid!")
      end
  end
end
