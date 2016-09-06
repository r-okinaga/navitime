class NoticeMailer < ApplicationMailer

  default from: 'crawler.gc-story.local'

  def daily_report
    @first_day = NaviBrand.monthly_records_first_day
    @last_day = NaviBrand.monthly_records_last_day
    @provider_ranking = NaviBrand.monthly_privider_ranking
    @brand_ranking = NaviBrand.monthly_brand_ranking

    mail(
        to: 'sign_sales@gc-story.com, sys-dev@gc-story.com',
        subject: "NAVITIMEデイリーレポート_" + Date.today.strftime('%Y%m%d')
    )
  end
end
