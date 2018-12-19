require 'yaml'

class Posts
  # { :id, :title, :text } - поля хранимых `объектов` (постов)
  def initialize
    @config = "storage/posts.yaml"
    @storage = YAML.load_file(@config)
    @storage = @storage.nil? ? Array.new : @storage
  end

  def all
    @storage
  end

  def create(title, text)
    id = @storage.empty? ? 1 : @storage.last[:id]+1
    @storage << { id: id, title: title, text: text }
    File.open(@config, 'w') { |h| h.write @storage.to_yaml }
  end

  def find(id)
    @storage.each do |post|
      if post[:id] == id
        return post
      end
    end
    nil
  end
end
