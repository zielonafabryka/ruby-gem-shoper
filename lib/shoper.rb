require "rest-client"
require "base64"
require "json"

# Shoper REST API main class
class Shoper
  @conf = {}
  @conf[:url] = ENV["SHOPER_URL"]
  @conf[:login] = ENV["SHOPER_USER"]
  @conf[:pass] = ENV["SHOPER_PASS"]
  @conf[:access_token] = ""

  def self.hi
    puts "Hello world!"
  end

  def auth_details
    # ENV.fetch("HTTP_AUTH_USERNAME") + ":" + ENV.fetch("HTTP_AUTH_PASSWORD")
    @conf[:login] + ":" + @conf[:pass]
  end

  def auth
    auth = RestClient::Request.execute(
      method: :post,
      url: @conf[:url] + "/webapi/rest/auth",
      headers: { "Authorization" => "Basic " + Base64::encode64(auth_details) },
    )

    @conf[:access_token] = JSON.parse(auth)["access_token"]
  end
end

# api = RestClient::Resource.new(@conf[:url] + "/webapi/rest",
#                                :headers => {
#                                  :authorization => "Bearer " + @conf[:access_token],
#                                })

# res = api["products"].get :params => { :limit => 50 }
# res = JSON.parse(res)
# page = 1
# while page <= res["pages"]
#   res = api["products"].get :params => { :limit => 50, :page => page }
#   res = JSON.parse(res)
#   res["list"].each { |product|
#     if bc[product["ean"]] != nil && bc[product["ean"]] != product["code"]
#       p "ID: " + product["product_id"] + " EAN: " + product["ean"] + " CODE: " + product["code"] + " NEW CODE: " + bc[product["ean"]]
#       # Update product
#       papi = RestClient::Resource.new(@conf[:url] + "/webapi/rest/products/" + product["product_id"],
#                                       :headers => {
#                                         :authorization => "Bearer " + @conf[:access_token],
#                                       })

#       # bc[product["ean"]]
#       data = { "code" => bc[product["ean"]] }.to_json
#       u = papi.put data, :content_type => :json
#       # p u
#     end
#   }
#   page += 1
# end

# webapi/rest/bulk
