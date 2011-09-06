Gem::Specification.new {|g|
    g.name          = 'rblkid'
    g.version       = '0.0.1'
    g.author        = 'shura'
    g.email         = 'shura1991@gmail.com'
    g.homepage      = 'http://github.com/shurizzle/rblkid'
    g.platform      = Gem::Platform::RUBY
    g.description   = 'libblkid ruby bindings'
    g.summary       = g.description.dup
    g.files         = Dir.glob('lib/**/*')
    g.require_path  = 'lib'
    g.executables   = [ ]
    g.has_rdoc      = true

    g.add_dependency('ffi')
}
