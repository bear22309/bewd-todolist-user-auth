Rails.application.routes.draw do
  # Root path
  root 'homepage#index'

  # Devise routes for User authentication
  devise_for :users

  # TASKS
  get    '/tasks'                    => 'tasks#index'
  post   '/tasks'                    => 'tasks#create'
  delete '/tasks/:id'                => 'tasks#destroy'
  put    '/tasks/:id/mark_complete'  => 'tasks#mark_complete'
  put    '/tasks/:id/mark_active'    => 'tasks#mark_active'
  get    '/my_tasks'                 => 'tasks#index_by_current_user'

  # USERS
  # The users#create route can be managed by Devise, so you might not need this custom route.
  # But if you have specific logic for user creation, you can keep it.
  post   '/users'                    => 'users#create'

  # SESSIONS
  # Devise manages sessions, so these custom session routes may be redundant.
  # However, if you have custom session logic, you can keep them.
  post   '/sessions'                 => 'sessions#create'
  get    '/authenticated'            => 'sessions#authenticated'
  delete '/sessions'                 => 'sessions#destroy'

  # Redirect all other paths to the index page
  get '*path' => 'homepage#index'
end

