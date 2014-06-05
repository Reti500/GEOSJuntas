class ComentariosController < ApplicationController
  before_action :get_comentario, only: [:show]

  def index
    @evento = (params[:evento_id] && Evento.find(params[:evento_id])) || nil

    if @evento
      respond_to do |format|
        format.html {}
        format.json { render json: @evento.comentarios }
      end
    else
      respond_to do |format|
        format.html {}
        format.json { render json: nil }
      end
    end
  end

  def show
    respond_to do |format|
      format.html {}
      format.json { render json: @comentario }
    end
  end

  def new
  end

  def create
    @comentario = Comentario.new(comentario_params)

    if @comentario.save
      current_user.comentarios << @comentario
      
      respond_to do |format|
        format.html {}
        format.json { render json: @comentario }
      end
    else
      respond_to do |format|
        format.html {}
        format.json { render json: {state: "error"} }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def get_comentario
    @comentario = Comentario.find(params[:id])
  end

  def comentario_params
    params.require(:comentario).permit(:titulo, :comentario, :evento_id)
  end
end
