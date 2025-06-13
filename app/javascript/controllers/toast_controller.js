import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    timeout: {
      type: Number,
      default: 5000,
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
