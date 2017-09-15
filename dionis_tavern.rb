require 'optparse'
require './file_worker.rb'
require 'colorize'

OptionParser.new do |parser|
  parser.banner = 'Usage: dionis_tavern [options]'
  parser.on('-m', '--mode MODE', 'Available mods are:',
            ' generate - generate a CSV wine list',
            ' calculate1 - something',
            ' calculate2 - something faster') do |m|
    case m
    when 'generate'
      parser.on('-c', '--count COUNT', 'COUNT bottle of wines that will be created') do |count|

        if count.to_i > 0
          parser.on('-f', '--filename FILE', 'The name of CSV file to write') do |filename|

            file_worker = FileWorker.new(filename, 'w+')

            if file_worker.file_exists
              puts("Overwriting file ".colorize(:green) + filename.colorize(:light_blue) + "\n")
            else
              puts("Creating file ".colorize(:green) + filename.colorize(:light_blue) + "\n")
            end

            file_worker.generate_rows(count.to_i)
          end

        else
          puts 'Wrong count number'.colorize(:red)
        end

      end
    when 'calculate1'
      parser.on('-f', '--filename FILE', 'The name of CSV file to parse') do |filename|
        file_worker = FileWorker.new(filename)
        puts "#{file_worker.read_from_file_v1}" if file_worker.file_exists
      end
    else
      puts 'Wrong mode'
    end
  end

  parser.on_tail('-h', '--help', 'Display this help tip') do ||
    puts parser
  end
end.parse!
