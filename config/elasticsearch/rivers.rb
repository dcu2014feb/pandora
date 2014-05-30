require 'elasticsearch'

client = Elasticsearch::Client.new

client.create :index => "_river", :type => "ldi", :id => "_meta", :body =>
  {
    :type => :jdbc,
    :jdbc => {
      :driver => "org.postgresql.Driver",
      :url =>  "jdbc:postgresql://localhost:5432/walko",
      :user => "walko_es",
      :password => "walko_es",
      :index => "walko",
      :type => "ldi",
      :sql => "select id as _id, * from ldis"
    }
  }

client.create :index => "_river", :type => "poblacion", :id => "_meta", :body =>
  {
    :type => :jdbc,
    :jdbc => {
      :driver => "org.postgresql.Driver",
      :url =>  "jdbc:postgresql://localhost:5432/walko",
      :user => "walko_es",
      :password => "walko_es",
      :index => "walko",
      :type => "poblacion",
      :sql => "select id as _id, * from poblacions"
    }
  }