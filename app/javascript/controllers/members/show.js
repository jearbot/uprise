document.addEventListener('DOMContentLoaded', function() {
  const membersPattern = /^\/members\/\d+$/;

  if (!membersPattern.test(window.location.pathname)) {
    return;
  }

  const addButton = document.getElementById('add-data');

  if (!addButton) {
    return;
  }

  addButton.addEventListener('click', function() {
    addData();
  });

  function addData() {
    const dataFieldsContainer = document.getElementById('data-fields');
    const newDataField = document.createElement('div');
    newDataField.innerHTML = `
      <div class="form-group">
        <label for="data_keys">New Key</label>
        <input type="text" class="form-control" name="data_keys[]" placeholder="New Key">
        <label for="data_values">New Value</label>
        <input type="text" class="form-control" name="data_values[]" placeholder="New Value">
      </div>
    `;
    dataFieldsContainer.appendChild(newDataField);
  }
});
