const initMenu = () => {
  const $menu = document.getElementById("menu");
  const $menuTrigger = document.getElementById("menu-trigger");

  let state = $menu.dataset.aberto;
  console.log(state);


  $menuTrigger.addEventListener("click", () => {
    if(state == "false") {
      state = "true";
    } else {
      state = "false";
    }

    $menu.dataset.aberto = state;
  })
}

export {   initMenu };
