parseURL = require("url").parse
mime = require "mime"
crypto = require "crypto"

module.exports = (url, entity = undefined, inputHeaders = {}) ->
  path = parseURL(url).path
  headers = {}
  for headerName in Object.keys(inputHeaders)
    headers[headerName.toLowerCase()] = inputHeaders[headerName]
  if entity? and (entity instanceof Buffer or isString entity)
    unless headers["content-length"]?
      headers["content-length"] = if isString entity then new Buffer(entity).length else entity.length
    unless headers["etag"]?
      headers["etag"] = crypto.createHash('md5').update(entity).digest("hex")
  unless headers["content-type"]?
    headers["content-type"] = mime.lookup path
    if charset = mime.charsets.lookup headers["content-type"]
      headers["content-type"] += ";charset=#{charset}"
  unless headers["last-modified"]?
    headers["last-modified"] = new Date().toUTCString()
  headers
  
isString = (entity) ->
  entity instanceof String or typeof entity is "string"