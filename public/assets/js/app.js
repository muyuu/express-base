var app;

app = app || {};


/**
 * object - オブジェクトを作る
 * Object object(BaseObj [, mixinObj1 [, mixinObj2...]])
 */

if (!app.extend) {
  app.extend = function(o) {
    var f, i, len, n, prop;
    f = function() {};
    i = void 0;
    len = void 0;
    n = void 0;
    prop = void 0;
    f.prototype = o;
    n = new f;
    i = 1;
    len = arguments.length;
    while (i < len) {
      for (prop in arguments[i]) {
        continue;
      }
      ++i;
    }
    return n;
  };
}


/**
 * ダックタイピングによる型判別関数
 * プロパティの型だけ比較するタイプ
 */

if (!app.is) {
  app.is = function(obj, proto) {
    var p;
    for (p in proto) {
      if (typeof proto[p] !== typeof obj[p]) {
        return false;
      }
    }
    return true;
  };
}


/**
 * 配列か否かの判定メソッドのポリフィル
 * Array.isArray
 * @param none
 * @return boolean
 */
if (!Array.isArray) {
  Array.isArray = function(vArg) {
    return Object.prototype.toString.call(vArg) === "[object Array]";
  };
}


/**
 * 引数をprototyeとするオブジェクトの作成メソッドのポリフィル
 * Object.create
 * @param object
 * @return object new object
 */

if (!Object.create) {
  Object.create = function(o) {
    var F;
    F = function() {};
    if (arguments_.length > 1) {
      throw new Error("敬称元オブジェクトを引数に記述してください");
    }
    F.prototype = o;
    return new F();
  };
}


/**
 * bindのポリフィル
 * Function.prototype.bind
 * @param object
 * @return object
 */

if (!Function.prototype.bind) {
  Function.prototype.bind = function(oThis) {
    var aArgs, fBound, fNOP, fToBind;
    if (typeof this !== "function") {
      throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable");
    }
    aArgs = Array.prototype.slice.call(arguments_, 1);
    fToBind = this;
    fNOP = function() {};
    fBound = function() {
      return fToBind.apply((this instanceof fNOP && oThis ? this : oThis), aArgs.concat(Array.prototype.slice.call(arguments_)));
    };
    fNOP.prototype = this.prototype;
    fBound.prototype = new fNOP();
    return fBound;
  };
}

var app;

app = app || {};

(function($, w, app) {})(jQuery, window, app);

$(function() {
  var tabnParam;
  tabnParam = {
    tabs: '.tab__list',
    tab: '.tab__item',
    contents: '.tab__content',
    content: '.tab__body',
    animation: true
  };
  if ($('.tab--tab01')[0]) {
    return $('.tab--tab01').tabn(tabnParam);
  }
});
