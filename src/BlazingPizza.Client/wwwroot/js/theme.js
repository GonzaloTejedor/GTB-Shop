window.onload = () => {
    window.changeTheme = (theme) => {
        if (theme === "bright-theme") {
            document.body.classList.add("bright-theme");
            document.body.classList.remove("default-theme");
        } else {
            document.body.classList.add("default-theme");
            document.body.classList.remove("bright-theme");
        }
    };
};
