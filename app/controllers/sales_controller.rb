class SalesController < ApplicationController
  def create
    sale = Sale.new(sale_params)
    if sale.save
      render json: sale, status: :created
    else
      render json: { errors: sale.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    sales = Sale.all
    render json: sales
  end

  def show
    sale = Sale.find(params[:id])
    render json: sale
  end

  private

  def sale_params
    params.require(:sale).permit(:customer_id, :date, :value)
  end
end