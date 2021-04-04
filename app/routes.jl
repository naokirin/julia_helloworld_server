using HelloWorldServer: HelloWorldController

function handler(f, jsonpayload)
  return f(jsonpayload)
end

function routes(path, payload)
  if path == "/hello_world"
    return handler(HelloWorldController.call, payload)
  else
    throw(ErrorException("No route matches."))
  end
end


