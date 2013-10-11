require 'simplecov'

SimpleCov.start do
    # Exclude test files from coverage
    add_filter "test_"
end
