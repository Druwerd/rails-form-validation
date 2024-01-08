import { Controller } from "@hotwired/stimulus"
const debounce = require("lodash.debounce");

// Connects to data-controller="form-validation"
export default class extends Controller {
  connect() {
  }

  static targets = ["form", "output"];
  static values = { url: String };

  initialize() {
    // use debounce so backend validations are called when a user stops typing
    this.handleChange = debounce(this.handleChange, 100).bind(this);
  }

  handleChange(event) {
    const formData = new FormData(this.formTarget)

    // call the backend form validation endpoint
    fetch(this.urlValue, {
      method: "POST",
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: formData
    })
    .then(response => response.text())
    .then((html) => {
      // update the page with errors html
      document.querySelector('#error_explanation').innerHTML = html
    })
  }
}
