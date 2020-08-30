class UserDecorator < Draper::Decorator
  delegate_all

  def created_at
    model.created_at&.strftime('%B %e %Y') || "-"
  end
end
