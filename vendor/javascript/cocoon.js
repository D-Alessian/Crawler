// cocoon@0.1.1 downloaded from https://ga.jspm.io/npm:cocoon@0.1.1/lib/index.js

var r={};function pre_wrap(r,e,t){r[t]=e[t];delete e[t]}function post_wrap(r,e,t){delete e[t];e[t]=r[t]}function wrap_property(r,e,t,n){pre_wrap(e,t,n);t[n]=function(){return e[n]};return r}function restore_all(r,e,t){Object.keys(e).forEach(post_wrap.bind(null,e,t));e={};return r}function wrap_object(r){var e={},t={};t.wrap=wrap_property.bind(null,t,e,r);t.restore=restore_all.bind(null,t,e,r);return t}r={spin:wrap_object};var e=r;const t=e.spin;export default e;export{t as spin};

