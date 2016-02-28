Administrator.delete_all
Administrator.create!(
  email: 'hanako@example.com',
  password: 'foobar',
)
Administrator.create!(
  email: 'test@example.com',
  password: 'foobar',
  suspended: true,
)
