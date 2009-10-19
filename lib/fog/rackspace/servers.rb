module Fog
  module Rackspace
    class Servers

      def self.reload
        load "fog/rackspace/models/servers/server.rb"
        load "fog/rackspace/models/servers/servers.rb"

        load "fog/rackspace/requests/servers/create_image.rb"
        load "fog/rackspace/requests/servers/create_server.rb"
        load "fog/rackspace/requests/servers/delete_image.rb"
        load "fog/rackspace/requests/servers/delete_server.rb"
        load "fog/rackspace/requests/servers/get_server_details.rb"
        load "fog/rackspace/requests/servers/list_flavors.rb"
        load "fog/rackspace/requests/servers/list_images.rb"
        load "fog/rackspace/requests/servers/list_servers.rb"
        load "fog/rackspace/requests/servers/list_servers_details.rb"
        load "fog/rackspace/requests/servers/reboot_server.rb"
        load "fog/rackspace/requests/servers/update_server.rb"
      end

      def initialize(options={})
        credentials = Fog::Rackspace.authenticate(options)
        @auth_token = credentials['X-Auth-Token']
        uri = URI.parse(credentials['X-Server-Management-Url'])
        @host   = uri.host
        @path   = uri.path
        @port   = uri.port
        @scheme = uri.scheme
        @connection = Fog::Connection.new("#{@scheme}://#{@host}:#{@port}")
      end

      def request(params)
        response = @connection.request({
          :body     => params[:body],
          :expects  => params[:expects],
          :headers  => {
            'X-Auth-Token' => @auth_token
          },
          :host     => @host,
          :method   => params[:method],
          :path     => "#{@path}/#{params[:path]}"
        })
        unless response.body.empty?
          response.body = JSON.parse(response.body)
        end
        response
      end

    end
  end
end
Fog::Rackspace::Servers.reload