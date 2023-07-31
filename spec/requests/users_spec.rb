require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:department) { create(:department) }
  let(:group) { create(:group) }
  let(:user_params) do
    {
      user: {
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        department_id: department.id,
        group_id: group.id,
        role: 'employee'
      }
    }
  end

  describe 'GET /users/new' do
    it 'renders the new template' do
      get new_user_path
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /users' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post users_path, params: user_params
        }.to change(User, :count).by(1)
      end

      it 'redirects to the users index page' do
        post users_path, params: user_params
        expect(response).to redirect_to(users_path)
      end

      it 'sets a success flash message' do
        post users_path, params: user_params
        expect(flash[:notice]).to eq('User was successfully created.')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { user_params.deep_merge(user: { email: '' }) }

      it 'does not create a new user' do
        expect {
          post users_path, params: invalid_params
        }.not_to change(User, :count)
      end

      it 'renders the new template' do
        post users_path, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET /users' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user, :admin) }

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'assigns all users to @users' do
      get users_path
      expect(assigns(:users)).to match_array([user1, user2])
    end
  end

  describe 'GET /users/:id/edit' do
    let(:user) { create(:user) }

    it 'renders the edit template' do
      get edit_user_path(user)
      expect(response).to render_template(:edit)
    end

    it 'assigns the correct user to @user' do
      get edit_user_path(user)
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'PATCH /users/:id' do
    let(:user) { create(:user) }
    let(:department) { create(:department) }
    let(:group) { create(:group) }

    let(:valid_user_params) do
      {
        user: {
          password: 'updated_password',
          password_confirmation: 'updated_password',
          department_id: department.id,
          group_id: group.id,
          role: 'admin'
        }
      }
    end

    context 'with valid parameters' do
      it 'updates the user' do
        patch user_path(user), params: valid_user_params
        user.reload
        expect(user.department_id).to eq(department.id)
        expect(user.group_id).to eq(group.id)
        expect(user.role).to eq('admin')
      end

      it 'redirects to the users index page' do
        patch user_path(user), params: valid_user_params
        expect(response).to redirect_to(users_path)
      end

      it 'sets a success flash message' do
        patch user_path(user), params: valid_user_params
        expect(flash[:notice]).to eq('User updated successfully.')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_user_params) do
        {
          user: {
            email: '',
            password: 'updated_password',
            password_confirmation: 'updated_password',
            department_id: 2,
            group_id: 2,
            role: 'admin'
          }
        }
      end

      it 'does not update the user' do
        expect {
          patch user_path(user), params: invalid_user_params
          user.reload
        }.not_to change(user, :email)
      end

      it 'renders the edit template' do
        patch user_path(user), params: invalid_user_params
        expect(response).to render_template(:edit)
      end
    end
  end
end
