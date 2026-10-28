document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('form').forEach(form => {
    form.addEventListener('submit', () => {
      const button = form.querySelector('button[type="submit"], button:not([type])');
      if (button && !form.hasAttribute('data-no-loading')) {
        button.dataset.originalText = button.innerHTML;
        button.disabled = true;
        button.innerHTML = 'Please wait…';
        window.setTimeout(() => { if (button.isConnected) { button.disabled = false; button.innerHTML = button.dataset.originalText || 'Submit'; } }, 8000);
      }
    });
  });
});