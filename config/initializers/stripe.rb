Rails.configuration.stripe = {
  publishable_key: ENV['pk_test_51Pd0aIJafVTXwyQvVJNgg1nJBsKHXAMsad2gUCD2tjxQeRzSfXc1CVlGYn00bcqXebNtdYJ3wRtmGmc9ydZf85uD00sFcWkO25'],
  secret_key: ENV['sk_test_51Pd0aIJafVTXwyQviiUOdTJxJi8Ub8PBX0TfgP60H0MwQJ8LguRfgLc6Hyt6cqPzFX6A95BKk3BRIPxaqdK9ix7L00enJ6FXbj']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
