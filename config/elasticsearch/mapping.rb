require 'elasticsearch'

client = Elasticsearch::Client.new

client.indices.create :index => ENV['dbname'], :body =>
  {
    :mappings => {
      :ldi => {
        :properties => {
          :nombre => {
            :type => "string",
            :analyzer => "spanish",
            :boost => 5.0
          },
          :categoria => {
            :type => "string",
            :analyzer => "spanish"
          },
          :descripcion => {
            :type => "string",
            :analyzer => "spanish"
          }
        }
      },
      :poblacion => {
        :properties => {
          :nombre => {
            :type => "string",
            :analyzer => "spanish",
            :boost => 3.0
          },
          :descripcion => {
            :type => "string",
            :analyzer => "spanish"
          }
        }
      }
    }
  }