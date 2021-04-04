require "rails_helper"

RSpec.describe "Api::Registrations", type: :request do
  let!(:user) { build(:user) }
  describe "GET /api/registrations#create" do
    let(:valid_credentials) do
      { user: { email: user.email, password: user.password, first_name: user.first_name, last_name: user.last_name } }
    end
    context "when registrations valid" do
      before { post "/api/users", params: valid_credentials }

      it "return status code 200" do
        expect(response).to have_http_status(200)
      end

      it "return created user" do
        expect(User.where(email: user.email, first_name: user.first_name, last_name: user.last_name)).to exist
      end
    end

    context "when email is empty" do
      before { post "/api/users", params: { user: { password: user.password } } }
      it "return status code 422" do
        expect(response).to have_http_status(422)
      end

      it "return email cannot be blank" do
        expect(response.body).to match(/Email can't be blank/)
      end
    end

    context "when password is empty" do
      before { post "/api/users", params: { user: { email: user.email } } }
      it "return status code 422" do
        expect(response).to have_http_status(422)
      end

      it "return password cannot be blank" do
        expect(response.body).to match(/Password can't be blank/)
      end
    end
  end
end
