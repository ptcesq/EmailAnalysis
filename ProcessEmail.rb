require 'rubygems'
require 'sqlite3'

def is_a_number?(s)

  s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true

end


db = SQLite3::Database.open "emailAnalysis.db"

db.execute "DROP TABLE IF EXISTS features"

db.execute "CREATE TABLE features (featureID TEXT,
                              feature TEXT,
                              featureType  TEXT)"

targetPath = './data'
Dir.chdir(targetPath)
count = 0
fileLimit = 2000

@wordList = Array.new()
@wordHash = Hash()

@noiseWords = 	["about","after","all","also","an","and","another","any","are",
               "as","at","be","because","been","before", "being","between","both",
               "but","by","came","can","come","could","did","do","each","for",
               "from","get","got","has","had","he","have","her","here","him",
               "himself","his","how","if","in","into","is","it","like","make",
               "many","me","might","more","most","much","must","my","never",
               "now","of","on","only","or","other","our","out","over","said",
               "same","see","should","since","some","still","such","take","than",
               "that","the","their","them","then","there","these","they","this",
               "those","through","to","too","under","up","very","was","way","we",
               "well","were","what","where","which","while","who","with","would",
               "you","your","a","b","c","d","e","f","g","h","i","j","k","l","m",
               "n","o","p","q","r","s","t","u","v","w","x","y","z","$","1","2",
               "3","4","5","6","7","8","9","0","cc","From"]

@count = 0

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

            # Add the word to the word list and insert into count hash if first time
            if !@wordList.include? currentToken
              @wordList << currentToken

            end

            if @wordList.include? currentToken

            end

            @wordCount = @wordCount + 1
            @wordCount_s = @wordCount.to_s
            @type = "token"
            @token = currentToken.gsub("'", '').downcase
            if @token.include?(".com") or @token.include?(".net") or @token.include?(".org") and @token.include?('@')
              @type = "email"
            end
            if @token.include?("JavaMail.evans@thyme")
              @type = "msgId"
            end

            puts("Insert: " + @wordCount_s)
            db.execute "INSERT INTO features (featureId, feature, featureType) VALUES ('#@wordCount_s', '#@token', '#@type')"
          end
        }
      }

    end
  end
}

db.close

puts('done')