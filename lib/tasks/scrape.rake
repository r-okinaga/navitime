require 'net/http'
require 'open-uri'
require 'json'
require 'date'

#Jsonデータの、どこから表示されるかを指定する数値
#この2つの数値でその日のデータを網羅できる
FIRST = 0
SECOND = 20

namespace :scrape do

    desc 'NAVITIMEから新規出店の店舗一覧を取得'

    task navitime: :environment do
        def get_items(date, num)
            uri = URI.parse("https://www.navitime.co.jp/newspot/more?from=#{date}&region=&category=&offset=#{num}")
            json = Net::HTTP.get(uri)

            JSON.parse(json)["items"]
        end

        def save_items(spots = {})
            spots.each do |spot|
                begin
                    unless NaviBrand.exists?(brand_name: split_name(spot["name"])[:brand_name], store_name: split_name(spot["name"])[:store_name])
                        brand = NaviBrand.new
                        brand.original_name = spot["name"]
                        brand.provider_name = spot["provider"]["name"]
                        brand.brand_name = split_name(spot["name"])[:brand_name]
                        brand.store_name = split_name(spot["name"])[:store_name]
                        brand.kana = spot["ruby"]
                        brand.tel_no = spot["phone"]
                        brand.address = spot["address_name"]
                        brand.postal_code = spot["postal_code"]
                        brand.category_name = spot["categories"].first["name"]
                        brand.open_at = Date.parse(spot["open"])
                        brand.save!
                    end
                rescue
                    next
                end
            end
        end

        def split_name(str)
            brand = str.split
            brand_name = ''
            store_name = ''

            case brand.count
                when 1
                    brand_name = str
                else
                    store_name = brand.pop
                    brand_name = brand.join
            end
            {brand_name: brand_name,
             store_name: store_name}
        end

        [FIRST, SECOND].each do |n|
            today = (Date.today).strftime("%Y-%m-%d")
            spots = get_items("2016-09-08", n)
            save_items(spots)
        end
    end
end
