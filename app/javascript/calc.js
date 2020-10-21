function calc() {
  const price = document.getElementById("item-price")
  price.addEventListener('keyup', () => {
    const priceVal = price.value;
    const priceTax = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    priceTax.innerHTML = Math.floor(`${priceVal * 0.1}`);
    profit.innerHTML = Math.floor(`${priceVal * 0.9}`);
  });
}

window.addEventListener("load",calc);