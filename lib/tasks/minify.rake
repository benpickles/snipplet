desc 'Minify bookmarklet.js.'
task :minify do
  require 'closure-compiler'

  minified = Closure::Compiler.new.compile(File.open('public/javascripts/bookmarklet.js', 'r'))

  File.open('public/javascripts/bookmarklet.min.js', 'w') do |f|
    f.write minified
  end

  puts 'Done.'
end
