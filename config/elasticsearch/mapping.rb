require 'elasticsearch'

client = Elasticsearch::Client.new

client.indices.create :index => "walko", :body =>
  {
    :mappings => {
      :ldi => {
        :properties => {
          :nombre => {
            :type => "string",
            :analyzer => "spanish"
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
            :analyzer => "spanish"
          },
          :descripcion => {
            :type => "string",
            :analyzer => "spanish"
          }
        }
      }
    }
  }