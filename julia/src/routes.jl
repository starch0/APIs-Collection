using Oxygen
using HTTP
include("Database.jl")
using .Database
using JSON3

struct BlogPost
    id::Int
    title::String
    content::String
end

@post "/api/v1/blogs" function(req::HTTP.Request)
    data = Oxygen.json(req, BlogPost)
    create_blog(data)
    return Oxygen.json(Dict("message" => "Blog criado", "title" => data.title))
end

@get "/api/v1/blogs" function(req::HTTP.Request)
    data = read_all_blog()
    return Oxygen.json(data)
end

@get "/api/v1/blogs/{blog_id}" function(req::HTTP.Request, blog_id::Int)
    data = read_blog(blog_id)
    return data === nothing ? Oxygen.json(Dict("error" => "Não encontrado")) : Oxygen.json(data)
end

@patch "/api/v1/blogs/{blog_id}" function(req::HTTP.Request, blog_id::Int)
    data = Oxygen.json(req, BlogPost)
    data.id = blog_id
    update_blog(data)
    return Oxygen.json(Dict("message" => "Blog atualizado", "title" => data.title))
end

@delete "/api/v1/blogs/{blog_id}" function(req::HTTP.Request, blog_id::Int)
    delete_blog(blog_id)
    return Oxygen.json(Dict("message" => "Blog deletado"))
end
