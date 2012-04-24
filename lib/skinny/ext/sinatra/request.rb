module Skinny
  module Ext
    module Sinatra
      module Request

        # Taken from skinny https://github.com/sj26/skinny
        def websocket?
          env['HTTP_CONNECTION'].downcase == 'upgrade' && env['HTTP_UPGRADE'].downcase == 'websocket'
        end

        # Taken from skinny https://github.com/sj26/skinny
        def websocket(options={}, &blk)
          env['skinny.websocket'] ||= begin
            raise RuntimeError, "Not a WebSocket request" unless websocket?
            Skinny::Connection.from_env(env, options, &blk)
          end
        end
      end
    end # module::Sinatra
  end # module::Ext
end # module::Skinny
defined?(Sinatra) && Sinatra::Request.send(:include, Skinny::Ext::Sinatra::Request)
