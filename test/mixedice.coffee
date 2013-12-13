require 'udefine/global'
mixedice = require '../dist/mixedice'
{expect} = require 'chai'



describe 'mixedice', ->
  it 'empty parameters', ->
    result = mixedice()
    expect(result).to.be.a('undefined')
    expect(result).to.equal(undefined)
