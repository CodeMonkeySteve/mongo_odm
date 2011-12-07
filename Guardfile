group 'specs' do
  guard 'rspec', all_after_pass: false, cli: '--color --format nested' do  # --fail-fast --drb
    watch(%r{(^|/)\.'}) {}          # ignore dot files
    watch('spec/spec_helper.rb')    { 'spec' }
    watch(%r{^spec/(.+)_spec\.rb})
  end
end