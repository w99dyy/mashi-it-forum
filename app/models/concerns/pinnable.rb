module Pinnable
    extend ActiveSupport::Concern

    included do
        scope :pinned_first, -> { order(pinned: :desc, created_at: :desc) }
        scope :pinned, -> { where(pinned: true) }
        scope :unpinned, -> { where(pinned: false) }
    end

  def pin!
    update!(pinned: true)
  end

  def unpin!
    update!(pinned: false)
  end

  def pinned?
    pinned == true
  end
end
