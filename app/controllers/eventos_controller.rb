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
      @new_e = Evento.where('fecha BETWEEN ? AND ?', day, day+1.days)
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
    @invitados = params[:invitados]
    @params = evento_params

    @day = params['dia'] || nil
    @month = params['mes'] || nil
    @year = (params['year'] || DateTime.now.strftime("%Y")).to_i

    @current_day = DateTime.new(@year, @month.to_i, @day.to_i)
    @current_day_all = DateTime.new(@year, @month.to_i, @day.to_i, @params['hora'])
    @message = ""

    @params['fecha'] = @current_day_all

    @e = Evento.where('fecha BETWEEN ? AND ?', @current_day, @current_day_all).order('hora').first || nil

    if @e
      if (@e.fecha + @e.duracion.to_i.hours) <= @current_day_all
        @evento = Evento.new(@params)
      else
        message = "--> NO SE PUEDE #{(@e.fecha + @e.duracion.to_i.hours)} <= #{@current_day_all}"
      end
    else
      @evento = Evento.new(@params)
    end

    if @evento
      current_user.eventos << @evento

      @n = Notification.new(message: "El usuario #{current_user.email} te invito al el evento #{@evento.titulo}",
          action: "Ver comentario", notify_type: "comentario", status: "pendiente")

      for i in @invitados
        u = User.find_by(email: i)
        if u
          u.eventos << @evento
          u.notifications << @n
        end
      end

      respond_to do |format|
        format.html {}
        format.json { render json: @evento }
      end
    else
      respond_to do |format|
        format.html {}
        format.json { render json: { state: "error", message: @message } }
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
    params.require(:evento).permit(:titulo, :descripcion, :fecha, :hora, :duracion)
  end
end
