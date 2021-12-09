class LicensesController < ApplicationController
  before_action :set_license, only: [:edit, :update, :destroy]

  def new
    @license = License.new
    authorize @license
    @type_collection = ['Licença', 'Férias']
  end

  def create
    @license = License.new(license_params)
    @license.user = current_user
    authorize @license
    if @license.save
      redirect_to users_show_path(current_user), notice: "Período criado com sucesso."
    else
      render :new, alert: "Erro ao adicionar o período."
    end
  end

  def edit
    @type_collection = ['Licença', 'Férias']
  end

  def update
    @license.update(license_params)
    redirect_to users_show_path(current_user), notice: "Período de licença alterado com sucesso."
  end

  def destroy
    @license.destroy
    redirect_to users_show_path(current_user), notice: "Período de licença excluído com sucesso."
  end

  private

  def license_params
    params.require(:license).permit(:start_date, :end_date, :tipo)
  end

  def set_license
    @license = License.find(params[:id])
    authorize @license
  end
end
