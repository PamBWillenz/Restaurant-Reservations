require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ReservationsHelper. For example:
#
# describe ReservationsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ReservationsHelper, type: :helper do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "#reservation_time" do
    it "returns the formatted time" do
      reservation = build(:reservation, start_time: "2024-01-01 14:00:00")
      expect(helper.reservation_time(reservation)).to eq("2:00 PM")
    end
  end
end
