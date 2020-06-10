Ransack.configure do |config|
  config.add_predicate :during_year,
                       arel_predicate: :between,
                       formatter: proc { |x, v |
                         Time.zone.parse("#{x.year}, #{v.month}, 1").to_date...Time.zone.parse("#{v.year + 1}, #{v.month}, -1").to_date
                       },
                       type: :date
end