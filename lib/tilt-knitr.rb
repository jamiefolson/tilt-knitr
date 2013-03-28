require 'tilt' unless defined? Tilt
require "open3"

module Tilt
    # knitr template
    # https://github.com/yihui/knitr
    class KnitrTemplate < Template
        def initialize_engine; end

        def prepare; end

        def evaluate(scope, locals, &block)         
                fig_path = Pathname.new(scope.source_dir + "/" + scope.current_page.url).relative_path_from(Pathname.new(scope.root)).to_s
                stdin, stdout, stderr = Open3.popen3('R --vanilla --slave -e "library(knitr);opts_chunk\$set(fig.path=\"'+fig_path+'/figure\");data=readLines(file(\'stdin\'));out=knit(text=data,output=NULL);cat(\'KNITR<<<<<<<<<<<\n\');cat(out)"')
#               err = stderr.readlines.join
#                if ! err.empty?
#                    raise err
#                end
                if !block.nil?
                    raise "Knitr Templates do not support inner blocks!"
                end
                #, locals.merge(scope.is_a?(Hash) ? scope : {}).merge({:yield => block.nil? ? '' : block.call}))
                stdin.write(data)
                stdin.write("\n")
                stdin.close
                $stderr.print stderr.readlines.join
                stdout.readlines.join.sub(/.*KNITR<<<<<<<<<<</m,"")
        end
    end
    register 'Rmd', KnitrTemplate
end
module Middleman::Renderers::Knitr
  class << self
    def registered(app)
      # knitr is not a ruby app, but we can check that it's installed
      begin
      rescue LoadError
      end
    end

    alias :included :registered
  end
end
Middleman::Extensions.register :knitr, Middleman::Renderers::Knitr


