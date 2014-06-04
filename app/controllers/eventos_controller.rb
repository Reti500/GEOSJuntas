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
  end

  def destroy
  end

  private

  def get_evento
    @evento = Evento.find(params[:id])
  end
end
