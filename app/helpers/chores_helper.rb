module ChoresHelper
  def text_until_next_due(chore)
    if (Time.now - chore.perform_next).abs < 1.day
      text = "Soon"
    else
      text = distance_of_time_in_words(Time.now, chore.perform_next)
      text << " overdue" if chore.perform_next.past?
    end
    text
  end
end
