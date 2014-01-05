require 'spec_helper'

describe PasswordResetsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe 'POST create' do
    it 'is successful' do
      expect {
        post :create, email: 'jordan@email.com'
      }.to change{ActionMailer::Base.deliveries.size}.by(1)
    end

    it 'redirects on success' do
      post :create, email: 'jordan@email.com'
      response.should redirect_to(root_url)
    end

    it 'fails silently with an invalid email' do
      expect {
        post :create, email: 'nadroj@email.com'
      }.not_to change{ActionMailer::Base.deliveries.size}
      response.should redirect_to(root_url)
    end
  end

end
