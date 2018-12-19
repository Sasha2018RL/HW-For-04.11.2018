require 'yaml'

class Contacts
  # { :id, :name, :email } - поля хранимых контактов
  def initialize
    @storage_file = "storage/contacts.yaml"
    @storage = YAML.load_file(@storage_file)
    @storage = @storage.nil? ? Array.new : @storage
  end

  def all
    @storage
  end

  def create(contact_name, email)
    id = @storage.empty? ? 1 : @storage.last[:id]+1
    @storage << { id: id, name: contact_name, email: email }
    File.open(@storage_file, 'w') { |h| h.write @storage.to_yaml }
  end

  def find(id)
    @storage.each do |contact|
      if contact[:id] == id
        return contact
      end
    end
    nil
  end
end
