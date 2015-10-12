json.array! @builds do |build|
  json.title build.title
  json.id build.id
  json.url build.url
  json.skill build.skill ? build.skill.name : 'none'
  json.char build.char

  json.author do
    json.name build.author.name
    json.id build.author.id
  end
end
