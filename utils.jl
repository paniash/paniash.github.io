function hfun_bar(vname)
  val = Meta.parse(vname[1])
  return round(sqrt(val), digits=2)
end

function hfun_m1fill(vname)
  var = vname[1]
  return pagevar("index", var)
end

function lx_baz(com, _)
  # keep this first line
  brace_content = Franklin.content(com.braces[1]) # input string
  # do whatever you want here
  return uppercase(brace_content)
end

function hfun_timestamp_now()
    return string(Dates.now()) * "+00:00"
end

function hfun_recentblogposts()
    list = readdir("blog")
    filter!(f -> endswith(f, ".md"), list)
    dates = [stat(joinpath("blog", f)).mtime for f in list]
    perm = sortperm(dates, rev=false)
    idxs = perm[1:max(1, length(perm))]
    io = IOBuffer()
    write(io, "<ul>")
    for (k, i) in enumerate(idxs)
        fi = "blog/" * splitext(list[i])[1]
        title = pagevar(fi, "title")
        fi = "/blog/" * splitext(list[i])[1]
        write(io, """<li><a href="$fi">$title</a></li>\n """)
    end
    write(io, "</ul>")
    return String(take!(io))
end
