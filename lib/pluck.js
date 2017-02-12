module.exports = function(list, prop) {
  if (this.isArray(list) && typeof prop === 'string') {
    return this.map(list, prop);
  } else {
    return list;
  }
};

module.exports.chainable = true;
