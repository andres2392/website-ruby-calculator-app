class User < ApplicationRecord
  has_many :user_pumps
  has_many :pumps, through: :user_pumps
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  def pump_already_tracked?(pump_name)
    pump = Pump.check_db(pump_name)
    return false unless pump
    pumps.where(id: pump.id).exists?
  end
  
  def under_pump_limit?
    pumps.count < 10
  end
  
  def can_track_pump?(pump_name)
    under_pump_limit? && !pump_already_tracked?(pump_name)
  end

  def full_name
   return "#{first_name} #{last_name}" if first_name || last_name
   "Anonymous"
  end
end
