# Blog

A Rails 8 blog application with articles and comments, featuring status-based visibility controls and HTTP Basic Authentication.

## Features

- Articles with title, body, and status (public/private/archived)
- Comments on articles with status visibility
- HTTP Basic Authentication for admin actions
- Status-based filtering (only public content visible to visitors)
- PostgreSQL database

## Requirements

- Ruby 3.4.3
- Rails 8.0.5
- PostgreSQL

## Setup

1. Clone the repository:
```bash
git clone https://github.com/ElstonCr/Blog.git
cd Blog
```

2. Install dependencies:
```bash
bundle install
```

3. Create `.env` file in project root:
```bash
PSQL_USERNAME=your_username
PSQL_PASSWORD=your_password
BLOG_ADMIN_NAME=admin
BLOG_ADMIN_PASSWORD=secret
```

4. Setup database:
```bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```

## Running the Application

Start the Rails server:
```bash
bin/rails server
```

Visit `http://localhost:3000`

## Running Tests

Run all tests:
```bash
bin/rails test
```

Run specific test file:
```bash
bin/rails test test/models/article_test.rb
```

Run tests matching a pattern:
```bash
bin/rails test -n "/validation/"
```

## Admin Access

Protected actions (create, edit, delete) require HTTP Basic Authentication:
- Username: Set via `BLOG_ADMIN_NAME` environment variable
- Password: Set via `BLOG_ADMIN_PASSWORD` environment variable

## CI/CD

GitHub Actions runs on every push and pull request:
- Test suite
- RuboCop linting
- Brakeman security scan
- JavaScript dependency audit
