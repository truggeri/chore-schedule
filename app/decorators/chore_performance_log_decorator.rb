class ChorePerformanceLogDecorator < Draper::Decorator
  delegate_all

  def performed_at
    model.created_at&.strftime('%A, %B %e %Y') || "Not yet performed"
  end
end