document.addEventListener('DOMContentLoaded', function(){
  'use strict';

  var section = document.querySelectorAll("section");
  var sections = {};
  var i = 0;

  Array.prototype.forEach.call(section, function(e) {
    sections[e.id] = e.offsetTop;
  });

    document.querySelector('.side-item').parentElement.setAttribute('class', 'active');
    
  window.onscroll = function() {
    var scrollPosition = document.documentElement.scrollTop || document.body.scrollTop;
      
    for (i in sections) {
      if (sections[i] <= scrollPosition) {
          var item = document.querySelector('.active div')
          item.parentElement.setAttribute('class', ' ');
          document.querySelector('[href="#' + i + '"]').setAttribute('class', 'active');
      }
    }
  };
})
