function sinewave(username) {
  // Alias these for ultra-optimised minification.
  var w = window;
  var d = document;
  var e = encodeURIComponent;

  // Command prompt.
  var prompt = w.prompt('sinewaveapp.com/' + username + ':');

  var query = prompt.split(/\s+/);
  var command = query.shift();
  var location = w.location;

  // Various browser-specific selected-text methods.
  // http://www.codetoad.com/javascript_get_selected_text.asp
  var windowGetSelection = w.getSelection;
  var documentGetSelection = d.getSelection;
  var documentSelection = d.selection;

  // Crazy one-liner-ish ready and willing to be optimized/minified.
  var selectedText = windowGetSelection ? windowGetSelection() :
    (documentGetSelection ? documentGetSelection() :
      (documentSelection ? documentSelection.createRange().text : ''));

  var parameters = [
    'l=' + e(location.href), // FIXME: doesn't work when URL includes "&".
    'q=' + e(query.join(' ')),
    's=' + e(selectedText)
  ];

  // On your marks...
  var url = 'http://sinewaveapp.com/' + username + '/' + command + '?' + parameters.join('&');

  // Go!
  location.href = url;
}
