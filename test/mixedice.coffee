require 'udefine/global'
mixer = require '../dist/mixedice'
{expect} = require 'chai'



describe 'mixedice', ->
  it 'empty parameters', ->
    result = mixer()
    expect(result).to.be('undefined')
