class Reservation < ApplicationRecord
  belongs_to :car
  belongs_to :client
  belongs_to :user


  validates_presence_of :price

  validate :end_date_after_start_date?
  def end_date_after_start_date?
    if end_date < start_date
      errors.add :end_date, "must be after start date"
    end
  end


end
