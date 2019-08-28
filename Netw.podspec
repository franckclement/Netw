Pod::Spec.new do |spec|
  spec.name         = "Netw"
  spec.version      = "0.0.1"
  spec.summary      = "Netw is an iOS wrapper around URLSession that allows you to define clean HTTP requests."
  spec.description  = <<-DESC
  Netw provides a clean way to define and make your networking calls. It supports standard HTTP methods as well as multipart/formdata media upload.
                   DESC
  spec.homepage     = "https://github.com/franckclement/Netw"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Franck CLEMENT" => "franck.clmnt@gmail.com" }
  spec.social_media_url   = "https://twitter.com/Francklement"
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/franckclement/Netw.git", :tag => "#{spec.version}" }
  spec.source_files  = "Netw/**/*.swift", "Netw/*.swift"
  spec.swift_version = "5.0"
end
