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
        table: Table.create!(capacity: 4, name: "Table1")
      ),
      Reservation.create!(
        name: "Name2",
        phone: "Phone2",
        party_size: 4,
        start_time: Time.current.beginning_of_hour + 2.hour,
        table: Table.create!(capacity: 5, name: "Table2")
      )
    ])
    assign(:reservation, Reservation.new)
  end

  it "renders a list of reservations" do
    render
    assert_select "tr>td", text: "Name1".to_s, count: 1
    assert_select "tr>td", text: "Phone1".to_s, count: 1
    assert_select "tr>td", text: "Name2".to_s, count: 1
    assert_select "tr>td", text: "Phone2".to_s, count: 1
    assert_select "tr>td", text: 2.to_s, count: 1
    assert_select "tr>td", text: 4.to_s, count: 1
    # test for the reservation_time
    assert_select "tr>td", text: (Time.current.beginning_of_hour + 1.hour).strftime("%B %d, %Y at %I:%M %p"), count: 1
    assert_select "tr>td", text: (Time.current.beginning_of_hour + 2.hour).strftime("%B %d, %Y at %I:%M %p"), count: 1
    
  end
end