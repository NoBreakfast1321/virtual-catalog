import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "hidden"];
  static values = {
    locale: String,
    currency: String,
  };

  connect() {
    if (!this.hiddenTarget.value) {
      return;
    }

    this.inputTarget.value = this.formatter.format(this.hiddenTarget.value);
  }

  format() {
    if (!this.inputTarget.value) {
      return;
    }

    const rawValue = this.inputTarget.value.replace(/\D/g, "");
    const value = rawValue / 100;

    this.inputTarget.value = this.formatter.format(value);
    this.hiddenTarget.value = value.toFixed(2);
  }

  get formatter() {
    return new Intl.NumberFormat(this.localeValue, {
      style: "currency",
      currency: this.currencyValue,
      minimumFractionDigits: 2,
      maximumFractionDigits: 2,
    });
  }
}
