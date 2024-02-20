document.addEventListener('DOMContentLoaded', function() {
  if (window.location.pathname === "/sms_messages/new") {
    var messageInput = document.getElementById("message-input");

    if (messageInput) {
      messageInput.addEventListener("input", function() {
        var message = this.value;
        var characterCount = message.length;
        document.getElementById("character-count").textContent = "Character count: " + characterCount;

        var segmentsCount = Math.ceil(characterCount / 160);
        document.getElementById("segments-count").textContent = "Segments count: " + segmentsCount;
      });
    }
  }
});
