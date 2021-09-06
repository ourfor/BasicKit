Pod::Spec.new do |s|
  s.name = "BasicKit"
  s.version = "0.1.0"
  s.summary = "BasicKit make you code simple and easy"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"ourfor"=>"ourfor@qq.com"}
  s.homepage = "https://gitlab.com/ourfor"
  s.description = "BasicKit include common function. It is easy to use."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '9.0'
  s.ios.vendored_framework   = 'ios/BasicKit.framework'
end
