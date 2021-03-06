require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  include Devise::TestHelpers

  before do
    @admin = create(:user, admin: true)
    @user = create(:user)
  end

  describe '#index' do
    render_views

    it 'shows all categories' do
      sign_in @admin
      category = create(:category)

      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response.body).to include category.name
      expect(Category.count).to eq(1)
      expect(assigns(:categories)).to eq([category])
    end

    it 'redirects user' do
      sign_in @user
      create(:category)

      get :index
      expect(response).to be_redirect
      expect(flash[:error]).to eq 'You are not authorized to perform this action.'
    end
  end

  describe '#new' do
    it 'shows a new category form' do
      sign_in @admin
      get :new

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end

    it 'redirects user' do
      sign_in @user
      get :new

      expect(response).to be_redirect
      expect(flash[:error]).to eq 'You are not authorized to perform this action.'
    end
  end

  describe '#create' do
    it 'creates a new category with valid info' do
      sign_in @admin
      params = { category: { name: 'name' } }
      post :create, params

      expect(response).to be_redirect
      expect(Category.last.name).to eq('name')
      expect(flash[:notice]).to eq 'Category was successfully created.'
    end

    it 'fails with a blank name' do
      sign_in @admin
      params = { category: { name: '' } }
      post :create, params

      expect(response).to have_http_status(:success)
      expect(flash[:error]).to eq 'Category submission failed. Please try again.'
    end

    it 'redirects user' do
      sign_in @user
      params = { category: { name: 'name' } }
      post :create, params

      expect(response).to be_redirect
      expect(flash[:error]).to eq 'You are not authorized to perform this action.'
    end
  end

  describe '#edit' do
    it 'shows category edit form' do
      sign_in @admin
      category = create(:category)
      get :edit, id: category.id

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
      expect(assigns(:category)).to eq(category)
    end
  end

  describe '#update' do
    before do
      @category = create(:category, name: 'old name')
    end

    it 'updates with valid info' do
      sign_in @admin
      expect(@category.name).to eq('old name')
      patch :update, id: @category.id, category: { name: 'new name' }
      @category.reload

      expect(response).to be_redirect
      expect(@category.name).to eq('new name')
      expect(assigns(:category)).to eq(@category)
    end

    it 'fails without a name' do
      sign_in @admin
      invalid_name = ''
      patch :update, id: @category.id, category: { name: invalid_name }

      expect(response).to have_http_status(:success)
      expect(flash[:error]).to eq 'Category edit failed. Please try again.'
    end

    it 'fails as user' do
      sign_in @user
      patch :update, id: @category.id, category: { name: 'new name' }

      expect(response).to have_http_status(:redirect)
      expect(flash[:error]).to eq 'You are not authorized to perform this action.'
    end
  end

  describe '#destroy' do
    it 'destroys the requested category' do
      sign_in @admin
      category = create(:category)
      delete :destroy, id: category.id

      expect(response).to be_redirect
      expect(flash[:notice]).to eq 'Category was successfully deleted.'
      expect(Category.count).to eq(0)
    end

    it 'redirects user' do
      sign_in @user
      category = create(:category)
      delete :destroy, id: category.id

      expect(response).to be_redirect
      expect(flash[:error]).to eq 'You are not authorized to perform this action.'
    end
  end
end
