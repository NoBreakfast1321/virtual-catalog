import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "preview"];
  static values = { images: Array };

  connect() {
    this.render();
  }

  preview() {
    this.imagesValue = [];

    const files = this.inputTarget.files;

    [...files].forEach((file) => {
      if (!file.type.startsWith("image/")) {
        return;
      }

      const reader = new FileReader();

      reader.onload = (event) => {
        this.imagesValue = [...this.imagesValue, event.target.result];

        this.render();
      };

      reader.readAsDataURL(file);
    });
  }

  render() {
    if (!this.hasPreviewTarget) {
      return;
    }

    this.previewTarget.innerHTML = "";

    this.imagesValue.forEach((src) => {
      const img = document.createElement("img");

      img.src = src;
      img.className =
        "size-32 rounded-md outline outline-1 -outline-offset-1 outline-gray-300";

      this.previewTarget.appendChild(img);
    });
  }
}
