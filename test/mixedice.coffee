require 'udefine/global'
mixedice = require '../dist/mixedice'
{expect} = require 'chai'



describe 'mixedice', ->
  it 'empty parameters', ->
    result = mixedice()
    expect(result).to.be.a('undefined')
    expect(result).to.equal(undefined)

  it 'mixing in two objects', ->
    obj1 =
      a: 4
      
    obj2 =
      b: 'test'
      
    result = mixedice obj1, obj2
    expect(result).to.be.a('object')
    expect(result).to.equal({a: 4, b: 'test'})
