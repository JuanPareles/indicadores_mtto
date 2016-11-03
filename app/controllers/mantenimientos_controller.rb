class MantenimientosController < ApplicationController
  def new
    @mtto = Mantenimiento.new
  end

  def create
    @mtto = Mantenimiento.new(mtto_params)
    if @mtto.save
      redirect_to menu_index_path
    else
      render 'new'
    end
  end

  private

  def mtto_params
    params.require(:mantenimiento).permit(:nro_mtto, :fecha, :equipo, :tipo, :duracion, :tiempo_aplicado)
  end
end
