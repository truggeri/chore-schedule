module ChoresHelper
  def time_until_next_due(chore)
    distance = distance_of_time_in_words(Time.now, chore.perform_next)
    distance << " overdue" if chore.perform_next.past?
    distance
  end
end
