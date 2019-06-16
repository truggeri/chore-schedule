class ChoreDecorator < Draper::Decorator
  delegate_all

  def last_performed
    return "never" if model.last_performed.blank?

    model.last_performed&.strftime("%a, %B %e %Y")
  end

  def perform_next
    model.perform_next&.strftime("%a, %B %e %Y")
  end
end
