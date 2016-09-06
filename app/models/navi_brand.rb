class NaviBrand < ApplicationRecord

    ##集計期間 ページ記載の最後の日を終点とした一ヶ月間
    def self.monthly_privider_ranking
        monthly_records = self.monthly_records
        providers = monthly_records.group('provider_name').order('count_all desc').count
        providers.delete('ナビタイムジャパン')
        providers.select{|key, value| 2 <= value}
    end

    def self.monthly_brand_ranking
        monthly_records = self.monthly_records
        brands = monthly_records.group('brand_name').order('count_all desc').count
        brands.select{|key, value| 2 <= value}
    end

    #集計期間のデータに絞る
    def self.monthly_records
        first_day = self.monthly_records_first_day
        last_day = self.monthly_records_last_day
        NaviBrand.where(open_at: first_day..last_day)
    end

    #集計期間の最初の日
    def self.monthly_records_first_day
        NaviBrand.select('open_at').order('open_at asc').first.open_at
    end

    #集計期間の最後の日
    def self.monthly_records_last_day
        self.monthly_records_first_day + 1.month
    end
end
