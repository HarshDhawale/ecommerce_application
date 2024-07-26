require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe 'GET index' do
    before do
      @customer=Customer.create(name:"Harsh",address:"Nashik",dob:"2000-02-02",phone_number:1222222222,email:"Hahd@gmail.com",password_digest:"123")
      get :index
    end
    it 'assigns @customers' do
      expect(assigns(:customers)).to eq([@customer])
    end

    it 'render the index template' do
      expect(response).to render_template('index')
    end

    it 'returns the status code ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'gives a successful response' do
      expect(response).to be_successful
    end
  end

  describe 'GET show' do
    before do
      @customer=Customer.create(name:"Harsh",address:"Nashik",dob:"2000-02-02",phone_number:1222222222,email:"Hahd@gmail.com",password_digest:"123")
      get :show, params: { id: @customer.to_param }
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end

    it 'returns the status code ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns to @customer' do
      expect(assigns(:customer)).to eq(@customer)
    end

    it 'should accept the params with html format' do
      expect(response.media_type).to eq('text/html')
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end
  end

  describe 'GET edit' do
    before do
      @customer=Customer.create(name:"Harsh",address:"Nashik",dob:"2000-02-02",phone_number:1222222222,email:"Hahd@gmail.com",password:"123")
      get :edit, params: { id: @customer.to_param }
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'renders the edit template' do
      expect(response).to render_template('edit')
    end

    it 'returns the status code ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns to @customer' do
      expect(assigns(:customer)).to eq(@customer)
    end

    it 'should accept the params with html format' do
      expect(response.media_type).to eq('text/html')
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end
  end

  describe 'GET new' do
    before do
      get :new
    end

    it 'returns a successfull response' do
      expect(response).to be_successful
    end

    it 'render a new template' do
      expect(response).to render_template('new')
    end

    it 'create a new customer' do
      expect(assigns(:customer)).to be_a_new(Customer)
    end

    it 'returns the status code ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST create' do
    context 'when parameters valid' do
      it 'creates a new customer' do
        expect {
          post :create, params: { customer: valid_params }
        }.to change(Customer,:count).by(1)
      end

      it 'redirect to created customer' do
        post :create, params: { customer: valid_params }
        expect(response).to redirect_to(Customer.last)
      end

      it 'returns the status code found as redirection' do
        post :create, params: { customer: valid_params }
        expect(response).to have_http_status(:found)
      end

      it 'should accept the params with html format' do
        post :create, params: { customer: valid_params }
        # debugger
        expect(response.media_type).to eq('text/html')
        expect(response.content_type).to eq('text/html; charset=utf-8')
      end
    end

    context 'when parameters are invalid ' do
      it 'does not create a new customer' do
        expect {
          post :create, params: {customer: invalid_params}
        }.to change(Customer, :count).by(0)
      end

      it 'redirect to new template' do
        post :create, params: { customer: invalid_params }
        expect(response).to render_template('new')
      end

      it 'returns the status code found ' do
        post :create, params: { customer: invalid_params }
        expect(response).to have_http_status(:found)
      end

      it 'does not validate the customer' do
        post :create, params: { customer: invalid_params }
        expect(assigns(:customer).valid?).to_not eq(true)
      end

      # it 'includes the error messages for the validated attributes' do
      #   post :create, params: { customer: invalid_params }
      #   expect(assigns(:customer).errors.full_messages).to eq(["Address can't be blank", "Address is too short (minimum is 2 characters)"])
      # end
    end
  end

  describe 'PATCH update' do
    context 'when parameters valid' do
      it 'update a customer' do
        customer = Customer.create(valid_params)
        expect {
          patch :update, params: { customer: valid_params_for_update, id: customer.to_param }
        }.to change(Customer, :count).by(0)
      end

      it 'redirect to updated customer' do
        customer = Customer.create(valid_params)
        patch :update, params: { customer: valid_params_for_update, id: customer.to_param }
        expect(response).to redirect_to(customer)
      end

      it 'returns the status code found as redirection' do
        customer = Customer.create(valid_params)
        patch :update, params: { customer: valid_params_for_update, id: customer.to_param }
        expect(response).to have_http_status(:found)
      end

      it 'should accept the params with html format' do
        customer = Customer.create(valid_params)
        patch :update, params: { customer: valid_params_for_update, id: customer.to_param }
        # debugger
        expect(response.media_type).to eq('text/html')
        expect(response.content_type).to eq('text/html; charset=utf-8')
      end
    end

    context 'when parameters are invalid ' do
      it 'does not update a customer' do
        customer = Customer.create(valid_params)
        patch :update, params: { customer: invalid_params_for_update, id: customer.to_param }
        expect(assigns(:customer)).to eq(customer)
      end

      it 'redirect to edit template' do
        customer = Customer.create(valid_params)
        patch :update, params: { customer: invalid_params_for_update, id: customer.to_param }
        expect(response).to render_template('edit')
      end

      it 'returns the status code unprocessable entity ' do
        customer = Customer.create(valid_params)
        patch :update, params: { customer: invalid_params_for_update, id: customer.to_param }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not validate the customer' do
        customer = Customer.create(valid_params)
        patch :update, params: { customer: invalid_params_for_update , id: customer.to_param }
        expect(assigns(:customer).valid?).to_not eq(true)
      end

      # it 'includes the error messages for the validated attributes' do
      #   customer = Customer.create(valid_params)
      #   patch :update, params: { customer: invalid_params_for_update, id: customer.to_param }
      #   expect(assigns(:customer).errors.full_messages).to eq(["Name can't be blank",
      #   "Address can't be blank",
      #   "Dob can't be blank",
      #   "Phone number can't be blank",
      #   "Email can't be blank",
      #   "Email is invalid",
      #   "Email has already been taken",
      #   "Password can't be blank"])
      # end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the customer' do
      customer = Customer.create(valid_params)
      expect { delete :destroy, params: { id: customer.to_param } }.to change(Customer, :count).by(-1)
    end

    it 'redirect to all customers list' do
      customer = Customer.create(valid_params)
      delete :destroy, params: { id: customer.to_param }
      expect(response).to redirect_to(:customers)
    end
  end

  def valid_params
    {
      name: 'abc',
      phone_number: '1234567890',
      dob: '23-10-2002',
      address: 'nagar',
      email:'asd@gmail.com',
      password:'132'
    }
  end

  def valid_params_for_update
    params =
      {
        name: 'asad',
        phone_number: '1237567890',
        dob: '23-11-2002',
        address: 'nagar_pune'
      }
    params
  end

  def invalid_params
    params =
      {
        name: 'abc',
        phone_number: '1234567890',
        dob: '23-10-2002'
      }
    params
  end

  def invalid_params_for_update
    params =
      {
        name: 'abc4',
        phone_number: 'a1234567890',
        dob: '-10-2002'
      }
    params
  end
end
