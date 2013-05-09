require 'rubygems'
require 'sqlite3'

Dir["**/*"].each { |fileName|

  if !File.directory?(fileName)

    f = File.readlines(fileName)

    if File.extname(fileName) != '.cats' and count <= fileLimit

      count = count + 1

      puts('Current File: ' + fileName + "  Count: " + count.to_s)
      @wordCount = 0
      f.each {|cline|
        cline = cline.gsub('/',' ').gsub('\\',' ')
        tokens = cline.split
        tokens.each { |currentToken|
          # Pull out Junk
          currentToken = currentToken.gsub('<','').gsub('>','').gsub('-','').gsub(':','').gsub('(','').gsub(')','').gsub(',','').gsub('?','').gsub('"','').gsub(';','').gsub('=','')
          # Pull out the periods, but not on emails.
          if !currentToken.include?("@")
            currentToken = currentToken.gsub('.','')
          end

          if !@noiseWords.include? currentToken and !is_a_number?(currentToken) and currentToken.length >= 3
            currentToken = currentToken.gsub("'", '')
            # Check to see if the hash has the key, if so increment otherwise add

          end
        }
      }
    end
  end
}