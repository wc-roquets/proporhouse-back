# == Schema Information
#
# Table name: promise_purchases
#
#  id                      :bigint           not null, primary key
#  user_id                 :bigint           not null
#  offer_id                :bigint           not null
#  status_promise_purchase :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_promise_purchases_on_offer_id  (offer_id)
#  index_promise_purchases_on_user_id   (user_id)
#
require 'rails_helper'

RSpec.describe PromisePurchase, type: :model do
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
      promise_purchase = PromisePurchase.create!(offer_id: offer.id, user_id: user.id,
                                                 status_promise_purchase: 1)
      expect(promise_purchase).to be_valid
    end
    it 'if offer not exist cannot be created' do
      user = User.create!(email: 'admin@example.com', password: 'password')
      promise_purchase = PromisePurchase.new(user_id: user.id, status_promise_purchase: 1)
      expect(promise_purchase).not_to be_valid
    end
    it 'if user not exist cannot be created' do
      country = Country.create!(name: 'Colombia')
      department = Department.create!(country_id: country.id, name: 'Antioquia')
      city = City.create!(department_id: department.id, name: 'Medellin')
      neighborhood = Neighborhood.create!(city_id: city.id, name: 'Robledo')
      user = User.create!(email: 'admin@example.com', password: 'password')
      property = Property.create!(neighborhood_id: neighborhood.id, user_id: user.id,
                                  address: 'calle 10 sur')
      offer = Offer.create!(property_id: property.id, user_id: user.id, price: 100_000_000,
                            expires: Time.zone.now + 5.days)
      promise_purchase = PromisePurchase.new(offer_id: offer.id, status_promise_purchase: 1)
      expect(promise_purchase).not_to be_valid
    end
  end
end
