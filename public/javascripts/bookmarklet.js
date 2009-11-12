function sinewave(username) {
  var prompt = window.prompt('sinewaveapp.com/' + username + ':');
  var query = prompt.split(/\s+/);
  var command = query.shift();
  var location = window.location.href;
  var parameters = [
    'l=' + encodeURIComponent(location),
    'q=' + encodeURIComponent(query.join(' '))
  ]
  var url = 'http://sinewaveapp.com/' + username + '/' + command + '?' + parameters.join('&');
  window.location.href = url;
}
