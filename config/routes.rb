Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
        scope '/users' do
          get 'profile', to: 'users#me'
          post 'tweet', to: 'users#update_status'
        end

        scope '/auth' do
          post '', to: 'authentication#authenticate'
        end
      end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
