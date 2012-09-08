require "spec_helper"

describe BarMailer do
  describe "identity_confirmation" do
    let(:mail) { BarMailer.identity_confirmation }

    it "renders the headers" do
      mail.subject.should eq("Identity confirmation")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
