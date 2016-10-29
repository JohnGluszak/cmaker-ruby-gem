Gem::Specification.new do |s|
  s.name        = 'cmaker'
  s.version     = '0.0.1'
  s.date        = '2016-10-27'
  s.summary     = "C++ project management"
  s.description = "A convenient way to get C++ projects running with Google Test"
  s.authors     = ["John Gluszak"]
  s.email       = 'john.gluszak@gmail.com'
  s.files       = ['lib/cmaker.rb', 'lib/cmaker/strings.rb', 'lib/cmaker/file.rb']
  s.homepage    = 'https://github.com/JohnGluszak/'
  s.license     = 'MIT'

  s.add_runtime_dependency "git", ["= 1.3.0"]

  s.executables << 'cmaker'
end
