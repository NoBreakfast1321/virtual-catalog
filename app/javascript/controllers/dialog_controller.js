import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dialog"];

  close() {
    this.dialogTarget.close();
  }

  showModal() {
    this.dialogTarget.showModal();
  }
}
