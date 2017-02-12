;(function() {
  var isNode = typeof module !== 'undefined' && this.module !== module;

  var isLodashInstance = function(_) {
    return _ && _.partial && _.partial.placeholder && _.isEqual(_, _.partial.placeholder);
  };

  var backports = {
    register: function(_, opts) {
      if (!isLodashInstance(_)) {
        opts = _;
        _ = null;
      }

      opts = opts || {};

      if (!_ && isNode) {
        try {
          _ = require('lodash');
        } catch (e) {
          // Do nothing
        }
      } else if (!_) {
        _ = window._;
      }

      if (_) {

        if (opts.noConflict) {
          _ = _.runInContext();
        }

        var reduce = function(memo, fn) {
          delete memo[fn];
          return memo;
        };

        var nonChainable = _.reduce(opts.omit, reduce, {
          all: _.every,
          any: _.some,
          contains: _.includes,
          detect: _.find,
          foldl: _.reduce,
          foldr: _.reduceRight,
          include: _.includes,
          inject: _.reduce
        });

        var mixins = _.reduce(opts.omit, reduce, _.clone(require('./mixins')));

        var chainable = _.reduce(opts.omit, reduce, {
          backflow: _.flowRight,
          callback: _.iteratee,
          collect: _.map,
          compose: _.flowRight,
          methods: _.functions,
          object: _.zipObject,
          select: _.filter,
          unique: _.uniq
        });

        var pickChainable = function(val) {
          return Boolean(val.chainable);
        };

        var pickNonChainable = function(val) {
          return !pickChainable(val);
        };

        _.mixin(nonChainable, { chain: false });
        _.mixin(chainable);
        _.mixin(_.pickBy(mixins, pickNonChainable), { chain: false });
        _.mixin(_.pickBy(mixins, pickChainable));

        if (!opts.omit || opts.omit.indexOf('run') === -1) {
          _.prototype.run = _.prototype.value;
        }
      }

      return _;
    }
  };

  if (isNode) {
    module.exports = backports;
  } else {
    window.lodashBackports = backports;
  }
})();
