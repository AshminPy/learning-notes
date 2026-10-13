// Instant-feedback multiple choice for every .mcq block on the page.
// Each block: data-answer="<value>", radio inputs, a <button>, .feedback and .why elements.
document.querySelectorAll('.mcq').forEach(function (q) {
  var btn = q.querySelector('button');
  var feedback = q.querySelector('.feedback');
  var why = q.querySelector('.why');
  btn.addEventListener('click', function () {
    var picked = q.querySelector('input[type="radio"]:checked');
    if (!picked) {
      feedback.textContent = 'Pick an answer first.';
      feedback.className = 'feedback';
      return;
    }
    var right = picked.value === q.dataset.answer;
    feedback.textContent = right ? 'Correct.' : 'Not quite — read why, then try again.';
    feedback.className = 'feedback ' + (right ? 'ok' : 'bad');
    if (why) why.classList.add('shown');
  });
});

// Free-recall blocks: reveal the model answer only after something is typed.
document.querySelectorAll('.recall').forEach(function (q) {
  var btn = q.querySelector('button');
  var box = q.querySelector('textarea');
  var ans = q.querySelector('.answer');
  btn.addEventListener('click', function () {
    if (box && box.value.trim().length < 10) {
      box.placeholder = 'Write your own answer first (one sentence is enough).';
      box.focus();
      return;
    }
    ans.classList.add('shown');
  });
});
