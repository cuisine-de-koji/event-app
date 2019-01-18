module UsersHelper
  def events(date1)
	  Meeting.find_by(date: date1)
	end
end
