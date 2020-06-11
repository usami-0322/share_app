class ManegemantsController < ApplicationController
  def index
    # chartkick用データ
    @chart_data = current_user.manegemants.order(result_date: :asc).pluck('result_date', 'result').to_h

    @q = current_user.manegemants.ransack(params[:q])
    @manegemants = @q.result(distinct: true).order(result_date: :desc)
    # 月ごとの売上合計
    sales = current_user.manegemants.group("YEAR(created_at)").group("MONTH(result_date)").sum(:result)
    @total_sales = sales.values.last

    # 日割予算
    today = @manegemants.first.result_date
    last_day = Date.new(today.year, today.month, -1)
    days_left = (last_day - today).to_i
    @daily_budget = (@manegemants.first.budget - @total_sales) / days_left

    # 達成率
    @daily_budget = @total_sales /@manegemants.first.budget * 100

  end

  def create
    @manegemant = Manegemant.new(manegemant_params)
    @manegemant.user_id = current_user.id
    if @manegemant.save
      flash[:success] = "入力しました"
      redirect_to manegemants_path
    else
      redirect_to new_manegemant_path
    end
  end

  def destroy
  end

  private

  def manegemant_params
    params.require(:manegemant).permit(:budget, :result, :result_date, :user_id)
  end
end
