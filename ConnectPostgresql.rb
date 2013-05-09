require 'pg'


conn = PGconn.open( :hostaddr=>"127.0.0.1", :port=>5432, :dbname=>"FirstStudent", :user=>"postgres", :password=>'ptc6601')
res  = conn.exec('select tablename, tableowner from pg_tables')

res.each do |row|
  row.each do |column|
    puts column
  end
end