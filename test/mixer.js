(function() {
  var expect, mixer;

  require('udefine/global');

  mixer = require('../dist/mixer');

  expect = require('chai').expect;

  describe('mixer', function() {
    return it('empty parameters', function() {
      var result;
      result = mixer();
      return expect(result).to.be('undefined');
    });
  });

}).call(this);
