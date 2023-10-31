namespace :import do
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




  desc "Import from *_*.log"
  task from_log: :environment do
    Dir["/Volumes/macOS/_sunlab/work/Sklad/Log/*_*.log"].each do |filename|
      shop = filename[-5]

      File.readlines(filename, chomp: true).each do |line|
        # получить переменные
        sale = line.split(',')
        date = DateTime.parse(sale[0])
        puts date
        # заполнить модели
        # сохранить
      end


      abort
    end
  end



  desc "Import users from sklad.xlsx"
  task users_from_sklad_xlsx: :environment do
    sheet = Roo::Excelx.new("/Users/kj/Downloads/sklad.xlsm")
    sheet.default_sheet = 'Пароли'

    sheet.each_with_index(name: 'Кужахметов Олег', password: '6957995') do |hash, index|
      debugger
      user = User.find_or_create_by!(id: index)
      
      User.where(name: hash[:name]).first_or_initialize.tap do |user|
        user.name = hash[:name]

        user.email = "#{next_id}@sunlab.ru"

        user.password = hash[:password]
        while user.password.size < 6
          user.password += hash[:password]
        end

        begin
          user.save!
        rescue ActiveRecord::RecordInvalid => error
          puts "#{error.message}"
          debugger
          Rails.logger.error "#{error.message}"
        end
      end
    end
    sheet.close
    Rails.logger.error "я кончил"
  end




  desc "Import from ods"
  task ods: :environment do
    ods = Roo::OpenOffice.new(Rails.root.join("db", "xls", "1570-0504.ods"))

    ods.each(name: 'Наименование', art: 'Артикул', razd: 'Разделка', price: 'Ценамагазина', code: 'код') do |hash|
      if hash[:name] != 'Наименование'
        # делаем или ищем тип
        # user_type = UserType.create_or_find_by!(name: hash[:user_type])

        Tovar.where(code: hash[:code]).first_or_initialize.tap do |tovar|
          # это tovar.user_type.id = user_type.id
          # tovar.user_type = user_type
          tovar.name = hash[:name]
          tovar.art = hash[:art] unless hash[:art].nil?
          tovar.razd = hash[:razd] unless hash[:razd].nil?
          tovar.price = hash[:price]
          tovar.code = hash[:code]
          tovar.save!
        rescue ActiveRecord::RecordInvalid => error
          debugger
          Rails.logger.error error.message
          ods.close
        end
      end
    end
    ods.close
  end
end
