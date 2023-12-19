class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def get_week
    wdays = ['(日)', '(月)', '(火)', '(水)', '(木)', '(金)', '(土)']
  
    @todays_date = Date.today

    @week_days = []

    7.times do |x|
      date = @todays_date + x
      plans = Plan.where(date: date)
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end
    
      wday_num = (@todays_date + x).wday
    
      if wday_num >= 7
        wday_num = wday_num - 7
      end
    
      wday_str = wdays[wday_num]
    
      days = { month: (@todays_date + x).month, date: (@todays_date + x).day, plans: today_plans, wday: wday_str }

      @week_days.push(days)
    end
  end
end