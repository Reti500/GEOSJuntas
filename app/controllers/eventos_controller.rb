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
      # unless @new_e.length > 0
      #   @eventos = @new_e
      # end
      # if @new_e.length > 0
        @eventos = @new_e
      # end
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

    puts @invitados

    # @hora_del_evento = @params['hora'].to_datetime.strftime("%H:%M")
    #@hora_del_evento = DateTime.new(@year, @month.to_i, @day.to_i, @params['hora'])
    #puts "->> HORA -> #{@hora_del_evento}"

    @params['fecha'] = @current_day_all
    #@evento = Evento.new(@params)

    @e = Evento.where('fecha BETWEEN ? AND ?', @current_day, @current_day_all).order('hora').first || nil

    if @e
      if (@e.fecha + @e.duracion.to_i.hours) <= @current_day_all
        puts "--> SI SE PUEDE #{(@e.fecha + @e.duracion.to_i.hours)} <= #{@current_day_all}"
        @evento = Evento.new(@params)
      else
        puts "--> NO SE PUEDE #{(@e.fecha + @e.duracion.to_i.hours)} <= #{@current_day_all}"
      end
    else
      @evento = Evento.new(@params)
      puts "->>>>>>>>>>>>>>> Error"
    end
    # @e = Evento.where('fecha BETWEEN ? AND ?', @current_day, (@current_day+@hora_del_evento.strftime("%H:%M").to_i.hours)).order('hora').first || nil
    # puts @e
    # if @e
    #   if (@e.hora + @e.duracion.to_i.hours).strftime("%H:%M") <= @hora_del_evento.to_s
    #     puts "Hora #{@e.hora.strftime("%H:%M")} + #{@e.duracion.to_i.hours} == #{(@e.hora + @e.duracion.to_i.hours).strftime("%H:%M")} <= #{@hora_del_evento}"
    #     @evento = Evento.new(evento_params)
    #   else
    #     puts "Hora #{@hora_del_evento.to_s} <<-->> #{@e.hora.strftime("%H:%M")} + #{@e.duracion.to_i.hours}"
    #     @message = "Error en la hora"
    #   end
    # else
    #   puts "No se encontro nada"
    #   @evento = Evento.new(evento_params)
    # end

    if @evento
      current_user.eventos << @evento

      for i in @invitados
        puts i
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
