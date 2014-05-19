require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the EtsyHelper. For example:
#
# describe EtsyHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe EtsyHelper::InstanceMethods do
  context '#proper_case' do
    it "proper cases a name" do
      actor_name = proper_case("kEvIn BaCoN")
      expect(actor_name).to eq "Kevin Bacon"
    end
  end
end
