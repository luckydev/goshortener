Dir['**/*_test.rb'].each do |test_case|
  require File.expand_path(test_case)
end
