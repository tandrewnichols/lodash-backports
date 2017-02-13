[![Build Status](https://travis-ci.org/tandrewnichols/lodash-backports.png)](https://travis-ci.org/tandrewnichols/lodash-backports) [![downloads](http://img.shields.io/npm/dm/lodash-backports.svg)](https://npmjs.org/package/lodash-backports) [![npm](http://img.shields.io/npm/v/lodash-backports.svg)](https://npmjs.org/package/lodash-backports) [![Code Climate](https://codeclimate.com/github/tandrewnichols/lodash-backports/badges/gpa.svg)](https://codeclimate.com/github/tandrewnichols/lodash-backports) [![Test Coverage](https://codeclimate.com/github/tandrewnichols/lodash-backports/badges/coverage.svg)](https://codeclimate.com/github/tandrewnichols/lodash-backports) [![dependencies](https://david-dm.org/tandrewnichols/lodash-backports.png)](https://david-dm.org/tandrewnichols/lodash-backports) ![Size](https://img.shields.io/badge/size-368b-brightgreen.svg)

# lodash-backports

Backfill lodash aliases and functions that were removed in v4

## Installation

`npm install --save lodash-backports`

## Summary

Lodash v4 removed a bunch of aliases and functions. Some of the aliases I prefer to the non-alias names, and some of the functions seem more semantically intuitive than their replacements (e.g. pluck vs. map). This module backfills those aliases, as well as some removed functions, so that they continue to function as expected. If you have a large code-base, where renaming or removing references to methods that are now gone would make upgrading to lodash v4 impossible, consider using this library as migration stop-gap.

## Usage

Lodash-backports exports a single function, `register`, that uses `_.mixin` to recreate now missing functions and aliases (in the browser, use `window.lodashBackports.register`). There are a variety of ways to use this function. First, you can call it with no parameters. It will `require` lodash, augment it with the missing functions, and return it. This is _probably_ want you want to do.  As this version uses `require('lodash')`, it will modify the global version of lodash (i.e. it will _not_ use `runInContext`), but that's basically the idea of this library. _Anywhere_ you `require('lodash')` now, it will have the missing methods, so if you're trying to backfill, they will be there, but they still shouldn't cause conflicts as only methods that have been removed are being added back.

```js
var _ = require('lodash-backports').register();
// Now use old v3 aliases and functions as normal
```

You can, however, isolate the changes this library makes if you choose to. You can pass in your own copy of lodash:

```js
var _ = require('lodash').runInContext();
_ = require('lodash-backports').register(_);

// Or
var _ = require('lodash');
var v3 = require('lodash-backports').register(_.runInContext());
```

Or you can tell `lodash-backports` to do this for you:

```js
// Passing an options object with "noConflict" tells lodash-backports
// not to augment the main lodash instance, but instead to generate it's own
// using runInContext and to augment that one instead.
var _ = require('lodash-backports').register({ noConflict: true });
```

You can also combine these if, for some reason, that's helpful.

```js
var _ = require('lodash');
_ = require('lodash-backports').register(_, { noConflict: true });
```

Finally, if you only want to create _some_ of the previous aliases and functions, you can pass an `omit` option that is a list of functions _not_ to create.

```js
var _ = require('lodash-backports').register({ noConflict: true, omit: ['foldl', 'foldr', 'backflow'] });
```

## Scope

The scope of this backfill is in progress. All of the aliases removed in v4 have been added, but only a subset of the functions. That's primarily because of the level of work needed to even determine what was removed and what it does. If a function you would like to use is not backfilled by this library, please do open a pull request, and I will add it. That is, in fact, how this library came to exist. It used to be [lodash-aliases](https://github.com/tandrewnichols/lodash-aliases), but when someone asked for `_.pluck` to be backported, which was not an alias, I decided to create this more semantically correct library to support such requests.

## Contributing

Please see [the contribution guidelines](CONTRIBUTING.md).
