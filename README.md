[![Build Status](https://travis-ci.org/tandrewnichols/lodash-aliases.png)](https://travis-ci.org/tandrewnichols/lodash-aliases) [![downloads](http://img.shields.io/npm/dm/lodash-aliases.svg)](https://npmjs.org/package/lodash-aliases) [![npm](http://img.shields.io/npm/v/lodash-aliases.svg)](https://npmjs.org/package/lodash-aliases) [![Code Climate](https://codeclimate.com/github/tandrewnichols/lodash-aliases/badges/gpa.svg)](https://codeclimate.com/github/tandrewnichols/lodash-aliases) [![Test Coverage](https://codeclimate.com/github/tandrewnichols/lodash-aliases/badges/coverage.svg)](https://codeclimate.com/github/tandrewnichols/lodash-aliases) [![dependencies](https://david-dm.org/tandrewnichols/lodash-aliases.png)](https://david-dm.org/tandrewnichols/lodash-aliases) ![Size](https://img.shields.io/badge/size-368b-brightgreen.svg)

# lodash-aliases

Backfill lodash aliases that were removed in v4

## Installation

`npm install --save lodash-aliases`

## Summary

Lodash v4 removed a bunch of aliases, several of which I prefer to the non-alias names. This module backfills those aliases so that they continue to function as expected. The list of aliases backfilled by this module are: all (every), any (some), backflow (flowRight), callback (iteratee), collect (map), compose (flowRight), contains (includes), detect (find), foldl (reduce), foldr (reduceRight), include (includes), inject (reduce), methods (functions), object (zipObject), select (filter), and unique (uniq), as well as the prototypal #run (#value).

This module is for those who prefer some of these aliases to the actual function names and for anyone who has a large code base that already uses some of these aliases but wants to upgrade to lodash v4.

## Usage

In node, requiring this function will extend lodash (if present) with the missing methods. Lodash is listed as an peer dependency because this module is intended to be used in projects along side an existing lodash install, and this module will not work if it doesn't have access to the dependent's version of lodash.

```js
require('lodash-aliases');
var _ = require('lodash');
_.any([1, 2, 3], function(num) {
  return num % 2 === 0;
}); // true
```

In the browser, you have even less work to do. By simply including `dist/lodash-aliases.js` or `dist/lodash-aliases.min.js` in a script or in a build bundle, lodash will automatically be extended on load.

## Contributing

Please see [the contribution guidelines](CONTRIBUTING.md).
