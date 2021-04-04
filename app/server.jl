using HTTP, JSON, Sockets

include("routes.jl")

struct TimeoutError <: Exception end

function run(host, port)
  println("Start to server: listen to $host:$port")
  HTTP.serve(host, port, reuseaddr=true, rate_limit=100000//1) do request::HTTP.Request
    path = request.target
    println("Request $path")
    payload = Nothing
    try
      payload = JSON.parse(IOBuffer(HTTP.payload(request)))
    catch e
      println("500 Internal Server Error: $e")
      Base.showerror(Base.stdout, e, catch_backtrace())
      return HTTP.Response(500, "Error: $e")
    end

    channel = Channel(spawn=false) do ch
      try
        answer = routes(path, payload)
        isopen(ch) && put!(ch, HTTP.Response(answer))
      catch e
        println("500 $e")
        Base.showerror(Base.stdout, e, catch_backtrace())
        isopen(ch) && put!(ch, HTTP.Response(500, "Error: $e"))
      end
    end

    timedwait(() -> isready(channel), 5.0)

    if !isready(channel)
      isopen(channel) && close(channel)
      println("408 Timeout")
      return HTTP.Response(408, "Error: Request Timeout")
    end
    result = take!(channel)
    isopen(channel) && close(channel)
    return result
  end
end

function main()
  host = "0.0.0.0"
  port = 80
  run(host, port)
end; main()
