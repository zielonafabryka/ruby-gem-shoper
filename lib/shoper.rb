require "rest-client"
require "base64"
require "json"

# Shoper REST API main class
class Shoper
  def initialize(shoper_url, shoper_username, shoper_password)
    @configuration = {
      :shoper => {},
    }
    @configuration[:shoper][:url] = shoper_url
    @configuration[:shoper][:api] = @configuration[:shoper][:url] + "/webapi/rest/"
    @configuration[:shoper][:username] = shoper_username
    @configuration[:shoper][:password] = shoper_password
    self.get_token
  end

  def get_token
    r = RestClient::Request.execute(
      method: :post,
      url: @configuration[:shoper][:url] + "/webapi/rest/auth",
      headers: {
        "Authorization" => "Basic " + Base64::encode64(
          @configuration[:shoper][:username] + ":" + @configuration[:shoper][:password]
        ),
      },
    )
    j = JSON.parse(r)
    @configuration[:shoper][:token] = j["access_token"]
    @configuration[:shoper][:token_expires] = Time.now + j["expires_in"]
    @configuration[:shoper][:token_type] = j["token_type"]
  end

  # Shoper.resource(resource, action, params, id, data)
  #  * get    -> /aboutpages/<id>
  #  * update -> /aboutpages/<id>
  #  * delete -> /aboutpages/<id>
  #  * insert -> /aboutpages
  #  * list   -> /aboutpages
  def resource(resource, action, data = { :id => nil, :params => nil, :data => nil })
    case action
    when "get", "update", "delete"
      endpoint = resource + "/" + data[:id]
    when "insert", "list"
      endpoint = resource
    else
      return { :error => true }
    end

    pp endpoint
    # Check if Shoper Token is still valid
    self.get_token if Time.now > @configuration[:shoper][:token_expires]

    r = RestClient::Resource.new(@configuration[:shoper][:api] + endpoint,
                                 :headers => {
                                   :authorization => "Bearer " +
                                                     @configuration[:shoper][:token],
                                 })

    case action
    when "get"
      res = r.get :params => data[:params]
    when "update"
      res = r.put data[:data].to_json, :content_type => :json
    when "delete"
      res = r.delete
    when "insert"
      pp data[:data].to_json
      res = r.post data[:data].to_json, :content_type => :json
    when "list"
      res = r.get
    else
      return { :error => true }
    end
    pp JSON.parse(res)
  end
end
