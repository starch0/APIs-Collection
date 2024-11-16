module Database 

using SQLite
using StructTypes
using DBInterface

const DB_PATH = "proj.db"
const db = SQLite.DB(DB_PATH)

SQLite.execute(db, """
CREATE TABLE IF NOT EXISTS blogpost(
    id INTEGER PRIMARY KEY, 
    title TEXT NOT NULL, 
    content TEXT NOT NULL
)
""")

struct BlogPost
    id::Union{Int, Missing}
    title::String
    content::String
end

StructTypes.StructType(::Type{BlogPost}) = StructTypes.Struct()

function create_blog(blogpost::BlogPost)
    DBInterface.execute(
        db, 
        "INSERT INTO blogpost (title, content) VALUES (?, ?)", 
        (blogpost.title, blogpost.content)
    )
    return "Blog criado com sucesso!"
end

function read_all_blog()
    result = DBInterface.execute(db, "SELECT * FROM blogpost")
    return [BlogPost(row[1], row[2], row[3]) for row in result]
end

function read_blog(id::Int)
    result = DBInterface.execute(
        db, 
        "SELECT * FROM blogpost WHERE id = ?", 
        (id,)
    )
    for row in result
        return BlogPost(row[1], row[2], row[3])
    end
    return nothing
end

function update_blog(blogpost::BlogPost)
    DBInterface.execute(
        db, 
        "UPDATE blogpost SET title = ?, content = ? WHERE id = ?", 
        (blogpost.title, blogpost.content, blogpost.id)
    )
    return "Blog atualizado com sucesso!"
end

function delete_blog(id::Int)
    DBInterface.execute(
        db, 
        "DELETE FROM blogpost WHERE id = ?", 
        (id,)
    )
    return "Blog deletado com sucesso!"
end

export create_blog, read_all_blog, read_blog, update_blog, delete_blog, BlogPost

end
