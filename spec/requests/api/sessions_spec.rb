require "rails_helper"

RSpec.describe "Api::Sessions", type: :request do
  let!(:user) { create(:user) }
  describe "GET /api/sessions#create" do
    let(:valid_credentials) { { user: { email: user.email, password: user.password } } }
    context "when login valid" do
      before { post "/api/users/sign_in", params: valid_credentials }

      it "return status code 200" do
        expect(response).to have_http_status(200)
      end

      it "return created user" do
        expect(User.where(email: user.email, encrypted_password: user.encrypted_password)).to exist
      end
    end

    context "when email is invalid" do
      before { post "/api/users/sign_in", params: { user: { email: user.email + "1", password: user.password } } }
      it "return status code 404" do
        expect(response).to have_http_status(404)
      end

      it "return couldn't find user" do
        expect(response.body).to match(/Couldn't find User/)
      end
    end

    context "when email is not present" do
      before { post "/api/users/sign_in", params: { user: { email: "", password: user.password } } }
      it "return status code 404" do
        expect(response).to have_http_status(404)
      end
    end

    context "when password is incorrect" do
      before { post "/api/users/sign_in", params: { user: { email: user.email, password: "" } } }
      it "return status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end
end
