# Rails Realtime Password form Validation

This is a sample app that allows a user to sign and set password.
Password requirements are displayed on the page as the user types.

## Table of Contents

- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Tests](#tests)
- [Technologies Used](#technologies-used)

## Getting Started

### Prerequisites

- Ruby 3.2.2
- Bundler
- Node
- Postgres

### Installation

```sh
bundle
bin/setup
rails assets:precompile
bin/dev
```

## Usage

User signup:
http://localhost:3000/users/new

User login: http://localhost:3000/user_sessions/new

## Tests

This project is tested using RSpec.
To run tests run RSpec from a terminal: `rspec`

## Technologies Used

- Rails
- Postgres
- Bootstrap
- Stimulus