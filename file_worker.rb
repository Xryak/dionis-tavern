
class FileWorker

  attr_accessor :file_exists, :rows

  @file_exists = false

  def initialize(count = 10)
    @rows = Integer(count)
    @file_exists = true if File.exists?('vineList.csv')
    @file = File.new('vineList.csv', 'w+')
  end

  def generate_rows
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
    @rows.times do
      alcohol = rand(0.3...20).round(2)
      if alcohol >= 16
        type = 'spirtyaga'
      elsif alcohol <= 0.3
        type = 'non-alcoholic'
      elsif alcohol >= 10
        type = 'medium-beverage'
      elsif alcohol < 10
        type = 'light-beverage'
      end
      @file.write("#{names.sample} vintage of year #{rand(1650...2018)},#{alcohol}%,#{volumes.sample} liters,#{rand(50...10000)}$,#{type},#{rand(0...200)} left,#{rand(0...10)} stars\n")
    end

    @file.close
  end
end