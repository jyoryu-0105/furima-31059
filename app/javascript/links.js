function links() {
  const link = document.getElementById("lists")
  
  link.addEventListener('mouseover', function(){
    link.setAttribute("style", "border-bottom: 1px solid")
  })

  link.addEventListener('mouseout', function(){
    link.removeAttribute("style","border-bottom: 1px solid")
  })
}

window.addEventListener('load', links)
