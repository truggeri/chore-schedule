class ChoreDecorator < Draper::Decorator
  delegate_all

  def last_performed
    model.last_performed&.strftime("%a, %B %e %Y") || "never"
  end

  def last_performed_long
    model.last_performed&.strftime('%A, %B %e %Y') || "Not yet performed"
  end

  def perform_next
    model.perform_next&.strftime("%a, %B %e %Y")
  end

  def perform_next_summary
    return "Soon" if (Time.now - model.perform_next).abs < 1.day

    overdue_text = model.perform_next.past? ? " overdue" : ""
    h.distance_of_time_in_words(Time.now, model.perform_next) + overdue_text
  end
end
