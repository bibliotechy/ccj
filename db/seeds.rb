User.where({email: "admin@ccj.org"})
  .first_or_create do |user|
    user.password = "ccjadmin"
  end unless Rails.env.production?
