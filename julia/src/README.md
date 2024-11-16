Create blog
    Method: POST
    Route: /blogs

    Body:
        {title: "titulo",
        "content": "conteudo"}

List blogs  
    Method:GET
    Route: /blogs

    Resposta: 
        {{
        "id": 1,
        "title": "titulo",
        "content": "conteudo"
        }}

List x blog
    Method: GET
    Route: /blogs/{blog_id}
    Param: `blog_id`

Att blog
    Method: PATCH
    Route: /blogs/{blog_id}
    Params:`blog_id`
    Body:
        {"title": "new title",
        "content": "new content"
        }
    
Delete blog
    Method: DELETE
    Route: /blogs/{blog_id}
    Params: `blog_id`