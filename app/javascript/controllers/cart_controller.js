import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["select"];

  cart = [];

  add() {
    const variant = JSON.parse(this.selectTarget.value || null);

    if (!variant) {
      return;
    }

    const cartItem = this.cart.find((item) => {
      return item.id === variant.id;
    });

    if (cartItem) {
      cartItem.quantity += 1;
    } else {
      this.cart.push({ ...variant, quantity: 1 });
    }

    localStorage.setItem("cart", JSON.stringify(this.cart));
  }
}
