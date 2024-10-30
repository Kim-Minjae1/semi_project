// 사이드바 메뉴 누르면 밑으로 서브메뉴 slide down하는 js
document.addEventListener("DOMContentLoaded", function() {
    const menuItems = document.querySelectorAll(".menu-item");

    menuItems.forEach(function(item) {
        const submenu = item.querySelector(".submenu");
        let isOpen = false;

        item.addEventListener("click", function(event) {
            event.preventDefault();

            // Toggle visibility of submenu
            if (isOpen) {
                submenu.style.animation = "slide-down 0.3s ease";

                setTimeout(function(){
                    submenu.style.display = "none";
                    submenu.style.animation = "";
                }, 300);

                isOpen = false;
            } else {
                submenu.style.display = "block";
                // Animate submenu opening by sliding down
                submenu.style.height = "auto";
                void submenu.offsetWidth;
                submenu.style.animation = "slide-down 0.3s ease";
                submenu.style.height = submenu.scrollHeight + "px";

                isOpen = true;
            }
        });
    });
});
