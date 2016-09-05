class NoticeMailer < ApplicationMailer

  default from: 'notifications@example.com'

  def daily_report
    @provider_ranking = NaviBrand.monthly_privider_ranking
    @brand_ranking = NaviBrand.monthly_brand_ranking

    mail(
        to: 'r-okinaga@gc-story.com',
        subject: Date.today.strftime('%Y年%m月%d日')
    )
  end
end
