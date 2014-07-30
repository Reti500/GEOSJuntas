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
    @params = comentario_params
    @comentario = Comentario.new(@params)

    if @comentario.save
      current_user.comentarios << @comentario
      
      @e = Evento.find(@params['evento_id'])
      @n = Notification.new(message: "El usuario #{current_user.email} comento el evento #{@e.titulo}",
          action: "Ver comentario", notify_type: "comentario", status: "pendiente")

      @e.users.each do |u|
        u.notifications << @n
      end

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
