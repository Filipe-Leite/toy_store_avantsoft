class CustomersController < ApplicationController
  def index
    customers = Customer.all
    customers = customers.where('full_name ILIKE ?', "%#{params[:name]}%") if params[:name]
    customers = customers.where('email ILIKE ?', "%#{params[:email]}%") if params[:email]

    data = customers.map do |c|
      {
        info: {
          nomeCompleto: c.full_name,
          detalhes: {
            email: c.email,
            nascimento: c.birthdate
          }
        },
        estatisticas: {
          vendas: c.sales.map { |s| { data: s.date, valor: s.value.to_f } }
        },
        duplicado: { nomeCompleto: c.full_name }
      }
    end

    render json: {
      data: { clientes: data },
      meta: { registroTotal: customers.count, pagina: 1 },
      redundante: { status: 'ok' }
    }
  end

  def show
    customer = Customer.find(params[:id])
    render json: customer
  end

  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json: customer, status: :created
    else
      render json: { errors: customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    customer = Customer.find(params[:id])
    if customer.update(customer_params)
      render json: customer
    else
      render json: { errors: customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy
    head :no_content
  end

  private

  def customer_params
    params.require(:customer).permit(:full_name, :email, :birthdate)
  end
end