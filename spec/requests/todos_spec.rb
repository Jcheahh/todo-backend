require "rails_helper"

RSpec.describe "Todos", type: :request do
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }

  describe "GET /todos" do
    before { get "/todos" }

    it "return todos!" do
      expect(response.body).not_to be_empty
      expect(json.length).to eq(10)
    end

    it "return status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /todos#show" do
    before { get "/todos/#{todo_id}" }

    context "when the todos exists" do
      it "return the todos" do
        expect(response.body).not_to be_empty
        expect(json["id"]).to eq(todo_id)
      end

      it "return status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the todos doesn't exists" do
      let(:todo_id) { 0 }

      it "return status code 404" do
        expect(response).to have_http_status(404)
      end

      it "return cannot found" do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  describe "POST /todos#create" do
    let(:valid_attributes) { { task: "Swimming", is_done: "false" } }
    context "when the todos is valid" do
      before { post "/todos", params: valid_attributes }
      it "return created todos" do
        expect(json["task"]).to eq("Swimming")
        expect(json["is_done"]).to eq(false)
      end

      it "return status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the todos is invalid" do
      before { post "/todos", params: { task: "Jogging" } }
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
      before { put "/todos/#{todo_id}", params: { task: "Playing Badminton" } }

      it "return status code 204" do
        expect(response).to have_http_status(204)
      end

      it "return updated task" do
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /todos#destroy" do
    before { delete "/todos/#{todo_id}" }
    it "return status code 204" do
      expect(response).to have_http_status(204)
    end

    it "deleted" do
      expect(response).to be_successful
    end
  end
end
