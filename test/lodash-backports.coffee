clear = require('clear-require')

describe 'lodash-backports', ->
  Given -> @bp = require '../lib/lodash-backports'
  Given -> @subject = require 'lodash'
  afterEach -> clear('lodash')
  
  context 'should include all the aliases', ->
    When -> @bp.register()
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
    When -> @bp.register()
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

  context 'should accept an instance of lodash and augment that one', ->
    When -> @augmented = @bp.register(@subject.runInContext())
    Then -> @augmented.all.should.eql @augmented.every
    And -> @augmented.should.not.eql @subject
    And -> (@subject.all is undefined).should.be.true()

  context 'should not modify the original if opts.noConflict is passed in', ->
    Given -> @context = @subject.runInContext()
    When -> @augmented = @bp.register(@context, noConflict: true)
    Then -> (@context.all is undefined).should.be.true()
    And -> @augmented.all.should.eql @augmented.every
    And -> @augmented.should.not.eql @context

  context 'should omit functions passed in opts.omit', ->
    When -> @bp.register(omit: ['all', 'backflow', 'run'])
    Then ->
      (@subject.all is undefined).should.be.true()
      @subject.any.should.eql @subject.some
      (@subject.backflow is undefined).should.be.true()
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
      (@subject.prototype.run is undefined).should.be.true()
      @subject.select.should.eql @subject.filter
      @subject.unique.should.eql @subject.uniq

    context 'mixes in old functions', ->
      context 'pluck', ->
        Given -> @list = [
          fruit: 'banana'
        ,
          fruit: 'apple'
        ,
          fruit: 'orange'
        ]
        When -> @bp.register()
        Then -> @subject.pluck(@list, 'fruit').should.eql ['banana', 'apple', 'orange']
