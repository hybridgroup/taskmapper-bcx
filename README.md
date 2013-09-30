# taskmapper-bcx

This is the [TaskMapper][] adapter for interaction with [Basecamp Next][]

## Usage

Initialize the taskmapper-bcx instance using your username, password, and
account ID:

```ruby
bcx = TaskMapper.new(
  :bcx,
  :account_id => "123456789",
  :username => "YOUR_USERNAME",
  :username => "YOUR_PASSWORD",
)
```

## Finding Projects

You can find your own projects by using:

```ruby
projects = bcx.projects # will return all projects
projects = bcx.projects ["project_id", "another_project_id"]
project = bcx.projects.find :first, "project_id"
projects = bcx.projects.find :all, ["project_id", "another_project_id"]
```

## Finding Tickets

```ruby
tickets = project.tickets # All open tickets
tickets = project.tickets :all, :status => 'closed' # all closed tickets
ticket = project.ticket 981234
```

## Opening A Ticket

```ruby
ticket = project.ticket!(
  :description => "Content of the new ticket."
)
```

## Closing Tickets

```ruby
ticket.close
```

## Reopening Tickets

```ruby
ticket.reopen
```

## Updating Tickets

```ruby
ticket.description = "New description"
ticket.save
```

## Finding Comments

```ruby
ticket.comments # all comments for a ticket
ticket.comments 90210
```

## Creating a Comment

```ruby
ticket.comment! :body => "New Comment!"
```

## Dependencies

- rubygems
- [taskmapper][]
- [httparty][]

## Contributing

The main way you can contribute is with some code! Here's how:

- Fork `taskmapper-bcx`
- Create a topic branch: git checkout -b my_awesome_feature
- Push to your branch - git push origin my_awesome_feature
- Create a Pull Request from your branch
- That's it!

We use RSpec for testing. Please include tests with your pull request. A simple
`bundle exec rake` will run the suite. Also, please try to TomDoc your methods,
it makes it easier to see what the code does and makes it easier for future
contributors to get started.

(c) 2013 The Hybrid Group


[taskmapper]: http://ticketrb.com
[basecamp next]: https://basecamp.com
[httparty]: https://github.com/jnunemaker/httparty
