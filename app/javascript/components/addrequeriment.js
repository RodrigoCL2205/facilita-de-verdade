const initMenu = () => {
  const $menu = document.getElementById("menu");
  const $menuTrigger = document.getElementById("menu-trigger");
  const $fecharButton = document.getElementById("fechar");
  let state = $menu.dataset.aberto;


  $menuTrigger.addEventListener("click", () => {
    if(state == "false") {
      state = "true";
    } else {
      state = "false";
    }

    $menu.dataset.aberto = state;
  })

  $fecharButton.addEventListener("click", () => {
    state ="false";

    $menu.dataset.aberto = state;
  })
}

export {   initMenu };
