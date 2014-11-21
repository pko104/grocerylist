require 'sinatra'

grocery = File.read("grocery_list.txt")
grocery_list = grocery.split("\n")

get '/' do
erb :index
end

get '/groceries' do

grocery = File.read("grocery_list.txt")
grocery_list = grocery.split("\n")
@list = grocery_list

erb :groceries
end

post '/groceries' do

@list = grocery_list
@groceries = params["groceries"]

if !@groceries.empty? && !(grocery_list.include?@groceries)
  File.open("grocery_list.txt", "a"){|file| file.puts "#{@groceries}\n"}
  redirect '/groceries'
else
   @error_messages = []
   @error_messages << "You must enter a grocery." if @groceries.empty?
   @error_messages << "Grocery already in list." if grocery_list.include?@groceries

   erb :groceries
end

end

