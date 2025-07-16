import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    timeout: {
      default: 5000,
      type: Number,
    },
  };

  connect() {
    this.timeoutId = setTimeout(() => {
      this.dismiss();
    }, this.timeoutValue);
  }

  disconnect() {
    clearTimeout(this.timeoutId);
  }

  dismiss() {
    this.element.remove();
  }
}
