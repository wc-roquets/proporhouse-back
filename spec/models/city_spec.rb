# == Schema Information
#
# Table name: cities
#
#  id            :bigint           not null, primary key
#  department_id :bigint           not null
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_cities_on_department_id  (department_id)
#
require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'creation' do
    it 'can be created' do
      country = Country.create!(name: 'Colombia')
      department = Department.create!(country_id: country.id, name: 'Antioquia')
      city = City.create!(department_id: department.id, name: 'Medellin')
      expect(city).to be_valid
    end
    it 'if department not exist cannot create' do
      city = Department.new(name: 'Medellin')
      expect(city).not_to be_valid
    end
    it 'if name is nil cannot be created' do
      country = Country.create!(name: 'Colombia')
      department = Department.create!(country_id: country.id, name: 'Antioquia')
      city = City.new(department_id: department.id, name: nil)
      expect(city).not_to be_valid
    end
    it 'if name is blank cannot be created' do
      country = Country.create!(name: 'Colombia')
      department = Department.create!(country_id: country.id, name: 'Antioquia')
      city = City.new(department_id: department.id, name: '')
      expect(city).not_to be_valid
    end
  end
end
