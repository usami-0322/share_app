class ManagemantsController < ApplicationController
  before_action :authenticate_user!

  def index
    # 検索用
    @q = current_user.managemants.ransack(params[:q])
    @managemants = @q.result(distinct: true)
    @search = @managemants.order(result_date: :desc)
    # chartkick用データ
    @chart_data = @managemants.order(result_date: :asc).pluck('result_date', 'result').to_h
    @managemant = current_user.managemants.build
    desc_data = current_user.managemants.order(result_date: :desc)
    # 売上
    @latest_budget = desc_data.pluck(:budget).first.to_i
    @latest_date = desc_data.pluck(:result_date).first
    @latest_result = desc_data.pluck(:result).first.to_i
    # 月ごとの売上合計
    sales = current_user.managemants.group("YEAR(created_at)").group("MONTH(result_date)").sum(:result)
    @total_sales = sales.values.last.to_i
    # 日割予算
    today = @latest_date
    if Managemant.pluck(:result_date).empty?
      @daily_budget = 0
    else
      last_day = Date.new(today.year, today.month, -1)
      days_left = (last_day - today).to_i
      @daily_budget = (@latest_budget - @total_sales) / days_left
    end
    # 達成率
    @achievement_rate = @total_sales / @latest_budget.to_i * 100 rescue 0
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
