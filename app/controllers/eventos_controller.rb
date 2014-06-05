class EventosController < ApplicationController
  before_action :require_login
  before_action :get_evento, only: [:show]

  def index
    # @eventos = current_user.eventos.methods
    @eventos = current_user.eventos

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
    params.require(:evento).permit(:titulo, :descripcion, :fecha)
  end
end
