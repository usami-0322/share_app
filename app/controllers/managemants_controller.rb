class ManagemantsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = current_user.managemants.ransack(params[:q])
    @managemants = @q.result(distinct: true)
    @managemant = current_user.managemants.build
    @desc_data = current_user.managemants.order(result_date: :desc)
    today = @desc_data.latest_result_date
    if @managemants.pluck(:result_date).empty?
      @daily_budget = 0
    else
      last_day = Date.new(today.year, today.month, -1)
      days_left = (last_day - today).to_i
      @daily_budget = (@desc_data.latest_budget - current_user.managemants.total_sales) / days_left
    end
    # # 達成率
    # @achievement_rate = @total_sales / @latest_budget.to_i * 100 rescue 0
  end

  def create
    @managemant = current_user.managemants.build(managemant_params)
    @managemant.user_id = current_user.id
    if @managemant.save
      flash[:success] = "入力しました"
      redirect_back(fallback_location: managemants_path)

    else
      redirect_back(fallback_location: managemants_path)
    end
  end

  def destroy
  end

  private

  def managemant_params
    params.require(:managemant).permit(:budget, :result, :result_date, :user_id)
  end
end
