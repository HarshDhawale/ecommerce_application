class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]
  before_action :set_cart, only: [:new, :create, :add_to_cart, :remove_from_cart]


  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_to_cart
    product_id = params[:product_id]
    quantity = params[:quantity].to_i

    item = @cart.find { |item| item['product_id'] == product_id }
    if item
      item['quantity'] += quantity
    else
      @cart << { 'product_id' => product_id, 'quantity' => quantity }
    end

    update_session_cart
    respond_to do |format|
      format.js { render :update_cart }
    end
  end

  def remove_from_cart
    product_id = params[:product_id]
    @cart.reject! { |item| item['product_id'] == product_id }

    update_session_cart
    respond_to do |format|
      format.js { render :update_cart }
    end
  end
  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_cart
    @cart = session[:cart] ||= []
  end

  def update_session_cart
    session[:cart] = @cart
  end
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:customer_id, :product_id)
  end
end
