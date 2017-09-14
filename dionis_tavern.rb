require 'optparse'
require './file_worker.rb'

OptionParser.new do |parser|
  parser.banner = 'Usage: dionis_tavern [options]'
  parser.on('-m', '--mode MODE', 'Available mods are:',
            ' generate - generate a CSV wine list',
            ' calculate v1 - something',
            ' calculate v2 - something faster') do |m|
    case m
    when 'generate'
      parser.on('-c', '--count COUNT',
                'COUNT bottle of wines that will be created') do |count|
        file_worker = FileWorker.new(count)

        if file_worker.file_exists
          puts("Overwriting file...\n")
        else
          puts("Creating file...\n")
        end

        file_worker.generate_rows

      end
    when 'calculate v1'
      parser.on('-f', '--filepath FILE') do |filename|
        # TODO: implement calculation v1 & v2
      end
    else
      puts 'Wrong mode'
    end
  end

  parser.on_tail('-h', '--help', 'Display this help tip') do ||
    puts parser
  end
end.parse!