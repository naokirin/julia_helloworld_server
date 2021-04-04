module HelloWorldController
using ..HelloWorld
using JSON

export call

function call(message)
  yourname = message["your_name"]

  Dict(:message => HelloWorld.message(yourname)) |> JSON.json
end

end
