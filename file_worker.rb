require 'csv'
require 'colorize'

class FileWorker

  attr_accessor :file_exists, :filename

  @file_exists = false

  def initialize(filename, mode = 'r')
    @filename = filename
    @file_exists = true if File.exists?(filename)
    if !@file_exists && mode == 'r'
      puts("File ".colorize(:red) + filename.colorize(:light_blue) + " not found".colorize(:red) + "\n")
    else
      @file = File.open(filename, mode)
    end
  end

  def generate_rows(rows)
    names = ['Primitivo',
             'Dom Perignon',
             'Penfolds Grange',
             'Silver Oak',
             'Louis Latour',
             'Lewis',
             'Ridge',
             'Hamilton Russell',
             'Domaine Serene',
             'Sojourn',
             'Cayuse',
             'Fattoria di Felsina']
    volumes = [0.25, 0.5, 1, 1.5]

    rows.times do
      alcohol = rand(0.3...20).round(2)

      if alcohol >= 16
        type = 'spirtyaga'
      elsif alcohol <= 1
        type = 'non-alcoholic'
      elsif alcohol >= 8
        type = 'medium-beverage'
      elsif alcohol < 8
        type = 'light-beverage'
      end

      @file.write("#{names.sample} vintage #{rand(1650...2018)},#{alcohol}%,#{volumes.sample} liters,#{rand(50...10000)}$,#{type},#{rand(0...200)} left,#{rand(0...10)} stars\n")
    end

    @file.close
  end

  # Counts average price of all drinks in warehouse
  # Sort drinks by rating in it's category
  def read_from_file_v1
    rating = { "spirtyaga" => 0, "non-alcoholic" => 0, "medium-beverage" => 0, "light-beverage" => 0}
    count = { "spirtyaga" => 0, "non-alcoholic" => 0, "medium-beverage" => 0, "light-beverage" => 0}
    CSV.read(@filename).map do |row|
      puts "Total price of #{row[0].colorize(:red)} is " + ((row[3].to_i * row[5].to_i).to_s << '$').colorize(:green)
      rating[row[4]] += row[6].to_i
      count[row[4]] += 1
    end
    rating.each do |key, value|
      puts "Average rating of #{key.colorize(:light_blue)} is " + ((value / count[key]).to_s << ' stars').colorize(:yellow)
    end
  end
end
