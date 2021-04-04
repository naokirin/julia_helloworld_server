module HelloWorldServer

function allsources(dir)
  contents = String[]
  for (root, dirs, files) in walkdir(dir)
    push!.(Ref(contents), joinpath.(root, filter(x -> splitext(x)[2] == ".jl", files)))
  end
  return contents
end

srcdir = @__DIR__
for file in allsources(srcdir * "/models")
  println(file)
  include(file)
end

for file in allsources(srcdir * "/controllers")
  println(file)
  include(file)
end
end
