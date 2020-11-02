function select() {
  const selectMenu = document.querySelectorAll(".mypage-nav-list-item")

  selectMenu.forEach((select) => {
    select.addEventListener('mouseover', () => {
      console.log("マウスオーバー");
    });
  })
}

window.addEventListener('load', select)
