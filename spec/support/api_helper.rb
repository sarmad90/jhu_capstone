module ApiHelper
  def parsed_body
    JSON.parse(response.body)
  end

  # automates the passing of payload bodies as json
  ["post", "put", "patch", "get", "head", "delete"].each do |http_method_name|
    define_method("j#{http_method_name}") do |path,params={},headers={}|
      if ["post","put","patch"].include? http_method_name
        headers=headers.merge('content-type' => 'application/json') if !params.empty?
        params = params.to_json
      end
      self.send(http_method_name,
            path,
            params,
            headers.merge(access_tokens))
    end
  end

  def signup(registration, status = :ok)
    post user_registration_path, registration
    expect(response).to have_http_status(status)
    payload = parsed_body
    if response.ok?
      registration.merge(id: payload['data']['id'], uid: payload['data']['uid'])
    end
  end

  def login(credentials, status = :ok)
    post user_session_path, credentials.slice(:email, :password)
    expect(response).to have_http_status(status)
    return response.ok? ? parsed_body['data'] : parsed_body
  end
end
