class ManagemantsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def index
    @q = current_user.managemants.ransack(params[:q])
    @managemants = @q.result(distinct: true).paginate(page: params[:page], per_page: 31)
    @managemant = current_user.managemants.build
    @desc_data = current_user.managemants.order(result_date: :desc)

    ## TODO: ↓はmanagemantモデルのクラスメソッドにする方が良い
    # 月間予算達成率
    today = @desc_data.latest_result_date
    if @managemants.pluck(:result_date).empty?
      @daily_budget = 0
    else
      last_day = Date.new(today.year, today.month, -1)
      days_left = (last_day - today).to_i
      if days_left == 0
        @daily_budget = @desc_data.latest_budget - current_user.managemants.total_sales
      else
        @daily_budget = (@desc_data.latest_budget - current_user.managemants.total_sales) / days_left
      end
    end

    ## TODO: ↓はmanagemantモデルのクラスメソッドにする方が良い
    # 進捗率
    @end_of_month = Date.new(Time.now.year, Time.now.month, -1).mday.to_f
    if @managemants.pluck(:result_date).empty?
      @progress_rate = 0
    else
      today_day = @desc_data.latest_result_date.mday.to_f
      @progress_rate = (current_user.managemants.total_sales.to_f / (@desc_data.latest_budget.to_f / @end_of_month * today_day) * 100).round(1)
    end
  end

  def create
    @managemant = current_user.managemants.build(managemant_params)
    @managemant.user_id = current_user.id
    if @managemant.save
      ## TODO: こういうフラッシュメッセージの設定は親クラスレベルで共通化した方が良いかもしれません
      flash[:success] = "入力しました"
      redirect_back(fallback_location: managemants_path)
    else
      ## TODO: こういうフラッシュメッセージの設定は親クラスレベルで共通化した方が良いかもしれません
      flash[:danger] = @managemant.errors.full_messages.join("<br>")
      @managemant = current_user.managemants.build(managemant_params)
      redirect_back(fallback_location: managemants_path)
    end
  end

  def destroy
    ## TODO: @はいらないような気がします
    @managemant = Managemant.find(params[:id])
    @managemant.destroy
    flash[:success] = "数値を削除しました"
    redirect_to request.referrer || root_url
  end

  private

  def managemant_params
    params.require(:managemant).permit(:budget, :result, :result_date, :user_id)
  end

  def correct_user
    @managemant = current_user.managemants.find_by(id: params[:id])
    ## TODO: コレはTOPページに戻るという仕様で良いのでしょうか？
    redirect_to root_url if @managemant.nil?
  end
end
