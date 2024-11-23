# need a test for the index view

require 'rails_helper'

RSpec.describe "reservations/index", type: :view do
  before(:each) do
    assign(:reservations, [
      Reservation.create!(
        name: "Name1",
        phone: "Phone1",
        party_size: 2,
        start_time: Time.current.beginning_of_hour + 1.hour,
        table: Table.create!(capacity: 4, name: "Name1")
      ),
      Reservation.create!(
        name: "Name2",
        phone: "Phone2",
        party_size: 4,
        start_time: Time.current.beginning_of_hour + 1.hour,
        table: Table.create!(capacity: 5, name: "Name2")
      )
    ])
    assign(:reservation, Reservation.new)
  end

  it "renders a list of reservations" do
    render
    assert_select "tr>td", text: "Name1".to_s, count: 1
    assert_select "tr>td", text: "Phone1".to_s, count: 1
    assert_select "tr>td", text: 2.to_s, count: 1
    assert_select "tr>td", text: Time.zone.now.to_s, count: 2
    assert_select "tr>td", text: "Name2".to_s, count: 1
  end
end