require 'elasticsearch'

client = Elasticsearch::Client.new

client.create :index => "_river", :type => "ldi", :id => "_meta", :body =>
  {
    :type => :jdbc,
    :jdbc => {
      :driver => "org.postgresql.Driver",
      :url =>  "jdbc:postgresql://localhost:5432/" + ENV['dbname'],
      :user => ENV['dbuser'],
      :password => ENV['dbpass'],
      :index => ENV['dbname'],
      :type => "ldi",
      :sql => "select id as _id, * from ldis",
      :schedule => "0 0-59 0-23 ? * *"
    }
  }

client.create :index => "_river", :type => "poblacion", :id => "_meta", :body =>
  {
    :type => :jdbc,
    :jdbc => {
      :driver => "org.postgresql.Driver",
      :url =>  "jdbc:postgresql://localhost:5432/" + ENV['dbname'],
      :user => ENV['dbuser'],
      :password => ENV['dbpass'],
      :index => ENV['dbname'],
      :type => "poblacion",
      :sql => "select id as _id, * from poblacions",
      :schedule => "0 0-59 0-23 ? * *"
    }
  }