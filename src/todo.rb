require 'sinatra'
require 'byebug'
require 'json'
require_relative 'db'

db = SQLite3::Database.open 'test.db'

migrate db

before do
   content_type :json
   headers 'Access-Control-Allow-Origin' => '*', 
            'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST', 'PUT', 'DELETE'],
            'Access-Control-Allow-Headers' => "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
end

get '/todos' do
   todos = db.execute "select * from todo" 

   todos.map do |todo|
      {
         id: todo[0],
         task: todo[1],
         is_done: todo[2] == 1,
      }
   end.to_json
end

get '/todos/:id' do
   list = db.get_first_row( "select * from todo where Id=?", params['id'])

   return {
      id: list[0],
      task: list[1],
      is_done: list[2] == 1,
   }.to_json

end

delete '/todos/:id' do
   status 204

   db.execute( "delete from todo where Id=?", params['id'])
end

# add
post '/todos' do
   request.body.rewind
   @request_payload = JSON.parse request.body.read

   todo = db.execute( "insert into todo (task, is_done)
                      values (?, ?)", @request_payload["task"], @request_payload["is_done"])

   status 201

   return {
      id: todo[0],
      task: todo[1],
      is_done: todo[2] == 1,
   }.to_json
end

# edit
put '/todos/:id' do
   request.body.rewind
   @request_payload = JSON.parse request.body.read

   text = db.execute( "update todo set task=?, is_done=? where Id=?", @request_payload["task"], @request_payload["is_done"], params['id'] )

   status 204
   
   text.to_json
end

options '*' do
end