import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment-toggle"
export default class extends Controller {
  static targets = ["formContainer"]
  connect() {
    console.log("test")
  }
  toggleForm() {
    this.formContainerTarget.classList.toggle("d-none")
    this.formContainerTarget.scrollIntoView({ behavior: 'smooth' });
  }
  resetForm(event) {
    event.currentTarget.reset()
    this.toggleForm()
  }
}
