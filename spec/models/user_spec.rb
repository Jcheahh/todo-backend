require "rails_helper"

RSpec.describe User, type: :model do
  subject { described_class.new(email: "example@example.com", password: "password") }
  it "is valid when User Model is valid" do
    expect(subject).to be_valid
  end

  it "it not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "it not valid without password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end
end
