class EquiposController < ApplicationController
  def new
    @equipo = Equipo.new
  end

  def create
    @equipo = Equipo.new(mtto_params)
    if @equipo.save
      redirect_to menu_index_path
    else
      render 'new'
    end
  end

  private

  def mtto_params
    params.require(:equipo).permit(:nombre, :tipo, :duracion)
  end
end
