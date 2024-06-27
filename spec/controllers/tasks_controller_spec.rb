# File: spec/controllers/tasks_controller_spec.rb

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  render_views

  describe 'GET /my_tasks' do
    it 'renders all tasks of current user in JSON' do
      user = FactoryBot.create(:user)
      session = user.sessions.create
      @request.cookie_jar.signed['todolist_session_token'] = session.token
      task = user.tasks.create(content: 'Task #1')
      other_user = FactoryBot.create(:user, username: 'other_username')
      other_user.tasks.create(content: 'Task #2')

      get :index_by_current_user

      task.reload  # Ensure task is reloaded to get updated attributes

      expected_response = [
        {
          id: task.id,
          content: task.content,
          completed: task.completed,
          created_at: task.created_at.iso8601(3),
          updated_at: task.updated_at.iso8601(3),
          user_id: task.user_id
        }
      ]

      expect(JSON.parse(response.body)).to eq(expected_response.as_json)
    end
  end

  describe 'POST /tasks' do
    it 'renders newly created task in JSON' do
      user = FactoryBot.create(:user)
      session = user.sessions.create
      @request.cookie_jar.signed['todolist_session_token'] = session.token

      post :create, params: {
        task: {
          content: 'New Task'
        }
      }

      task = Task.last  # Corrected to retrieve the last created task
      task.reload  # Ensure task is reloaded to get updated attributes

      expected_response = {
        id: task.id,
        content: 'New Task',
        completed: false,
        created_at: task.created_at.iso8601(3),
        updated_at: task.updated_at.iso8601(3),
        user_id: task.user_id
      }

      expect(Task.count).to eq(1)
      expect(JSON.parse(response.body)).to eq(expected_response.as_json)
    end
  end

  describe 'DELETE /tasks/:id' do
    it 'renders success status' do
      user = FactoryBot.create(:user)
      task = user.tasks.create(content: 'Task Example')

      delete :destroy, params: { id: task.id }

      expect(Task.count).to eq(0)
      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'PUT /tasks/:id/mark_complete' do
    it 'renders modified task' do
      user = FactoryBot.create(:user)
      task = user.tasks.create(content: 'Task Example')

      put :mark_complete, params: { id: task.id }

      task.reload  # Ensure task is reloaded to get updated attributes

      expected_response = {
        id: task.id,
        content: task.content,
        completed: true,
        created_at: task.created_at.iso8601(3),
        updated_at: task.updated_at.iso8601(3),
        user_id: task.user_id
      }

      expect(task.completed).to be true
      expect(JSON.parse(response.body)).to eq(expected_response.as_json)
    end
  end

  describe 'PUT /tasks/:id/mark_active' do
    it 'renders modified task' do
      user = FactoryBot.create(:user)
      task = user.tasks.create(content: 'Task Example', completed: true)
      session = user.sessions.create
      @request.cookie_jar.signed['todolist_session_token'] = session.token

      put :mark_active, params: { id: task.id }

      task.reload  # Ensure task is reloaded to get updated attributes

      expected_response = {
        id: task.id,
        content: task.content,
        completed: false,
        created_at: task.created_at.iso8601(3),
        updated_at: task.updated_at.iso8601(3),
        user_id: task.user_id
      }

      expect(task.completed).to be(false)
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(expected_response.to_json)
    end
  end
end

