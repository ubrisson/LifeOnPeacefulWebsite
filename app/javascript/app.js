let isLight = true;
const light = "theme-light";
const dark = "theme-dark";
document.getElementById("ThemeSwitchBtn").onclick = function () {
    if (isLight) {
        document.getElementById("html").classList.replace(light, dark);
    } else {
        document.getElementById("html").classList.replace(dark, light);
    }
    isLight = !isLight;
};

let folded = true;
document.getElementById("FoldBtn").onclick = function () {
    let details = document.getElementsByClassName("tika_details");
    for (let i = 0; i < details.length; i++) {
        details[i].open = folded;
    }
    folded = !folded;
};