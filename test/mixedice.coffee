require 'udefine/global'
mixedice = require '../dist/mixedice'
{expect} = require 'chai'



describe 'mixedice', ->
  it 'empty parameters', ->
    result = mixedice()
    expect(result).to.be('undefined')
