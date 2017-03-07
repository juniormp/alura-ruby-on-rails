Rails.application.routes.draw do
  get "/produtos/new" => "produtos#new"
  post "/produtos" => "produtos#create"
  root "produtos#index"
end
