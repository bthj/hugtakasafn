// Put the cursor in the search box with its text selected, so typing
// starts a new search.  Lives here rather than inline in the pages so the
// Content-Security-Policy can forbid inline script.
document.addEventListener('DOMContentLoaded', function () {
  var input = document.querySelector('form[name=leit] input[name=leitarord]');
  if (input) {
    input.addEventListener('focus', function () { input.select(); });
    input.focus();
    input.select();
  }
});
