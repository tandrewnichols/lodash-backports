;(function() {
  var isNode = typeof module !== 'undefined' && this.module !== module;
  var _;

  if (isNode) {
    try {
      _ = require('lodash');
    } catch (e) {
      // Do nothing
    }
  } else {
    _ = window._;
  }

  if (_) {
    _.mixin({
      all: _.every,
      any: _.some,
      contains: _.includes,
      detect: _.find,
      foldl: _.reduce,
      foldr: _.reduceRight,
      include: _.includes,
      inject: _.reduce
    }, { chain: false });

    _.mixin({
      backflow: _.flowRight,
      callback: _.iteratee,
      collect: _.map,
      compose: _.flowRight,
      methods: _.functions,
      object: _.zipObject,
      select: _.filter,
      unique: _.uniq
    });

    _.prototype.run = _.prototype.value;
  }

  if (isNode) {
    module.exports = {};
  }
})();
