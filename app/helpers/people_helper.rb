module PeopleHelper
  def years_old(person)
    return if person.birthday.nil?

    [Date.current.year - person.birthday.year, 'лет'].join(' ')
  end

  def name_and_years(person)
    [person.full_name, years_old(person)].compact.join(', ')
  end
end
