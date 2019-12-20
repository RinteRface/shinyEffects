$(function () {
  // pulse handler
  Shiny.addCustomMessageHandler('set-pulse', function(message) {
    console.log(message);
    $(message.selector).css({
      'animation' : 'pulse ' + message.timeout + 's;',
      'animation-iteration-count' : + message.n + ';'
    });
  });
});
