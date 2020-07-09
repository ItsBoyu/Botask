# frozen_string_literal: true

namespace :db do
  desc 'Encrypt passwords which created before User has secure password'
  task encrypt_password: :environment do
    puts 'Prepare to encrypt the passwords'
    unencrypted = User.where.not(password: nil)

    puts 'Encrypting the passwords'
    unencrypted.each do |user|
      user.password_digest = BCrypt::Password.create(user.password)
      user.password = nil
      user.save
    end

    puts 'Check every password encrypted'
    if unencrypted.present?
      puts 'Fail'
    else
      puts 'Finished!'
    end
  end
end
