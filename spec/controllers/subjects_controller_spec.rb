# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  let(:user) { create(:user) }
  let(:teacher) { create(:teacher, user:) }
  let(:valid_attributes) { { name: 'Math' } }
  let(:invalid_attributes) { { name: '' } }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'assigns a new subject and renders the new template' do
      get :new, params: { teacher_id: teacher.id }
      expect(assigns(:subject)).to be_a_new(Subject)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new subject and responds with turbo stream' do
        post :create, params: { teacher_id: teacher.id, subject: valid_attributes }, format: :turbo_stream
        expect(response).to have_http_status(:success)
        expect(flash[:notice]).to eq('Subject was successfully added.')
        expect(response.body).to have_selector("turbo-stream[action='append'][target='flash']")
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new subject and responds with turbo stream' do
        post :create, params: { teacher_id: teacher.id, subject: invalid_attributes }, format: :turbo_stream

        expect(response).to have_http_status(:success)
        expect(flash[:alert]).to eq('Name Subject name can\'t be empty')
        expect(response.body).to have_selector("turbo-stream[action='append'][target='flash']")
      end
    end
  end
end
