User.destroy_all
User.create!(
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password',
    role: :admin,
    first_name: 'Admin',
    last_name: 'User'
)

User.create!(
    email: 'receiver-editor@example.com',
    password: 'password',
    password_confirmation: 'password',
    role: :receiver_editor,
    first_name: 'Receiver',
    last_name: 'Editor'
)

User.create!(
    email: 'receiver@example.com',
    password: 'password',
    password_confirmation: 'password',
    role: :receiver,
    first_name: 'Receiver',
    last_name: 'User'
)

User.create!(
    email: 'editor@example.com',
    password: 'password',
    password_confirmation: 'password',
    role: :editor,
    first_name: 'Editor',
    last_name: 'User'
)

User.create!(
    email: 'visitor@example.com',
    password: 'password',
    password_confirmation: 'password',
    role: :visitor,
    first_name: 'Visitor',
    last_name: 'User'
)