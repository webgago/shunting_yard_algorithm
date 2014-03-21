guard 'rspec', all_on_start: false, all_after_pass: true do
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^spec/(.+)\.rb$})
end