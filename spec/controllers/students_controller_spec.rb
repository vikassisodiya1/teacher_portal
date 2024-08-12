# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let(:user) { create(:user) }
  let(:student) { create(:student) }
  let(:subject) { create(:subject, teacher: create(:teacher)) }
  let(:mark) { create(:mark, student:, subject:) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns @students and renders the index template' do
      get :index
      expect(assigns(:students)).to include(student)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new student and renders the new template' do
      get :new
      expect(assigns(:student)).to be_a_new(Student)
      expect(assigns(:subjects)).to eq(Subject.all)
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested student and renders the edit template' do
      get :edit, params: { id: student.id }
      expect(assigns(:student)).to eq(student)
      expect(assigns(:subjects)).to eq(Subject.all)
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new student and responds with turbo stream' do
        valid_params = {
          student: {
            first_name: student.first_name,
            last_name: student.last_name,
            marks_attributes: [{ score: mark.score, subject_id: mark.subject_id }]
          }
        }

        post :create, params: valid_params, format: :turbo_stream

        expect(response).to have_http_status(:success)
        expect(flash[:notice]).to eq('Student and associated subjects/marks were successfully created.')
        # Additional expectations as needed
      end
    end

    context 'with invalid attributes' do
      let(:invalid_params) do
        { student: { first_name: '', last_name: '', marks_attributes: [{ score: nil, subject_id: nil }] } }
      end

      it 'does not create a new student and renders the new template' do
        post :create, params: invalid_params, format: :turbo_stream

        expect(Student.count).to eq(0)
        expect(response).to have_http_status(:success)
        expect(response.body).to have_selector("turbo-stream[action='append'][target='flash']")
      end

      it 'renders turbo stream templates on failure' do
        post :create, params: invalid_params, format: :turbo_stream

        expect(response).to have_http_status(:success)
        expect(response.body).to include('flash')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'updates the student and responds with turbo stream' do
        put :update, params: { id: student.id, student: { first_name: 'Updated Name' } }, format: :turbo_stream

        expect(response).to have_http_status(:success)
        expect(response.body).to include('<turbo-stream action="replace" target="student_')
        expect(response.body).to include('<turbo-stream action="replace" target="flash">')
      end
    end

    context 'with invalid attributes' do
      let(:invalid_params) { { first_name: nil } }

      it 'does not update the student and renders the edit template' do
        put :update, params: { id: student.id, student: invalid_params }, format: :turbo_stream

        expect(student.reload.first_name).not_to be_nil
        expect(response).to have_http_status(:success)
        expect(response.body).to include('<turbo-stream action="append" target="flash">')
        expect(response.body).to include('flash')
      end

      it 'renders turbo stream templates on failure' do
        put :update, params: { id: student.id, student: invalid_params }, format: :turbo_stream

        expect(response).to have_http_status(:success)
        expect(response.body).to include('<turbo-stream action="append" target="flash">')
        expect(response.body).to include('flash')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:student) { create(:student) }

    it 'deletes the student and responds with turbo stream' do
      expect do
        delete :destroy, params: { id: student.id }, format: :turbo_stream
      end.to change(Student, :count).by(-1)

      expect(response).to have_http_status(:success)
      expect(response.body).to include('<turbo-stream action="remove" target="student_')
      expect(response.body).to include('<turbo-stream action="append" target="flash">')
    end

    it 'renders turbo stream templates on success' do
      delete :destroy, params: { id: student.id }, format: :turbo_stream

      expect(response).to have_http_status(:success)
      expect(response.body).to include('<turbo-stream action="remove" target="student_')
      expect(response.body).to include('<turbo-stream action="append" target="flash">')
    end
  end
end
