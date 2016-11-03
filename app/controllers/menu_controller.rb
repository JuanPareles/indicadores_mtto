class MenuController < ApplicationController
  def index
  end

  def registrar
  end

  def base_datos
    @mttos = Mantenimiento.all
  end

  def indicadores_seleccion

  end

  def indicadores_post

    puts params

    if params[:desde] && params[:hasta]
      # @Mantenimientos = Mantenimiento.search(params[:desde], params[:hasta])
      # puts Mantenimiento.where("fecha >= '#{params[:desde]}'").where("fecha <= '#{params[:hasta]}'")
      @Mantenimientos = Mantenimiento.where("fecha >= '#{params[:desde]}'").where("fecha <= '#{params[:hasta]}'")
      puts "Encontro mantenimentos"
      puts @Mantenimientos
    else
      @Mantenimientos = Mantenimiento.all
      puts "Todos los mtto"
      puts @Mantenimientos
    end

    if @Mantenimientos != nil
      hrs_programadas = 0
      @Mantenimientos.each do |mtto|
        hrs_programadas = hrs_programadas + mtto.duracion
        puts mtto
      end

      puts "horas programadas: #{hrs_programadas}"
      hrs_reales = @Mantenimientos.sum("tiempo_aplicado")
      puts "horas reales: #{hrs_reales}"
      if hrs_programadas.nonzero?
        @eficiencia = (hrs_programadas/hrs_reales) * 100
      else
        @eficiencia = 0;
      end
      hrs_turno = 8 * 60
      if hrs_programadas.nonzero?
        @ocupacion = (hrs_programadas / hrs_turno) * 100
        @productividad = (hrs_reales / hrs_turno) * 100
      else
        @ocupacion = 0
        @productividad = 0
      end

    else
      puts "Mntto es null :("
      @eficiencia = 0
      @ocupacion = 0
      @productividad = 0
    end

    @indicador = params[:indicador]
    @desde = params[:desde]
    @hasta = params[:hasta]

    @data_grafica = []

      arr_fechas = []
      fecha_desde = Date.parse(@desde)
      fecha_actual = fecha_desde
      fecha_hasta = Date.parse(@hasta)
      while fecha_actual.cweek <= fecha_hasta.cweek do
        arr_fechas.push(fecha_actual)
        fecha_actual = fecha_actual + 7.days
      end

      puts arr_fechas


      redirect_to controller: 'menu',
                  action: 'indicadores_resultados',
                  desde: @desde,
                  hasta: @hasta,
                  indicador: @indicador,
                  eficiencia: @eficiencia,
                  ocupacion: @ocupacion,
                  productividad: @productividad,
                  mantenimientos: @Mantenimientos

    end


    def indicadores_resultados
      @desde = params[:desde]
      @hasta = params[:hasta]
      @indicador = params[:indicador]
      @eficiencia = params[:eficiencia]
      @ocupacion = params[:ocupacion]
      @productividad = params[:productividad]
      @mantenimientos = params[:mantenimientos]
    end

    def borrar_todo
      Mantenimiento.destroy_all
      redirect_to menu_index_path
    end

    private

    def getEficienciaSemana(fecha, indicador = '')
      d = Date.parse(fecha)
      inicio_semana = d.beginning_of_week.strftime('%Y-%m-%d')
      final_semana = d.end_of_week.strftime('%Y-%m-%d')
      mantenimientos = Mantenimiento.where("fecha >= '#{inicio_semana}'").where("fecha <= '#{final_semana}'")
      hrs_programadas = 0
      mantenimientos.each do |mtto|
        hrs_programadas = hrs_programadas + mtto.duracion
      end
      hrs_reales = mantenimientos.sum("tiempo_aplicado")
      if hrs_reales.nonzero?
        eficiencia = (hrs_programadas/hrs_reales) * 100
      else
        eficiencia = 0;
      end
      return eficiencia
    end

  end
