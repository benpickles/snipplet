function sinewave(username) {
  var p = window.prompt('sinewaveapp.com/' + username + ':');
  var q = p.split(/\s+/);
  var c = q.shift();
  var u = 'http://sinewaveapp.com/' + username + '/' + c + '?q=' + q.join(' ');
  window.location.href = u;
}
