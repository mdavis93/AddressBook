require 'record_manager/base'

class Entry < RecordManager::Base
  belongs_to :address_book

  def to_s
    "Name: #{name}\nPhone Number: #{phone_number}\nEmail: #{email}"
  end
end
