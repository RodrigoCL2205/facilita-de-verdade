class HolidaysController < ApplicationController
  before_action :set_holiday, only: [:edit, :update, :destroy]

  def index
    @holidays = policy_scope(Holiday).order(date: :asc)
  end

  def new
    @holiday = Holiday.new
    authorize @holiday
  end

  def create
    @holiday = Holiday.new(holiday_params)
    @holiday.half = params[:holiday][:half] == 'Sim'
    authorize @holiday
    if @holiday.save
      redirect_to holidays_path, notice: "Feriado incluído com sucesso."
    else
      render :new
    end
  end

  def destroy
    @holiday.destroy
    redirect_to holidays_path, notice: "Feriado excluído."
  end

  private

  def set_holiday
    @holiday = Holiday.find(params[:id])
    authorize @holiday
  end

  def holiday_params
    params.require(:holiday).permit(:name, :date)
  end
end
