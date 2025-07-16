import { Controller } from "@hotwired/stimulus";

const FRACTION_DIGITS = 2;

export default class extends Controller {
  static targets = ["hidden", "input"];

  static values = {
    currency: String,
    locale: String,
  };

  get formatter() {
    return new Intl.NumberFormat(this.localeValue, {
      currency: this.currencyValue,
      maximumFractionDigits: FRACTION_DIGITS,
      minimumFractionDigits: FRACTION_DIGITS,
      style: "currency",
    });
  }

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

    this.hiddenTarget.value = value;
    this.inputTarget.value = this.formatter.format(value);
  }
}
