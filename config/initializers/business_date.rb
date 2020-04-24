# 2015/1/1から翌年末までの営業日を範囲とする
start_date = Time.zone.parse('2015-01-01 00:00:00')
end_date = Time.zone.parse('2051-01-01 00:00:00')

# 営業日計算ライブラリの営業時間を終日に指定
BusinessTime::Config.beginning_of_workday = "00:00:00 am"
BusinessTime::Config.end_of_workday = "11:59:59 pm"

# 営業日計算ライブラリへ日本の祝祭日情報を読み込み
HolidayJp.between(start_date, end_date).each{|h| BusinessTime::Config.holidays << h.date }

# 追加で独自の年末年始休暇を取り込み
# 12/29-1/3まではお正月休みとする
(start_date.year..end_date.year).each do |year|
  BusinessTime::Config.holidays << Date.new(year, 1, 2)
  BusinessTime::Config.holidays << Date.new(year, 1, 3)
  BusinessTime::Config.holidays << Date.new(year, 12, 29)
  BusinessTime::Config.holidays << Date.new(year, 12, 30)
  BusinessTime::Config.holidays << Date.new(year, 12, 31)

end
