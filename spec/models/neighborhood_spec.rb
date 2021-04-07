# == Schema Information
#
# Table name: neighborhoods
#
#  id         :bigint           not null, primary key
#  city_id    :bigint           not null
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_neighborhoods_on_city_id  (city_id)
#
require 'rails_helper'

RSpec.describe Neighborhood, type: :model do
  describe 'creation' do
    it 'can be created' do
      country = Country.create!(name: 'Colombia')
      department = Department.create!(country_id: country.id, name: 'Antioquia')
      city = City.create!(department_id: department.id, name: 'Medellin')
      neighborhood = Neighborhood.create!(city_id: city.id, name: 'Robledo')
      expect(neighborhood).to be_valid
    end
    it 'if city not exist cannot create' do
      neighborhood = Neighborhood.new(name: 'Robledo')
      expect(neighborhood).not_to be_valid
    end
    it 'if name is nil cannot be created' do
      country = Country.create!(name: 'Colombia')
      department = Department.create!(country_id: country.id, name: 'Antioquia')
      city = City.new(department_id: department.id, name: 'Medellin')
      neighborhood = Neighborhood.new(city_id: city.id, name: nil)
      expect(neighborhood).not_to be_valid
    end
    it 'if name is blank cannot be created' do
      country = Country.create!(name: 'Colombia')
      department = Department.create!(country_id: country.id, name: 'Antioquia')
      city = City.new(department_id: department.id, name: '')
      neighborhood = Neighborhood.new(city_id: city.id, name: nil)
      expect(neighborhood).not_to be_valid
    end
  end
end
