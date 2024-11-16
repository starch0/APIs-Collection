using Oxygen
using HTTP
include("Database.jl")
using .Database

@post "/api/v1/blogs" function(req::HTTP.Request)
    data = Oxygen.json(req, BlogPost)
    create_blog(data)
    return "Blog criado: $(data.title)"
end

@get "/api/v1/blogs" function(req::HTTP.Request)
    data = read_all_blog()
    return Oxygen.json(data)
end

@get "/api/v1/blogs/{blog_id}" function(req::HTTP.Request, blog_id::Int)
    data = read_blog(blog_id)
    return data === nothing ? "Não encontrado!" : Oxygen.json(data)
end

@patch "/api/v1/blogs/{blog_id}" function(req::HTTP.Request, blog_id::Int)
    data = Oxygen.json(req, BlogPost)
    data.id = blog_id
    update_blog(data)
    return "Blog atualizado: $(data.title)"
end

@delete "/api/v1/blogs/{blog_id}" function(req::HTTP.Request, blog_id::Int)
    delete_blog(blog_id)
    return "Blog deletado"
end
