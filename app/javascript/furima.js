function furima() {
  const articleText  = document.getElementById("item-price");
  articleText.addEventListener("input", () => {
    const countVal = articleText.value;
    const charNum  = document.getElementById("add-tax-price");
    const charNum2  = document.getElementById("profit");
    const taxPrice = Math.floor(countVal * 0.1);
    charNum.innerHTML = `${taxPrice} `;
    charNum2.innerHTML = `${Math.floor(countVal - taxPrice)} `;
  });
};

