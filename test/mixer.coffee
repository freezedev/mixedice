require 'udefine/global'
mixer = require '../dist/udefine'
{expect} = require 'chai'

describe 'mixer', ->
  it 'empty parameters', ->
    result = mixer()
    expect(result).to.be('undefined')
