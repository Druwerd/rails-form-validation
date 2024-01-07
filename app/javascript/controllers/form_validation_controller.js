import { Controller } from "@hotwired/stimulus"
const debounce = require("lodash.debounce");

// Connects to data-controller="form-validation"
export default class extends Controller {
  // connect() {
  // }

  static targets = ["form", "output"];
  static values = { url: String };

  initialize() {
    this.handleChange = debounce(this.handleChange, 100).bind(this);
  }

  handleChange(event) {
    const formData = new FormData(this.formTarget)
    let input = event.target;
    fetch(this.urlValue, {
      method: "POST",
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: formData
    })
    .then(response => response.text())
    .then((html) => {
      document.querySelector('#error_explanation').innerHTML = html
      input = document.getElementById(input.id);
      this.moveCursorToEnd(input);
    })
  }

  // https://css-tricks.com/snippets/javascript/move-cursor-to-end-of-input/
  moveCursorToEnd(element) {
    if (typeof element.selectionStart == "number") {
      element.focus();
      element.selectionStart = element.selectionEnd = element.value.length;
    } else if (typeof element.createTextRange != "undefined") {
      element.focus();
      var range = element.createTextRange();
      range.collapse(false);
      range.select();
    }
  }
}
