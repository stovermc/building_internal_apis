require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get "/api/v1/items"

    expect(response).to be_success

    items = JSON.parse(response.body)
    item = items.first

    expect(items.count).to eq(3)
    expect(item).to have_key("id")
    expect(item).to have_key("name")
    expect(item).to have_key("description")
  end

  it "can get one item by id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(id)
  end

  it "can create a new item" do
    item_params = { name: "Cheese Curds", description: "Good"}

    expect {
      post("/api/v1/items", params: {item: item_params})
    }.to change{ Item.count }.by(1)
    # parmas.require(:item).permit(:name, :description)

    # post("/api/v1/items", params: item_params)
    # parmas.permit(:name, :description)

    item = Item.last
    raw_item = JSON.parse(response.body)
    expect(response).to be_success
    expect(item.name).to eq(item_params[:name])
    expect(raw_item["name"]).to eq(item_params[:name])

  end
end
