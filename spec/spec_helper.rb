require 'taskmapper-bcx'
require 'rspec'
require 'fakeweb'

FakeWeb.allow_net_connect = false

def username
  "username"
end

def password
  "password"
end

def create_instance(u = username, p = password)
  TaskMapper.new(:bcx, :username => u, :password => p)
end

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path("#{File.dirname(__FILE__)}/fixtures/#{filename}")
  File.read(file_path)
end

def stub_request(method, url, filename, status=nil, content_type="application/json")
  options = {:body => ""}
  options.merge!({:body => fixture_file(filename)}) if filename
  options.merge!({:body => status.last}) if status.is_a?(Array)
  options.merge!({:status => status}) if status
  options.merge!({:content_type => content_type})

  FakeWeb.register_uri method, url, options
end

def stub_get(*args); stub_request(:get, *args) end
def stub_post(*args); stub_request(:post, *args) end
def stub_put(*args); stub_request(:put, *args) end
def stub_delete(*args); stub_request(:delete, *args) end

def base_uri
  "https://#{username}:#{password}@basecamp.com/999999999/api/v1"
end

RSpec.configure do |c|
  c.before do
    stub_get(base_uri + '/people/me.json', 'me.json')
    stub_get(base_uri + '/projects.json', 'projects.json')
    stub_get(base_uri + '/projects/605816632.json', 'project.json')
    stub_get(base_uri + '/projects/605816632/todolists.json', 'todolists.json')
    stub_get(base_uri + '/projects/605816632/todolists/968316918.json', 'todolist.json')
    stub_get(base_uri + '/projects/605816632/todos/1.json', 'todo.json')
    stub_post(base_uri + '/projects/605816632/todolists/968316918/todos.json', 'new_todo.json')
    stub_post(base_uri + '/projects605816632/todos/1/comments.json', 'new_comment.json')
  end
end
