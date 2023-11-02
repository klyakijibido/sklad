namespace :import do
  desc 'Import from sklad.xlsx'
  task product_from_sklad: :environment do
    abort "Отключил, чтобы не прогнать по-запаре"

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

  desc 'Import replays from txt'
  task replays_from_txt: :environment do
    File.readlines(Rails.root.join("db", "txt", "replays.txt"), chomp: true).each do |line|
      arr = line.split(',')
      product = Product.find(arr[0].to_i)
      puts product
      product_copy = product.dup
      product_copy.id = arr[1].to_i
      product_copy.save
    end
  end

  desc 'Import Operation from *_*.log'
  task operation_from_log: :environment do
    Dir['/Users/kj/_sunlab/work/Sklad/Log/????-?.log'].each do |filename|
      shop = Shop.find(filename[-5].to_i)
      puts filename

      File.readlines(filename, chomp: true).each do |line|
        arr = line.split(',')

        product_id = arr[1]
        if Product.exists?(product_id)
          product = Product.find(product_id)
        else
          bad_product = BadProduct.find_or_create_by!(id: product_id)
          bad_product.increment!(:repit, 1)
          next
        end

        # operation_type = OperationType.find(arr[5])
        # user = User.find(arr[6])
        # disco_card = DiscoCard.find_or_create_by!(id: arr[7])
        # cash_register = CashRegister.find_or_create_by!(id: arr[8])
        #
        # operation = Operation.new
        # operation.date_created = DateTime.parse(arr[0])
        # operation.product = product
        # operation.quantity = arr[2].to_f
        # operation.sale_price = arr[3].to_f
        # operation.discount_percent = arr[4].to_i
        # operation.operation_type = operation_type
        # operation.user = user
        # operation.disco_card = disco_card
        # operation.cash_register = cash_register
        # operation.rest_before = arr[9].to_f
        # operation.shop = shop
        #
        # operation.save
      end


      # abort "как-то так"
    end
  end


  desc "Import users from sklad.xlsx"
  task users_from_sklad_xlsx: :environment do
    sheet = Roo::Excelx.new("/Users/kj/Downloads/sklad.xlsm")
    sheet.default_sheet = 'Пароли'

    sheet.each_with_index(name: 'Кужахметов Олег', password: '6957995') do |hash, index|
      puts "#{index + 1}. #{hash[:name]}"
      User.where(id: index + 1).first_or_initialize.tap do |user|
        next unless user.new_record?
        user.name = hash[:name]
        user.save!
      end

    end
    sheet.close
  end

  desc "Import OperationType from sklad_prg.xlsx"
  task operation_types_from_sklad_prg: :environment do
    sheet = Roo::Excelx.new("/Users/kj/Downloads/sklad_prg.xlsm")
    # sheet.default_sheet = 'Пароли'

    sheet.each(id: 'код', name: 'сокр.', multiplier_cash: 'множ налички', multiplier_quantity: 'множ остатка') do |hash|
      next if hash[:name] == 'сокр.'

      puts "#{hash[:id]} - #{hash[:name]}"
      OperationType.where(id: hash[:id]).first_or_initialize.tap do |operation_type|
        next unless operation_type.new_record?

        operation_type.name = hash[:name]
        operation_type.multiplier_cash = hash[:multiplier_cash]
        operation_type.multiplier_quantity = hash[:multiplier_quantity]

        operation_type.save!
      end

    end
    sheet.close
  end


end
