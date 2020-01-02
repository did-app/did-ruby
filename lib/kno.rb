require 'erb'

module Kno
  class Helpers
    def initialize(persona_id, config)
      @persona_id = persona_id
      @config = config
      @template = """
      <% if @persona_id %>
      <form action=\"/session/terminate\" method=\"post\">
      <button type=\"submit\">Sign out</button>
      </form>
      <% else %>
      <form action=\"/session/new\" method=\"post\">
      <script src=\"<%= @config.cdn_host %>/pass.js\" data-site=\"<%= @config.site_token %>\"></script>
      <button type=\"submit\">Sign in</button>
      </form>
      <% end %>
      """
    end

    def session_button()
      ERB.new(@template).result(binding)
    end
  end

  class Config
    attr_reader :api_host, :api_token, :cdn_host, :site_token, :sign_in_redirect
    def initialize(
      api_host: "https://api.trykno.app",
      api_token: "API_AAAAAgDOxdmUqKpE9rw82Jj0Y6DM",
      cdn_host: "https://trykno.app",
      site_token: "site_UITYJw8kQJilzVnux5VOPw",
      sign_in_redirect:
    )
    @api_host = api_host
    @api_token = api_token
    @cdn_host = cdn_host
    @site_token = site_token
    @sign_in_redirect = sign_in_redirect
    end
  end

  class API

    def initialize(config)
      @authenticate_url = format("%s/v0/authenticate", config.api_host)
      @api_token = config.api_token
      @headers = {"Content-Type" => "application/json", "Authorization" => "Basic " + Base64.encode64(config.api_token+":")}
    end

    def authenticate(kno_token)
      params = {token: kno_token}
      resp = Faraday.post(@authenticate_url, params.to_json(), @headers)
      if resp.status == 200
        persona_id = JSON.parse(resp.body)['persona']['id']
      else
        raise ArgumentError
      end

    end
  end

  class Session
    def initialize(app, options)
      @app = app
      @config = Kno::Config.new(options)
      @api = Kno::API.new(@config)
    end

    def call(env)
      req = Rack::Request.new(env)
      persona_id = req.session[:persona_id]
      env['kno'] = Helpers.new(persona_id, @config)
      if env['PATH_INFO'] == "/session/new"
        kno_token = req.params["knoToken"]
        persona_id = @api.authenticate(kno_token)
        req.session[:persona_id] = persona_id
        [303, {'location' => '/'}, nil]
      elsif env['PATH_INFO'] == "/session/terminate"
        req.session.clear
        [303, {'location' => "/"}, nil]
      else
        @app.call(env)
      end
    end
  end
end
