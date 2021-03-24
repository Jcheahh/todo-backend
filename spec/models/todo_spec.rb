require 'rails_helper'

RSpec.describe Todo, :type => :model do
  subject { described_class.new(task: "Swimming", is_done: false) }
  it "is valid when Todo Model is valid" do
    expect(subject).to be_valid
  end

  it "it not valid without a task" do
    subject.task = nil
    expect(subject).to_not be_valid
  end

  it "it not valid without is_done" do
    subject.is_done = nil
    expect(subject).to_not be_valid
  end
end
