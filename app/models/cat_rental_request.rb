class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, :user_id, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
  validate  :valid_dates
  validate  :no_approved_overlaps

  belongs_to :cat,
    class_name: "Cat",
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy

  belongs_to :requester,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy

  def approve!
    CatRentalRequest.transaction do
      self.status = "APPROVED"
      pending_overlaps = overlapping_pending_requests

      self.save!
      pending_overlaps.each(&:deny!)
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

  def pending?
    status == "PENDING"
  end

  def approved?
    status == "APPROVED"
  end

  private

    def valid_dates
      if start_date < Date.today || start_date > end_date
        errors[:base] << "Those are not valid dates."
      end
    end

    def no_approved_overlaps
      if status == "APPROVED" && overlapping_approved_requests?
        errors[:base] << "There is already an approved rental for those dates."
      end
    end


    def overlapping_requests
      requests_for_cat = self.class.all
                                   .where.not(id: self.id)
                                   .where.not("start_date > ? OR
                                                end_date < ?  ",
                                              self.start_date, self.end_date)
                                   .where(cat_id: self.cat_id)
                                   .order(:start_date)
    end

    def overlapping_approved_requests?
      overlapping_requests.any?(&:approved?)
    end

    def overlapping_pending_requests
      overlapping_requests.select(&:pending?)
    end

end
