inferHeaders = require "../"

assert = require "assert"

timestamp = new Date().toUTCString()
expectedHeaders =
  "/": 
    "content-type": "application/octet-stream",
    "last-modified": timestamp
  "/index.html":
    "content-type": "text/html;charset=UTF-8",
    "last-modified": timestamp
  "/some.txt":
    "content-length": "100",
    "etag": "9a77a90ce30586b60c6fc8f333d4c374",
    "content-type": "text/plain;charset=UTF-8",
    "last-modified": timestamp

loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam lectus quam, consectetur ut nullam."
loremIpsumBuffer = new Buffer loremIpsum

describe "inferEntityHeaders", ->
  it "works for '/'", ->
    headers = inferHeaders "/"
    assert.deepEqual headers, expectedHeaders['/']
  it "works for '/index.html'", ->
    headers = inferHeaders "/index.html"
    assert.deepEqual headers, expectedHeaders['/index.html']
  it "works for '/some.txt', Buffer(100)", ->
    headers = inferHeaders "/some.txt", loremIpsumBuffer
    assert.deepEqual headers, expectedHeaders['/some.txt']
  it "works for '/lorem.txt', String(100)", ->
    headers = inferHeaders "/lorem.txt", loremIpsum
    assert.deepEqual headers, expectedHeaders['/some.txt']
