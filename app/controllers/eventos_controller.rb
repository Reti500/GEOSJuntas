class EventosController < ApplicationController
  before_action :require_login
  before_action :get_evento, only: [:show]

  def index
    # @eventos = current_user.eventos.methods
    @day = params['dia'] || nil
    @month = params['mes'] || nil
    @year = (params['year'] || DateTime.now.strftime("%Y")).to_i

    if @day && @month
      day = DateTime.new(@year, @month.to_i, @day.to_i)
      puts day
      @new_e = Evento.where('fecha BETWEEN ? AND ?', day, day+1.days)
      if @new_e
        puts "----------------> SI"
      end
      @eventos = @new_e
    else
      @eventos = current_user.eventos
    end

    respond_to do |format|
      format.html {}
      format.json { render json: @eventos, meta: "ok" }
    end
  end

  def show
    respond_to do |format|
      format.html {}
      format.json { render json: @evento, meta: "ok" }
    end
  end

  def edit
  end

  def update
  end

  def new
  end

  def create
    @evento = Evento.new(evento_params)

    if @evento.save
      current_user.eventos << @evento

      respond_to do |format|
        format.html {}
        format.json { render json: @evento }
      end
    else
      respond_to do |format|
        format.html {}
        format.json { render json: { state: "error" } }
      end
    end
  end

  def destroy
  end

  private

  def get_evento
    @evento = Evento.find(params[:id])
  end

  def evento_params
    params.require(:evento).permit(:titulo, :descripcion, :fecha, :hora)
  end
end
