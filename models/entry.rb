require 'record_manager/base'

class Entry < RecordManager::Base

  def to_s
    "Name: #{name}\nPhone Number: #{phone_number}\nEmail: #{email}"
  end
end
