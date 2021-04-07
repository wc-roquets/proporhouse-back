# == Schema Information
#
# Table name: offers
#
#  id           :bigint           not null, primary key
#  property_id  :bigint           not null
#  user_id      :bigint           not null
#  price        :float
#  expires      :date
#  status_offer :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_offers_on_property_id  (property_id)
#  index_offers_on_user_id      (user_id)
#
require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe 'creation' do
    it 'can be created' do
      country = Country.create!(name: 'Colombia')
      department = Department.create!(country_id: country.id, name: 'Antioquia')
      city = City.create!(department_id: department.id, name: 'Medellin')
      neighborhood = Neighborhood.create!(city_id: city.id, name: 'Robledo')
      user = User.create!(email: 'admin@example.com', password: 'password')
      property = Property.create!(neighborhood_id: neighborhood.id, user_id: user.id,
                                  address: 'calle 10 sur')
      offer = Offer.create!(property_id: property.id, user_id: user.id, price: 100_000_000,
                            expires: Time.zone.now + 5.days)
      expect(offer).to be_valid
    end
    it 'if property not exist cannot be created' do
      user = User.create!(email: 'admin@example.com', password: 'password')
      offer = Offer.new(user_id: user.id, price: 100_000_000, expires: Time.zone.now + 5.days)
      expect(offer).not_to be_valid
    end
    it 'if user not exist cannot be created' do
      country = Country.create!(name: 'Colombia')
      department = Department.create!(country_id: country.id, name: 'Antioquia')
      city = City.create!(department_id: department.id, name: 'Medellin')
      neighborhood = Neighborhood.create!(city_id: city.id, name: 'Robledo')
      user = User.create!(email: 'admin@example.com', password: 'password')
      property = Property.create!(neighborhood_id: neighborhood.id, user_id: user.id,
                                  address: 'calle 10 sur')
      offer = Offer.new(property_id: property.id, price: 100_000_000,
                        expires: Time.zone.now + 5.days)
      expect(offer).not_to be_valid
    end
    it 'if price not exist cannot be created' do
      country = Country.create!(name: 'Colombia')
      department = Department.create!(country_id: country.id, name: 'Antioquia')
      city = City.create!(department_id: department.id, name: 'Medellin')
      neighborhood = Neighborhood.create!(city_id: city.id, name: 'Robledo')
      user = User.create!(email: 'admin@example.com', password: 'password')
      property = Property.create!(neighborhood_id: neighborhood.id, user_id: user.id,
                                  address: 'calle 10 sur')
      offer = Offer.new(property_id: property.id, expires: Time.zone.now + 5.days)
      expect(offer).not_to be_valid
    end
    it 'if address not exist cannot be created' do
      country = Country.create!(name: 'Colombia')
      department = Department.create!(country_id: country.id, name: 'Antioquia')
      city = City.create!(department_id: department.id, name: 'Medellin')
      neighborhood = Neighborhood.create!(city_id: city.id, name: 'Robledo')
      user = User.create!(email: 'admin@example.com', password: 'password')
      property = Property.create!(neighborhood_id: neighborhood.id, user_id: user.id,
                                  address: 'calle 10 sur')
      offer = Offer.new(property_id: property.id, user_id: user.id, price: 100_000_000)
      expect(offer).not_to be_valid
    end
  end
end
