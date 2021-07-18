require "rails_helper"

RSpec.describe "Todos", type: :request do
  let!(:user) { create(:user) }
  let!(:todo_group) { create(:todo_group, user_id: user.id) }
  let!(:todo) { create(:todo, todo_group_id: todo_group.id) }
  let(:todo_group_id) { todo_group.id }
  let(:todo_id) { todo.id }
  let(:token) { user.generate_jwt }

  describe "GET /todos" do
    before { get "/todo_group/#{todo_group_id}/todos", headers: { Authorization: "Bearer #{token}" } }

    it "return todos!" do
      expect(response.body).not_to be_empty
    end

    it "return status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /todos#create" do
    let(:valid_attributes) { { task: "Swimming", is_done: "false" } }
    context "when the todos is valid" do
      before do
        post "/todo_group/#{todo_group_id}/todos", params: valid_attributes,
                                                   headers: { Authorization: "Bearer #{token}" }
      end
      it "return created todos" do
        expect(json["task"]).to eq("Swimming")
        expect(json["is_done"]).to eq(false)
      end

      it "return status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the todos is invalid" do
      before do
        post "/todo_group/#{todo_group_id}/todos", params: { task: "Jogging" },
                                                   headers: { Authorization: "Bearer #{token}" }
      end
      it "return status code 422" do
        expect(response).to have_http_status(422)
      end

      it "return validate fail" do
        expect(response.body).to match(/Validation failed/)
      end
    end
  end

  describe "PUT /todos#update" do
    context "when the task valid" do
      before do
        put "/todo_group/#{todo_group_id}/todos/#{todo_id}", params: { task: "Playing Badminton" },
                                                             headers: { Authorization: "Bearer #{token}" }
      end

      it "return status code 204" do
        expect(response).to have_http_status(204)
      end

      it "return updated task" do
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /todos#destroy" do
    before do
      delete "/todo_group/#{todo_group_id}/todos/#{todo_id}",
             headers: { Authorization: "Bearer #{token}" }
    end
    it "return status code 204" do
      expect(response).to have_http_status(204)
    end

    it "deleted" do
      expect(response).to be_successful
    end
  end
end
