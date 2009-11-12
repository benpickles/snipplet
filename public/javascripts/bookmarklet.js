function sinewave(username) {
  var w = window;
  var e = encodeURIComponent;
  var prompt = w.prompt('sinewaveapp.com/' + username + ':');
  var query = prompt.split(/\s+/);
  var command = query.shift();
  var location = w.location;
  var parameters = [
    'l=' + e(location.href),
    'q=' + e(query.join(' '))
  ]
  var url = 'http://sinewaveapp.com/' + username + '/' + command + '?' + parameters.join('&');
  location.href = url;
}
