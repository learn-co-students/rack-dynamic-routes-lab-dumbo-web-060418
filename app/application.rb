class Application

  @@items = [Item.new("iPhone X", 500), Item.new("Google Pixel", 390)]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      # binding.pry
      item = req.path.split("/items/").last
      if item = @@items.find { |it| it.name == item }
        resp.write item.price
      else
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.status = 404
      resp.write "Route not found"
    end
    resp.finish
  end

end
