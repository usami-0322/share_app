class ManegemantsController < ApplicationController
  def index
    # chartkick用データ
    @data = [['2019-06-01', 100], ['2019-06-02', 200], ['2019-06-03', 150]]

    @q = current_user.manegemants.ransack(params[:q])
    @manegemants = @q.result(distinct: true).order(result_date: :desc)

    # 月ごとの販売実績
    sales = current_user.manegemants.group("YEAR(created_at)").group("MONTH(result_date)").sum(:result)
    @total_sales = sales.values

    # 予算比
    @result = @manegemants.first.result
    @budget = @manegemants.first.budget
    @result_date = @manegemants.first.result_date
    @budget_ratio = @result / @budget

    # 日割り計算
    today = Date.today
    last_day = Date.new(today.year, today.month, -1)
    days_left = (last_day - today).to_i
    @daily_budget = (@budget - @result) / days_left
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
