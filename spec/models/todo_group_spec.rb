require "rails_helper"

RSpec.describe TodoGroup, type: :model do
  let(:user) { create(:user) }
  subject { described_class.new(title: "Task of today", user_id: user.id) }
  it "is valid when TodoGroup Model is valid" do
    expect(subject).to be_valid
  end

  it "is invalid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is invalid without a user" do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end
end
