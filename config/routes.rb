Rails.application.routes.draw do
  # Root path
  root 'homepage#index'

  # TASKS
  get    '/tasks'                    => 'tasks#index'
  post   '/tasks'                    => 'tasks#create'
  delete '/tasks/:id'                => 'tasks#destroy'
  put    '/tasks/:id/mark_complete'  => 'tasks#mark_complete'
  put    '/tasks/:id/mark_active'    => 'tasks#mark_active'
  get    '/my_tasks'                 => 'tasks#index_by_current_user'

  # USERS
  post   '/users'                    => 'users#create'

  # SESSIONS
  post   '/sessions'                 => 'sessions#create'
  get    '/authenticated'            => 'sessions#authenticated'
  delete '/sessions'                 => 'sessions#destroy'

  # Redirect all other paths to the index page
  get '*path' => 'homepage#index'
end
