describe 'lodash-aliases', ->
  Given -> require '../lib/lodash-aliases'
  Given -> @subject = require 'lodash'
  
  context 'should include all the aliases', ->
    Then ->
      @subject.all.should.eql @subject.every
      @subject.any.should.eql @subject.some
      @subject.backflow.should.eql @subject.flowRight
      @subject.callback.should.eql @subject.iteratee
      @subject.collect.should.eql @subject.map
      @subject.compose.should.eql @subject.flowRight
      @subject.contains.should.eql @subject.includes
      @subject.detect.should.eql @subject.find
      @subject.foldl.should.eql @subject.reduce
      @subject.foldr.should.eql @subject.reduceRight
      @subject.include.should.eql @subject.includes
      @subject.inject.should.eql @subject.reduce
      @subject.methods.should.eql @subject.functions
      @subject.object.should.eql @subject.zipObject
      @subject.prototype.run.should.eql @subject.prototype.value
      @subject.select.should.eql @subject.filter
      @subject.unique.should.eql @subject.uniq

  context 'should make non-chainable aliases non-chainable', ->
    Then ->
      @subject([true, true]).all().should.eql true
      @subject([true, false]).any().should.eql true
      @subject([1]).contains(1).should.eql true
      @subject([{ a: 1 }]).detect('a').should.eql { a: 1 }
      @subject([{ a: 1 }, { a: 2 }]).foldl( (m, o) ->
        m.push(o.a)
        m
      , []).should.eql [1, 2]
      @subject([{ a: 1 }, { a: 2 }]).foldr( (m, o) ->
        m.push(o.a)
        m
      , []).should.eql [2, 1]
      @subject([1]).include(1).should.eql true
      @subject([{ a: 1 }, { a: 2 }]).inject( (m, o) ->
        m.push(o.a)
        m
      , []).should.eql [1, 2]
