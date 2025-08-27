import Cookies from "js-cookie";
import { uuidv7 } from "uuidv7";

const COOKIE_NAME = "cart_token";
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

function getCartToken() {
  return Cookies.get(COOKIE_NAME);
}

function setCartToken(cartToken) {
  Cookies.set(COOKIE_NAME, cartToken, cookieOptions());
}

document.addEventListener("DOMContentLoaded", () => {
  console.log("Cart token helper loaded");

  let cartToken = getCartToken();

  if (!cartToken) {
    cartToken = uuidv7();

    setCartToken(cartToken);

    console.log(`New cart token generated and stored in cookie: ${cartToken}`);
  } else {
    console.log(`Existing cart token found in cookie: ${cartToken}`);
  }
});
