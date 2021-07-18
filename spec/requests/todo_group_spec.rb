require "rails_helper"

RSpec.describe "TodoGroups", type: :request do
  let!(:user) { create(:user) }
  let!(:todo_group) { create(:todo_group, user_id: user.id) }
  let(:todo_group_id) { todo_group.id }
  let(:token) { user.generate_jwt }

  describe "GET /todo_group#show" do
    before { get "/todo_group/#{todo_group_id}", headers: { Authorization: "Bearer #{token}" } }

    context "when todo group exists" do
      it "return the todo group" do
        expect(response.body).not_to be_empty
        expect(json["id"]).to eq(todo_group_id)
      end

      it "return status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the todo group doesn't exists" do
      let(:todo_group_id) { 0 }

      it "return cannot found" do
        expect(response.body).to match(/Couldn't find TodoGroup/)
        expect(json["id"]).not_to eq(todo_group_id)
      end

      it "return status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "POST /todo_group#create" do
    context "when todo group is valid" do
      before { post "/todo_group", params: { title: "Testing" }, headers: { Authorization: "Bearer #{token}" } }

      it "return created todo group" do
        expect(response.body).not_to be_empty
        expect(json["title"]).to eq("Testing")
      end

      it "return status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when todo group is invalid" do
      before { post "/todo_group", headers: { Authorization: "Bearer #{token}" } }

      it "return validate fail" do
        expect(response.body).to match(/Title can't be blank/)
      end

      it "return status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT /todo_group#update" do
    before do
      put "/todo_group/#{todo_group_id}", params: { title: "Testing" }, headers: { Authorization: "Bearer #{token}" }
    end

    context "when todo group exists" do
      it "return the updated todo group" do
        expect(response).to be_successful
      end

      it "return status code 204" do
        expect(response).to have_http_status(204)
      end
    end

    context "when the todo group doesn't exists" do
      let(:todo_group_id) { 0 }

      it "return cannot found" do
        expect(response.body).to match(/Couldn't find TodoGroup/)
        expect(json["id"]).not_to eq(todo_group_id)
      end

      it "return status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "DELETE /todo_group#destroy" do
    before { delete "/todo_group/#{todo_group_id}", headers: { Authorization: "Bearer #{token}" } }

    context "when todo group exists" do
      it "return status code 204" do
        expect(response).to have_http_status(204)
      end

      it "deleted" do
        expect(response).to be_successful
      end
    end

    context "when the todo group doesn't exists" do
      let(:todo_group_id) { 0 }

      it "return cannot found" do
        expect(response.body).to match(/Couldn't find TodoGroup/)
        expect(json["id"]).not_to eq(todo_group_id)
      end

      it "return status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end
end
