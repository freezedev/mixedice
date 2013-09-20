require 'udefine/global'
mixer = require '../dist/mixer'
{expect} = require 'chai'



describe 'mixer', ->
  it 'empty parameters', ->
    result = mixer()
    expect(result).to.be('undefined')
