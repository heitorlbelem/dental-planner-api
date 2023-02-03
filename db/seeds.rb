# frozen_string_literal: true

User.create(
  username: 'admin',
  email: 'admin@sample.com',
  password: 'foobar123',
  first_name: 'Admin',
  last_name: 'Global',
  role: 'admin',
  confirmed_at: Time.zone.now
)

User.create(
  username: 'member',
  email: 'member@sample.com',
  password: 'foobar123',
  first_name: 'Member',
  last_name: 'App',
  role: 'member',
  confirmed_at: Time.zone.now
)
