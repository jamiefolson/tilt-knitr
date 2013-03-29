require 'tilt' unless defined? Tilt
require "open3"

module Tilt
    # knitr template
    # https://github.com/yihui/knitr
    class KnitrTemplate < Template
        @fig_path = "figure"
        def initialize_engine; 
                stdin, stdout, stderr = Open3.popen3('R --vanilla --slave -e "library(knitr)"')
               err = stderr.readlines.join
                if ! err.empty?
                    raise LoadError, err
                end
        end

        def prepare; end

        def evaluate(scope, locals, &block)
                fig_path = @fig_path
                if locals.has_key? "fig.path"
                    fig_path = locals["fig.path"]
                end
                stdin, stdout, stderr = Open3.popen3('R --vanilla --slave -e "library(knitr);opts_chunk\$set(fig.path=\"'+fig_path+'\");data=readLines(file(\'stdin\'));out=knit(text=data,output=NULL);cat(\'KNITR<<<<<<<<<<<\n\');cat(out)"')
                if !block.nil?
                    raise "Knitr Templates do not support inner blocks!"
                end
                #, locals.merge(scope.is_a?(Hash) ? scope : {}).merge({:yield => block.nil? ? '' : block.call}))
                stdin.write(data)
                stdin.write("\n")
                stdin.close
                $stderr.print stderr.readlines.join
                stdout.readlines.join.sub(/.*KNITR<<<<<<<<<<</m,"").strip
        end
    end
    register 'Rmd', KnitrTemplate
end

