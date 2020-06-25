class ManagemantsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def index
    @q = current_user.managemants.ransack(params[:q])
    @managemants = @q.result(distinct: true).paginate(page: params[:page], per_page: 31)
    @managemant = current_user.managemants.build
    @desc_data = current_user.managemants.order(result_date: :desc)
  end

  def create
    @managemant = current_user.managemants.build(managemant_params)
    @managemant.user_id = current_user.id
    if @managemant.save
      flash[:success] = "入力しました"
      redirect_back(fallback_location: managemants_path)
    else
      flash[:danger] = @managemant.errors.full_messages.join("<br>")
      @managemant = current_user.managemants.build(managemant_params)
      redirect_back(fallback_location: managemants_path)
    end
  end

  def destroy
    managemant = Managemant.find(params[:id])
    managemant.destroy
    flash[:success] = "数値を削除しました"
    redirect_to request.referrer || root_url
  end

  private

  def managemant_params
    params.require(:managemant).permit(:budget, :result, :result_date, :user_id)
  end

  def correct_user
    @managemant = current_user.managemants.find_by(id: params[:id])
    redirect_to root_url if @managemant.nil?
  end
end
