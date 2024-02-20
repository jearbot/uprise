document.addEventListener('DOMContentLoaded', function() {
  const alertMessageElement = document.getElementById('alert-modal-body');
  const successMessageElement = document.getElementById('success-modal-body');

  if (alertMessageElement) {
    const alertMessage = alertMessageElement.textContent.trim();
    if (alertMessage !== undefined && alertMessage !== "") {
      $('#alertModal').modal('show');
    }
  }

  if (successMessageElement) {
    const successMessage = successMessageElement.textContent.trim();
    if (successMessage !== undefined && successMessage !== "") {
      $('#successModal').modal('show');
    }
  }
});