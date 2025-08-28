import Cookies from "js-cookie";
import { uuidv7 } from "uuidv7";

const COOKIE_NAME = "customer_token";
const COOKIE_EXPIRATION_DAYS = 30;

function currentCatalogPath() {
  const [, catalogSlug] = window.location.pathname.split("/");

  return catalogSlug ? `/${catalogSlug}` : "/";
}

function cookieOptions() {
  const options = {
    expires: COOKIE_EXPIRATION_DAYS,
    path: currentCatalogPath(),
    sameSite: "lax",
  };

  if (window.location.protocol === "https:") {
    options.secure = true;
  }

  return options;
}

function getCustomerToken() {
  return Cookies.get(COOKIE_NAME);
}

function setCustomerToken(customerToken) {
  Cookies.set(COOKIE_NAME, customerToken, cookieOptions());
}

document.addEventListener("DOMContentLoaded", () => {
  console.log("Customer token helper loaded");

  let customerToken = getCustomerToken();

  if (!customerToken) {
    customerToken = uuidv7();

    setCustomerToken(customerToken);

    console.log(
      `New customer token generated and stored in cookie: ${customerToken}`,
    );
  } else {
    console.log(`Existing customer token found in cookie: ${customerToken}`);
  }
});
