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

Website.destroy_all
Website.create!(
    last_change: Time.now,
    country: 'US',
    website_type: 'News',
    size: 'Medium',
    name: 'Example News',
    status: 'Active',
    start_date: Date.today - 1.year,
    projectsPage: 'https://example.com/projects',
    jobsPage: 'https://example.com/jobs'

)
Website.create!(
    last_change: Time.now,
    country: 'UK',
    website_type: 'Blog',
    size: 'Small',
    name: 'Another Example Blog',
    status: 'Active',
    start_date: Date.today - 6.months,
    linkedinPage: 'https://linkedin.com/company/example-blog',
    projectsPage: 'https://exampleblog.com/projects',
    newsPage: 'https://exampleblog.com/news'
)