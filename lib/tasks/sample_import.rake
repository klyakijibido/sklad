namespace :sample_import do
  desc "Import from sklad.xlsx"
  task product_from_sklad: :environment do
    Rails.logger.error "начал в #{Time.now}"

    sheet = Roo::Excelx.new("/Users/kj/Downloads/sklad.xlsm")
    sheet.default_sheet = 'Товар'

    sheet.each(name: 'Наименование', art: 'Артикул', razd: 'Разделка', sor: 'Сорт', price: 'Цена ', price_buy: 'Цена поставки',
               code: 'Код', provider_s: 'Поставщик', country_s: 'страна', plant_s: 'Завод', ean13: 'штрихкод') do |hash|

      next if hash[:name] == 'Наименование' || hash[:name].nil? || hash[:code].nil?
      # next if hash[:code] < 700

      # puts hash.inspect

      hash.transform_values! do |value|
        if value.is_a?(String)
          value.squish! if value != value.squish
          value = nil if value.empty?
        end
        value
      end
      # puts hash.inspect

      product_type = ProductType.find_or_create_by!(name: 'na')
      provider = Provider.find_or_create_by!(name: hash[:provider_s] ||= 'na')
      country = Country.find_or_create_by!(name: hash[:country_s] ||= 'na')
      plant = Plant.find_or_create_by!(name: hash[:plant_s] ||= 'na')

      # debugger
      Product.where(id: hash[:code]).first_or_initialize.tap do |product|
        # Product.where(code: hash[:code]).first_or_initialize.tap do |product|
        next unless product.new_record?

        product.name = hash[:name]
        product.art = hash[:art]
        product.razd = hash[:razd]
        product.sor = hash[:sor]

        product.price = hash[:price] ||= 0
        product.price_buy = hash[:price_buy] ||= 0
        product.code = hash[:code]
        product.provider = provider
        product.country = country
        product.plant = plant

        puts product.code if product.code % 100 == 0
        begin
          product.save!
        rescue ActiveRecord::RecordInvalid => error
          debugger
          Rails.logger.error "Ошибка: код #{product.id} - #{error.message}"
          raise(error)
        end
      end
    end
    sheet.close
    Rails.logger.error "закончил в #{Time.now}"
  end


end
