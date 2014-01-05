require "spec_helper"

describe UserMailer do
  describe "password_reset" do
    let(:mail) do
      user = users(:jordan)
      user.password_reset_token = SecureRandom.urlsafe_base64
      UserMailer.password_reset(user)
    end

    it "renders the headers" do
      mail.subject.should eq("Password Reset")
      mail.to.should eq(["jordan@email.com"])
      mail.from.should eq(["noreply@portrait.com"])
    end

    it "renders the body" do
      url = /http:\/\/localhost:3000\/password_resets\/.+\/edit\r\n/
      mail.body.encoded.should match(url)
    end
  end

end
