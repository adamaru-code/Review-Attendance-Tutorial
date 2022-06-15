class Attendance < ApplicationRecord
  belongs_to :user
  validates :worked_on, presence: true
  validates :note, length: { maximum: 50 }
  
  # 出勤時間が存在しない場合、退勤時間は無効、validate（単数形）メソッド
  validate :finished_at_is_invalid_without_a_started_at
  
  def finished_at_is_invalid_without_a_started_at
    # 「出勤時間が無い、かつ退勤時間が存在する場合」、true
    errors.add(:started_at, "が必要です") if started_at.blank? && finished_at.present? 
  end
end