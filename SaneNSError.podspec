Pod::Spec.new do |s|
    s.name         = "SaneNSError"
    s.version      = "1.0"
    s.summary      = "Quadrilaterals on CALayer, CGGeometry-functions, UIView/CALayer properties and other invaluable tools."
    s.homepage     = "https://github.com/hfossli/SaneNSError"
    s.license      = 'MIT'
    s.platform      = :ios, '5.0'
    s.requires_arc  = true
    s.authors      = { 
    	"Håvard Fossli" => "hfossli@gmail.com",
    	}
    s.source       = { 
        :git => "https://github.com/hfossli/SaneNSError.git",  
        :tag => s.version.to_s
        }
        
    s.frameworks    = 'Foundation'
    s.source_files  = 'Source/**/*.{h,m}'

end
