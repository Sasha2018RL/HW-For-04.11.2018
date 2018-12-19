require 'sinatra'
$stdout.sync = true
require './lib/posts_storage'
require './lib/contacts_storage'
require './lib/faq_storage'

set :views, settings.root + '/templates'

posts_storage = Posts.new
contacts_storage = Contacts.new
faq_storage = FAQ.new
# welcome page: static page
get '/' do
  erb :welcome
end


# list of posts: page filled from postsStorage
get '/posts' do
puts posts_storage.all
  posts = posts_storage.all
  erb :list, locals: { posts: posts }
end

# страница одного поста. Берем из хранилища (почти-БД),
# искать его будем через id (идентификатор)
get '/posts/:id' do
  post = posts_storage.find(params[:id].to_i)
  erb :post, locals: { post: post }
end

# list of faqs: page filled from faqStorage
get '/faq' do
puts faq_storage.all
  faqs = faq_storage.all
  erb :faqs, locals: { faqs: faqs }
end

# страница одной записи faq. Берем из хранилища (почти-БД),
# искать его будем через id (идентификатор)
get '/faq/:id' do
  faq_item = faq_storage.find(params[:id].to_i)
  erb :faq, locals: { faq: faq_item }
end

# страница формы создания поста. Именно она отправляет запрос
# в следующий обработчик (handler)
get '/create/posts' do
  erb :post_create
end

get '/create/contacts' do
  erb :contact_create
end

get '/create/faq' do
  erb :faq_create
end

# обработчик запроса создания поста
post '/posts' do
  posts_storage.create(params[:title], params[:text])
  redirect to('/posts')
end

post '/contacts' do
  contacts_storage.create(params[:name], params[:email])
  redirect to('/contacts')
end

post '/faq' do
  faq_storage.create(params[:title], params[:text])
  redirect to('/faq')
end

get "/contacts" do
	contacts = contacts_storage.all
	erb :contacts, locals: { contacts: contacts }
end